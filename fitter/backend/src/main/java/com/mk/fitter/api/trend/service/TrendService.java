package com.mk.fitter.api.trend.service;

import java.io.IOException;
import java.net.URI;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mk.fitter.api.trend.dto.HealthNewsDto;
import com.mk.fitter.api.trend.dto.HealthWordDto;
import com.mk.fitter.api.trend.dto.SportsWordDto;
import com.mk.fitter.api.trend.repository.HealthWordRepository;
import com.mk.fitter.api.trend.repository.SportsWordRepository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class TrendService {

    private final SportsWordRepository sportsWordRepository;
    private final HealthWordRepository healthWordRepository;

    @Value("${naver.api.url}")
    private String naverApiUrl;

    @Value("${naver.api.search.url}")
    private String naverSearchUrl;

    @Value("${naver.api.client.id}")
    private String naverClientId;

    @Value("${naver.api.client.secret}")
    private String naverClientSecret;


    @Transactional(readOnly = true)
    public List<SportsWordDto> getAllSports() {
        return  sportsWordRepository.findAllByOrderByCountDesc().stream()
                .map(SportsWordDto::new)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<HealthWordDto> getTop5Healths() {
        return healthWordRepository.findTop5ByOrderByCountDesc().stream()
            .map(HealthWordDto::new)
            .collect(Collectors.toList());
    }

    @Transactional
    public List<HealthNewsDto> getHealthNews(String keyword) {

        ByteBuffer buffer = StandardCharsets.UTF_8.encode(keyword);
        String encode = StandardCharsets.UTF_8.decode(buffer).toString();

        URI uri = UriComponentsBuilder
            .fromUriString(naverApiUrl)
            .path(naverSearchUrl)
            .queryParam("query", encode)
            .queryParam("display", 5) // 5개만
            .queryParam("start", 1) // 첫번째부터
            .queryParam("sort", "sim") // 정확도순
            .encode()
            .build()
            .toUri();

        RestTemplate restTemplate = new RestTemplate();

        RequestEntity<Void> req = RequestEntity
            .get(uri)
            .header("X-Naver-Client-Id", naverClientId)
            .header("X-Naver-Client-Secret", naverClientSecret)
            .build();

        ResponseEntity<String> result = restTemplate.exchange(req, String.class);
        String json = result.getBody();

        ObjectMapper objectMapper = new ObjectMapper();
        try {
            JsonNode rootNode = objectMapper.readTree(json);
            JsonNode itemsNode = rootNode.get("items");

            List<HealthNewsDto> newsItemsList = new ArrayList<>();

            for (JsonNode item : itemsNode) {
                String title = Jsoup.parse(item.get("title").asText()).text().replace("\"", " ");
                String link = Jsoup.parse(item.get("link").asText()).text();

                HealthNewsDto healthNewsDtoItem =
                    HealthNewsDto.builder()
                        .title(title)
                        .link(link)
                        .build();

                newsItemsList.add(healthNewsDtoItem);
            }

            return newsItemsList;

        } catch (IOException e) {
            e.printStackTrace();
        }

        return Collections.emptyList();  // 오류 발생 시 빈 리스트 반환
    }

}
