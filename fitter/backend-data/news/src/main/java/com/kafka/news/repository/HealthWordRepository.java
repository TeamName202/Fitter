package com.kafka.news.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kafka.news.entity.HealthWord;

@Repository
public interface HealthWordRepository extends JpaRepository<HealthWord, Integer> {
	Optional<HealthWord> findByName(String name);
}
