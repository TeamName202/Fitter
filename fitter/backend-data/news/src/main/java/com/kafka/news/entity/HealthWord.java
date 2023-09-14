package com.kafka.news.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@Entity
public class HealthWord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "health_word_id")
    private Integer id;

    @Column(nullable = false)
    private String name;

    private int count;

    @Builder
    public HealthWord(String name, int count){
        this.name = name;
        this.count = count;
    }
}
