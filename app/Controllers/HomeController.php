<?php
namespace App\Controllers;

use App\Models\UserModel;
use App\Models\HomepageModel;
use App\Models\ContentNetworkModel;
use App\Models\MovieModel;
use App\Models\TvShowModel;

class HomeController {
    public function index() {
        $userModel = new UserModel();
        $userCount = $userModel->countAllUsers();
        
        $homepageModel = new HomepageModel();
        $sections = $homepageModel->getAllSections();

        $networkModel = new ContentNetworkModel();
        $platforms = $networkModel->getAll();

        $movieModel = new MovieModel();
        $latestMovies = $movieModel->getLatest(10); // Get the last 10 movies

        $tvShowModel = new TvShowModel();
        $latestTvShows = $tvShowModel->getLatest(10); // Get the last 10 series

        $data = [
            'title' => 'Homepage | MuvixTV',
            'userCount' => $userCount,
            'sections' => $sections,
            'platforms' => $platforms,
            'latestMovies' => $latestMovies,
            'latestTvShows' => $latestTvShows
        ];

        return view('home', $data);
    }
}