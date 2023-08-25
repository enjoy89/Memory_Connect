package com.memory.connect.model.testResult.repository;

import com.memory.connect.model.testResult.entity.TestResult;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TestResultRepository extends JpaRepository<TestResult, Integer> {

}