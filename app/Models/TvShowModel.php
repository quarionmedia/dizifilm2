<?php
namespace App\Models;
use Database;
class TvShowModel {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }

    // Method to get all TV shows
    public function getAll() {
        try {
            $stmt = $this->db->query("SELECT * FROM tv_shows ORDER BY id DESC");
            return $stmt->fetchAll();
        } catch (\PDOException $e) {
            return [];
        }
    }

    // Method to find a single TV show by its ID
    public function findById($id) {
        try {
            $stmt = $this->db->prepare("SELECT * FROM tv_shows WHERE id = ?");
            $stmt->execute([$id]);
            return $stmt->fetch();
        } catch (\PDOException $e) {
            return false;
        }
    }

    // Method to create a new TV show and return its ID
    public function createAndGetId($data) {
        try {
            $sql = "INSERT INTO tv_shows (tmdb_id, title, overview, first_air_date, poster_path, backdrop_path, logo_path, status, trailer_key) 
                    VALUES (:tmdb_id, :title, :overview, :first_air_date, :poster_path, :backdrop_path, :logo_path, :status, :trailer_key)";
            
            $stmt = $this->db->prepare($sql);

            $stmt->execute([
                ':tmdb_id'         => $data['id'],
                ':title'           => $data['name'],
                ':overview'        => $data['overview'],
                ':first_air_date'  => !empty($data['first_air_date']) ? $data['first_air_date'] : null,
                ':poster_path'     => $data['poster_path'] ?? null,
                ':backdrop_path'   => $data['backdrop_path'] ?? null,
                ':logo_path'       => $data['logo_path'] ?? null,
                ':status'          => $data['status'] ?? null,
                ':trailer_key'     => $data['trailer_key'] ?? null
            ]);
            return $this->db->lastInsertId();
        } catch (\PDOException $e) {
            die("Database Error: " . $e->getMessage());
        }
    }

    // Method to update an existing TV show
    public function update($id, $data) {
        try {
            $sql = "UPDATE tv_shows SET 
                        title = :title, 
                        overview = :overview, 
                        first_air_date = :first_air_date,
                        status = :status,
                        logo_path = :logo_path,
                        trailer_key = :trailer_key
                    WHERE id = :id";

            $stmt = $this->db->prepare($sql);

            return $stmt->execute([
                ':id'             => $id,
                ':title'          => $data['title'],
                ':overview'       => $data['overview'],
                ':first_air_date' => !empty($data['first_air_date']) ? $data['first_air_date'] : null,
                ':status'         => $data['status'] ?? null,
                ':logo_path'      => $data['logo_path'] ?? null,
                ':trailer_key'    => $data['trailer_key'] ?? null
            ]);
        } catch (\PDOException $e) {
            die("Database Error: " . $e->getMessage());
        }
    }

    // Method to delete a TV show by its ID
    public function deleteById($id) {
        try {
            $stmt = $this->db->prepare("DELETE FROM tv_shows WHERE id = ?");
            return $stmt->execute([$id]);
        } catch (\PDOException $e) {
            die("Database Error: " . $e->getMessage());
        }
    }
    
    // Method to sync genres for a specific TV show
    public function syncGenres($tvShowId, $genreIds) {
        $stmt = $this->db->prepare("DELETE FROM tv_show_genres WHERE tv_show_id = ?");
        $stmt->execute([$tvShowId]);

        $stmt = $this->db->prepare("INSERT INTO tv_show_genres (tv_show_id, genre_id) VALUES (?, ?)");
        foreach ($genreIds as $genreId) {
            $stmt->execute([$tvShowId, $genreId]);
        }
    }

    // Method to sync cast for a specific TV show
    public function syncCast($tvShowId, $castData) {
        $stmtDelete = $this->db->prepare("DELETE FROM tv_show_cast WHERE tv_show_id = ?");
        $stmtDelete->execute([$tvShowId]);

        $stmtInsert = $this->db->prepare("INSERT INTO tv_show_cast (tv_show_id, person_id, character_name, cast_order) VALUES (?, ?, ?, ?)");
        foreach ($castData as $castMember) {
            $stmtInsert->execute([$tvShowId, $castMember['person_id'], $castMember['character_name'], $castMember['order']]);
        }
    }

    public function countAll() {
        try {
            return $this->db->query("SELECT COUNT(*) FROM tv_shows")->fetchColumn();
        } catch (\PDOException $e) { return 0; }
    }

    public function getLatest($limit) {
        try {
            $stmt = $this->db->prepare("SELECT * FROM tv_shows ORDER BY first_air_date DESC LIMIT :limit");
            $stmt->bindParam(':limit', $limit, \PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll();
        } catch (\PDOException $e) {
            return [];
        }
    }
}