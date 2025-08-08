<?php
namespace App\Models;
use Database;
class MovieModel {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }

    // Method to get all movies
    public function getAll() {
        try {
            $stmt = $this->db->query("SELECT * FROM movies ORDER BY id DESC");
            return $stmt->fetchAll();
        } catch (\PDOException $e) {
            return [];
        }
    }

    // Method to find a single movie by its ID
    public function findById($id) {
        try {
            $stmt = $this->db->prepare("SELECT * FROM movies WHERE id = ?");
            $stmt->execute([$id]);
            return $stmt->fetch();
        } catch (\PDOException $e) {
            return false;
        }
    }

    // Method to create a new movie and return its ID
    public function createAndGetId($data) {
        try {
            $sql = "INSERT INTO movies (tmdb_id, title, overview, release_date, poster_path, backdrop_path, logo_path, runtime, trailer_key) 
                    VALUES (:tmdb_id, :title, :overview, :release_date, :poster_path, :backdrop_path, :logo_path, :runtime, :trailer_key)";
            
            $stmt = $this->db->prepare($sql);

            $stmt->execute([
                ':tmdb_id'       => $data['tmdb_id'] ?? null,
                ':title'         => $data['title'],
                ':overview'      => $data['overview'],
                ':release_date'  => !empty($data['release_date']) ? $data['release_date'] : null,
                ':poster_path'   => $data['poster_path'] ?? null,
                ':backdrop_path' => $data['backdrop_path'] ?? null,
                ':logo_path'     => $data['logo_path'] ?? null,
                ':runtime'       => $data['runtime'] ?? null,
                ':trailer_key'   => $data['trailer_key'] ?? null
            ]);
            return $this->db->lastInsertId();
        } catch (\PDOException $e) {
            die("Database Error: " . $e->getMessage());
        }
    }
    
    // Method to update an existing movie
    public function update($id, $data) {
        try {
            $sql = "UPDATE movies SET 
                        title = :title, 
                        overview = :overview, 
                        release_date = :release_date, 
                        poster_path = :poster_path, 
                        backdrop_path = :backdrop_path, 
                        logo_path = :logo_path,
                        runtime = :runtime,
                        video_url = :video_url,
                        trailer_key = :trailer_key
                    WHERE id = :id";

            $stmt = $this->db->prepare($sql);

            return $stmt->execute([
                ':id'            => $id,
                ':title'         => $data['title'],
                ':overview'      => $data['overview'],
                ':release_date'  => !empty($data['release_date']) ? $data['release_date'] : null,
                ':poster_path'   => $data['poster_path'] ?? null,
                ':backdrop_path' => $data['backdrop_path'] ?? null,
                ':logo_path'     => $data['logo_path'] ?? null,
                ':runtime'       => $data['runtime'] ?? null,
                ':video_url'     => $data['video_url'] ?? null,
                ':trailer_key'   => $data['trailer_key'] ?? null
            ]);
        } catch (\PDOException $e) {
            die("Database Error: " . $e->getMessage());
        }
    }

    // Method to sync genres for a specific movie
    public function syncGenres($movieId, $genreIds) {
        $stmt = $this->db->prepare("DELETE FROM movie_genres WHERE movie_id = ?");
        $stmt->execute([$movieId]);

        $stmt = $this->db->prepare("INSERT INTO movie_genres (movie_id, genre_id) VALUES (?, ?)");
        foreach ($genreIds as $genreId) {
            $stmt->execute([$movieId, $genreId]);
        }
    }

    // Method to sync cast for a specific movie
    public function syncCast($movieId, $castData) {
        $stmtDelete = $this->db->prepare("DELETE FROM movie_cast WHERE movie_id = ?");
        $stmtDelete->execute([$movieId]);

        $stmtInsert = $this->db->prepare("INSERT INTO movie_cast (movie_id, person_id, character_name, cast_order) VALUES (?, ?, ?, ?)");
        foreach ($castData as $castMember) {
            $stmtInsert->execute([$movieId, $castMember['person_id'], $castMember['character_name'], $castMember['order']]);
        }
    }

    // Method to delete a movie by its ID
    public function deleteById($id) {
        try {
            $stmt = $this->db->prepare("DELETE FROM movies WHERE id = ?");
            return $stmt->execute([$id]);
        } catch (\PDOException $e) {
            die("Database Error: " . $e->getMessage());
        }
    }

    public function countAll() {
        try {
            return $this->db->query("SELECT COUNT(*) FROM movies")->fetchColumn();
        } catch (\PDOException $e) { return 0; }
    }

    public function getLatest($limit) {
        try {
            $stmt = $this->db->prepare("SELECT * FROM movies ORDER BY release_date DESC LIMIT :limit");
            $stmt->bindParam(':limit', $limit, \PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll();
        } catch (\PDOException $e) {
            return [];
        }
    }
}