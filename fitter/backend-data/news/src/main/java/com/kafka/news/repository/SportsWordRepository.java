package com.kafka.news.repository;

import java.util.Optional;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.kafka.news.entity.SportsWord;

@Repository
public interface SportsWordRepository extends JpaRepository<SportsWord, Integer> {

	Optional<SportsWord> findByName(String name);

	@Query("SELECT sw.name FROM SportsWord sw")
	Set<String> findAllNames();

	@Modifying
	@Query("UPDATE SportsWord sw SET sw.count = 0")
	void resetCountToZero();
}
