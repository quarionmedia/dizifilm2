<?php

namespace App\Services;

use Config; // We introduce the Config class from the global scope to this file

class TMDbService {
    private $apiKey;
    private $baseUrl = 'https://api.themoviedb.org/3';

    public function __construct() {
        // This line will now work correctly
        $this->apiKey = Config::get('database.services.tmdb.api_key');
    }

    private function findBestLogo($images) {
        $logos = $images['logos'] ?? [];
        $bestLogo = null;
        
        // Prioritize English logos
        foreach ($logos as $logo) {
            if ($logo['iso_639_1'] === 'en') {
                $bestLogo = $logo;
                break;
            }
        }
        
        // If no English logo is found, take the first one available
        if (!$bestLogo && !empty($logos)) {
            $bestLogo = $logos[0];
        }
        
        return $bestLogo['file_path'] ?? null;
    }

    public function getMovieById($tmdbId) {
        if (empty($this->apiKey)) {
            return ['error' => 'TMDb API key is not set in config file.'];
        }

        $url = "{$this->baseUrl}/movie/{$tmdbId}?api_key={$this->apiKey}&language=en-US&append_to_response=credits,videos,images&include_image_language=en,null";
        
        $response = @file_get_contents($url);

        if ($response === FALSE) {
            return ['error' => 'Failed to fetch data from TMDb. Check TMDb ID.'];
        }

        $details = json_decode($response, true);
        
        // Find and add the best logo path to the details
        if (isset($details['images'])) {
            $details['logo_path'] = $this->findBestLogo($details['images']);
        }

        return $details;
    }

    public function getTvShowById($tmdbId) {
        if (empty($this->apiKey)) {
            return ['error' => 'TMDb API key is not set in config file.'];
        }

        $url = "{$this->baseUrl}/tv/{$tmdbId}?api_key={$this->apiKey}&language=en-US&append_to_response=credits,videos,images&include_image_language=en,null";
        
        $response = @file_get_contents($url);

        if ($response === FALSE) {
            return ['error' => 'Failed to fetch data from TMDb. Check TMDb ID.'];
        }

        $details = json_decode($response, true);

        // Find and add the best logo path to the details
        if (isset($details['images'])) {
            $details['logo_path'] = $this->findBestLogo($details['images']);
        }

        return $details;
    }

    public function getSeasonDetails($tvShowId, $seasonNumber) {
        if (empty($this->apiKey)) {
            return ['error' => 'TMDb API key is not set in config file.'];
        }

        $url = "{$this->baseUrl}/tv/{$tvShowId}/season/{$seasonNumber}?api_key={$this->apiKey}&language=en-US";
        
        $response = @file_get_contents($url);

        if ($response === FALSE) {
            return ['error' => 'Failed to fetch season data from TMDb.'];
        }

        return json_decode($response, true);
    }
}