package com.memory.connect.model.place.repository;

import com.memory.connect.model.place.entity.Place;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PlaceRepository extends JpaRepository<Place, Long> {
}
