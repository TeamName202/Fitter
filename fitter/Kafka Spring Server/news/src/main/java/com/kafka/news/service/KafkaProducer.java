package com.kafka.news.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class KafkaProducer {
	private static final String TOPIC = "keyword";
	private final KafkaTemplate<String, String> kafkaTemplate;
	private final KafkaTemplate<String, String> kafkaDonga;
	private final KafkaTemplate<String, String> kafkaChosun;
	private final KafkaTemplate<String, String> kafkaNaver;
	private final KafkaTemplate<String, String> kafkaJoongang;

	public void sendMessage(String message) {
		System.out.println(String.format("Producer message : %s \n", message));
		this.kafkaTemplate.send(TOPIC, message);
	}

	public void sendDonga() {
		String yesterday = LocalDate.now().minusDays(1).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		File csv = new File("C:\\Users\\SSAFY\\PycharmProjects\\pythonProject\\output\\DongaNews" + yesterday + ".csv");
		String line;
		try (BufferedReader br = new BufferedReader(new FileReader(csv))) {
			while ((line = br.readLine()) != null) {
				if (line.isEmpty())
					continue;
				String[] split = line.split(";");
				if (split.length < 3)
					continue;
				kafkaDonga.send(TOPIC, split[2]);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void sendChosun() {
		String yesterday = LocalDate.now().minusDays(1).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		File csv = new File(
			"C:\\Users\\SSAFY\\PycharmProjects\\pythonProject\\output\\WeeklyChosun" + yesterday + ".csv");
		String line;
		try (BufferedReader br = new BufferedReader(new FileReader(csv))) {
			while ((line = br.readLine()) != null) {
				if (line.isEmpty())
					continue;

				String[] split = line.split(";");
				if (split.length < 3)
					continue;
				kafkaChosun.send(TOPIC, split[2]);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void sendJoongang() {
		String yesterday = LocalDate.now().minusDays(1).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		File csv = new File(
			"C:\\Users\\SSAFY\\PycharmProjects\\pythonProject\\output\\JoongangSportsNews" + yesterday + ".csv");
		String line;
		try (BufferedReader br = new BufferedReader(new FileReader(csv))) {
			while ((line = br.readLine()) != null) {
				if (line.isEmpty())
					continue;
				String[] split = line.split(";");
				if (split.length < 3)
					continue;
				kafkaJoongang.send(TOPIC, split[2]);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void sendNaver() {
		String yesterday = LocalDate.now().minusDays(1).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		File csv = new File(
			"C:\\Users\\SSAFY\\PycharmProjects\\pythonProject\\output\\NaverSportsGeneral" + yesterday + ".csv");
		String line;
		try (BufferedReader br = new BufferedReader(new FileReader(csv))) {
			while ((line = br.readLine()) != null) {
				if (line.isEmpty())
					continue;
				String[] split = line.split(";");
				kafkaNaver.send(TOPIC, split[6]);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
