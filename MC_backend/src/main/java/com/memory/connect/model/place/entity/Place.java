package com.memory.connect.model.place.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "place")
public class Place {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "place_id")
    private int id;

    @Column(name = "place_name")
    private String name;

    @Column(name = "place_location")
    private String location;

    @Column(name = "place_latitude")
    private Double latitude;

    @Column(name = "place_longitude")
    private Double longitude;
}
