package com.example.demo.repository;

import com.example.demo.model.Movie;
import org.springframework.data.mongodb.repository.MongoRepository;


public interface MovieRepos extends MongoRepository<Movie, Integer>  {
}
