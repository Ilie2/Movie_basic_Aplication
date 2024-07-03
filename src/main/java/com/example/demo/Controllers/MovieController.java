package com.example.demo.Controllers;

import com.example.demo.model.Movie;
import com.example.demo.repository.MovieRepos;
import com.example.demo.services.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
@RequestMapping("/ai/movie")
public class MovieController {
    @Autowired
    private MovieService movieService;
    @Autowired
    private MovieRepos movieRepos;

    @PostMapping("/addmovie1")
    public ResponseEntity<Movie> createMovie(@RequestBody Movie movie) {
        if (movie.getTitle() == null || movie.getAuthor() == null || movie.getGenre() == null || movie.getYear() == 0 || movie.getImg() == null || movie.getUrl() == null) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        Movie savedMovie = movieRepos.save(movie);
        return new ResponseEntity<>(savedMovie, HttpStatus.CREATED);
    }

    @PostMapping("/delete")
    public void deleteMovie(@RequestBody Movie movie){
        movieService.delete(movie);
    }

    @PutMapping("/update")
    public ResponseEntity<Movie> updateMovie(@RequestBody Movie movie){
        if (movie.getId() == null) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        Movie updatedMovie = movieRepos.save(movie);
        return new ResponseEntity<>(updatedMovie, HttpStatus.OK);
    }

    @GetMapping
    public ResponseEntity<List<Movie>> getAllMovies() {
        List<Movie> movies = movieService.findAll();
        return new ResponseEntity<>(movies, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public Movie getMovieById(@PathVariable Integer id) {
        return movieRepos.findById(id).orElse(null);
    }
}
