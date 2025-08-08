<?php
use App\Controllers\HomeController;
use App\Controllers\AuthController;
use App\Controllers\AdminController;
class Router {
    public static function route($url) {
        $urlParts = explode('/', $url);

        // Home Page Route
        if ($url == '') {
            $controller = new HomeController();
            $controller->index();
        } 
        // Register Route
        elseif ($url == 'register') {
            $controller = new AuthController();
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                $controller->register();
            } else {
                $controller->showRegisterForm();
            }
        } 
        // Login Route
        elseif ($url == 'login') {
            $controller = new AuthController();
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                $controller->login();
            } else {
                $controller->showLoginForm();
            }
        }
        // Logout Route
        elseif ($url == 'logout') {
            $controller = new AuthController();
            $controller->logout();
        }
        // Admin Routes
        elseif ($urlParts[0] == 'admin') {
            
            // /admin
            if (!isset($urlParts[1])) {
                $controller = new AdminController();
                $controller->index();
            } 
            // /admin/movies/...
            elseif ($urlParts[1] == 'movies') {
                if (!isset($urlParts[2])) {
                    $controller = new AdminController();
                    $controller->listMovies();
                } 
                elseif ($urlParts[2] == 'add') {
                    $controller = new AdminController();
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->storeMovie();
                    } else {
                        $controller->showAddMovieForm();
                    }
                }
                elseif ($urlParts[2] == 'tmdb-import') {
                    $controller = new AdminController();
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->importFromTMDb();
                    }
                }
                elseif ($urlParts[2] == 'delete' && isset($urlParts[3])) {
                    $id = (int)$urlParts[3];
                    $controller = new AdminController();
                    $controller->deleteMovie($id);
                }
                elseif ($urlParts[2] == 'edit' && isset($urlParts[3])) {
                    $id = (int)$urlParts[3];
                    $controller = new AdminController();
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateMovie($id);
                    } else {
                        $controller->showEditMovieForm($id);
                    }
                }
            }
            // /admin/tv-shows/...
            elseif ($urlParts[1] == 'tv-shows') {
                if (!isset($urlParts[2])) {
                    $controller = new AdminController();
                    $controller->listTvShows();
                }
                elseif ($urlParts[2] == 'add') {
                    $controller = new AdminController();
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->storeTvShow();
                    } else {
                        $controller->showAddTvShowForm();
                    }
                }
                elseif ($urlParts[2] == 'tmdb-import') {
                    $controller = new AdminController();
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->importTvShowFromTMDb();
                    }
                }
                elseif ($urlParts[2] == 'import-seasons' && isset($urlParts[3]) && isset($urlParts[4])) {
                    $tvShowDbId = (int)$urlParts[3];
                    $tvShowTmdbId = (int)$urlParts[4];
                    $controller = new AdminController();
                    $controller->importSeasons($tvShowDbId, $tvShowTmdbId);
                }
                elseif ($urlParts[2] == 'edit' && isset($urlParts[3])) {
                    $id = (int)$urlParts[3];
                    $controller = new AdminController();
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateTvShow($id);
                    } else {
                        $controller->showEditTvShowForm($id);
                    }
                }
                elseif ($urlParts[2] == 'delete' && isset($urlParts[3])) {
                    $id = (int)$urlParts[3];
                    $controller = new AdminController();
                    $controller->deleteTvShow($id);
                }
            }

            // /admin/users/...
            elseif ($urlParts[1] == 'users') {
                $controller = new \App\Controllers\AdminController();

                // Edit and Update: /admin/users/edit/{id}
                if (isset($urlParts[2]) && $urlParts[2] == 'edit' && isset($urlParts[3])) {
                    $id = (int)$urlParts[3];
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateUser($id);
                    } else {
                        $controller->showEditUserForm($id);
                    }
                }
                // Delete: /admin/users/delete/{id}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'delete' && isset($urlParts[3])) {
                    $id = (int)$urlParts[3];
                    $controller->deleteUser($id);
                }
                // List: /admin/users
                else {
                    $controller->listUsers();
                }
            }

            // /admin/manage-seasons/{id}
            // /admin/manage-seasons/...
            // /admin/manage-seasons/...
            // /admin/manage-seasons/...
            elseif ($urlParts[1] == 'manage-seasons') {
                $controller = new \App\Controllers\AdminController();

                // Düzenleme rotası: GET|POST /admin/manage-seasons/edit/{seasonId}
                if (isset($urlParts[2]) && $urlParts[2] == 'edit' && isset($urlParts[3])) {
                    $seasonId = (int)$urlParts[3];
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateSeason($seasonId);
                    } else {
                        $controller->showEditSeasonForm($seasonId);
                    }
                }
                // Silme rotası: GET /admin/manage-seasons/delete/{seasonId}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'delete' && isset($urlParts[3])) {
                    $seasonId = (int)$urlParts[3];
                    $controller->deleteSeason($seasonId);
                }
                // Manuel sezon ekleme rotası: POST /admin/manage-seasons/add/{tvShowId}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'add' && isset($urlParts[3])) {
                    $tvShowId = (int)$urlParts[3];
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->storeManualSeason($tvShowId);
                    }
                }
                // Sezon listeleme sayfası: GET /admin/manage-seasons/{tvShowId}
                elseif (isset($urlParts[2])) {
                    $id = (int)$urlParts[2];
                    $controller->manageSeasons($id);
                }
            }

            // /admin/manage-episodes/{seasonId}
            // /admin/manage-episodes/...
            elseif ($urlParts[1] == 'manage-episodes') {
                $controller = new \App\Controllers\AdminController();

                // Düzenleme rotası: POST /admin/manage-episodes/edit/{episodeId}
                if (isset($urlParts[2]) && $urlParts[2] == 'edit' && isset($urlParts[3])) {
                    $episodeId = (int)$urlParts[3];
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateEpisodeDetails($episodeId);
                    }
                }
                // Silme rotası: GET /admin/manage-episodes/delete/{episodeId}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'delete' && isset($urlParts[3])) {
                    $episodeId = (int)$urlParts[3];
                    $controller->deleteEpisode($episodeId);
                }
                // Manuel bölüm ekleme rotası: POST /admin/manage-episodes/add/{seasonId}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'add' && isset($urlParts[3])) {
                    $seasonId = (int)$urlParts[3];
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->storeManualEpisode($seasonId);
                    }
                }
                // Bölümleri çekme rotası: GET /admin/manage-episodes/fetch/{seasonId}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'fetch' && isset($urlParts[3])) {
                    $seasonId = (int)$urlParts[3];
                    $controller->fetchEpisodesForSeason($seasonId);
                }
                // Bölüm listeleme sayfası: GET /admin/manage-episodes/{seasonId}
                elseif (isset($urlParts[2])) {
                    $seasonId = (int)$urlParts[2];
                    $controller->manageEpisodes($seasonId);
                }
            }

            // /admin/manage-episode-links/...
            elseif ($urlParts[1] == 'manage-episode-links') {
                $controller = new \App\Controllers\AdminController();

                // Silme rotası: /admin/manage-episode-links/delete/{linkId}/{episodeId}
                if (isset($urlParts[2]) && $urlParts[2] == 'delete' && isset($urlParts[3]) && isset($urlParts[4])) {
                    $linkId = (int)$urlParts[3];
                    $episodeId = (int)$urlParts[4];
                    $controller->deleteEpisodeLink($linkId, $episodeId);
                }
                // Listeleme ve Ekleme rotası: /admin/manage-episode-links/{episodeId}
                elseif (isset($urlParts[2])) {
                    $episodeId = (int)$urlParts[2];
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->storeEpisodeLink($episodeId);
                    } else {
                        $controller->showEpisodeLinksManager($episodeId);
                    }
                }
            }

            // /admin/manage_subtitles/... (Unified for both movies and episodes)
            elseif ($urlParts[1] == 'manage_subtitles') {
                $controller = new \App\Controllers\AdminController();

                // Delete route: /admin/manage_subtitles/delete/{subtitleId}/{linkId}
                if (isset($urlParts[2]) && $urlParts[2] == 'delete' && isset($urlParts[3]) && isset($urlParts[4])) {
                    $subtitleId = (int)$urlParts[3];
                    $linkId = (int)$urlParts[4];
                    $controller->deleteSubtitle($subtitleId, $linkId);
                }
                // List and Add routes: /admin/manage_subtitles/{linkId}
                elseif (isset($urlParts[2])) {
                    $linkId = (int)$urlParts[2];
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->storeSubtitle($linkId);
                    } else {
                        $controller->showSubtitleManager($linkId);
                    }
                }
            }
            
             // /admin/episodes/...
             elseif ($urlParts[1] == 'episodes') {
                if ($urlParts[2] == 'edit' && isset($urlParts[3])) {
                    $id = (int)$urlParts[3];
                    $controller = new AdminController();
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateEpisode($id);
                    } else {
                        $controller->showEditEpisodeForm($id);
                    }
                }
            }

            // /admin/manage-movie-links/...
            elseif ($urlParts[1] == 'manage-movie-links') {
                $controller = new \App\Controllers\AdminController();

                // Edit rotası: /admin/manage-movie-links/edit/{linkId}
                if (isset($urlParts[2]) && $urlParts[2] == 'edit' && isset($urlParts[3])) {
                    $linkId = (int)$urlParts[3];
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateMovieLink($linkId);
                    } else {
                        $controller->showEditMovieLinkForm($linkId);
                    }
                }
                // Silme rotası: /admin/manage-movie-links/delete/{linkId}/{movieId}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'delete' && isset($urlParts[3]) && isset($urlParts[4])) {
                    $linkId = (int)$urlParts[3];
                    $movieId = (int)$urlParts[4];
                    $controller->deleteMovieLink($linkId, $movieId);
                }
                // Listeleme ve Ekleme rotası: /admin/manage-movie-links/{movieId}
                elseif (isset($urlParts[2])) {
                    $movieId = (int)$urlParts[2];
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->storeMovieLink($movieId);
                    } else {
                        $controller->showMovieLinksManager($movieId);
                    }
                }
            }
            // /admin/menu/...
            elseif ($urlParts[1] == 'menu') {
                // /admin/menu
                if (!isset($urlParts[2])) {
                    $controller = new AdminController();
                    $controller->listMenuItems();
                }
                // /admin/menu/add
                elseif ($urlParts[2] == 'add') {
                    $controller = new AdminController();
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->storeMenuItem();
                    } else {
                        $controller->showAddMenuItemForm();
                    }
                }
            }

                 // /admin/users/...
              elseif ($urlParts[1] == 'users') {
              $controller = new \App\Controllers\AdminController();

              // Edit and Update: /admin/users/edit/{id}
              if (isset($urlParts[2]) && $urlParts[2] == 'edit' && isset($urlParts[3])) {
                $id = (int)$urlParts[3];
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateUser($id);
                               } else {
                             $controller->showEditUserForm($id);
                         }

                          // Delete: /admin/users/delete/{id}
                         } elseif (isset($urlParts[2]) && $urlParts[2] == 'delete' && isset($urlParts[3])) {
                        $id = (int)$urlParts[3];
                          $controller->deleteUser($id);

                             // List: /admin/users
                      } else {
                              $controller->listUsers();
                      }
                    }

                    // /admin/comments/...
            elseif ($urlParts[1] == 'comments') {
                $controller = new \App\Controllers\AdminController();

                // Approve: /admin/comments/approve/{id}
                if (isset($urlParts[2]) && $urlParts[2] == 'approve' && isset($urlParts[3])) {
                    $controller->approveComment((int)$urlParts[3]);
                }
                // Unapprove: /admin/comments/unapprove/{id}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'unapprove' && isset($urlParts[3])) {
                    $controller->unapproveComment((int)$urlParts[3]);
                }
                // Delete: /admin/comments/delete/{id}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'delete' && isset($urlParts[3])) {
                    $controller->deleteComment((int)$urlParts[3]);
                }
                // List: /admin/comments
                else {
                    $controller->listComments();
                }
            }

            // /admin/reports/...
            elseif ($urlParts[1] == 'reports') {
                $controller = new \App\Controllers\AdminController();

                // Mark as resolved: /admin/reports/resolve/{id}
                if (isset($urlParts[2]) && $urlParts[2] == 'resolve' && isset($urlParts[3])) {
                    $controller->resolveReport((int)$urlParts[3]);
                }
                // Delete: /admin/reports/delete/{id}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'delete' && isset($urlParts[3])) {
                    $controller->deleteReport((int)$urlParts[3]);
                }
                // List: /admin/reports
                else {
                    $controller->listReports();
                }
            }

            // /admin/requests/...
            elseif ($urlParts[1] == 'requests') {
                $controller = new \App\Controllers\AdminController();

                // Durumu güncelleme rotası: /admin/requests/update-status/{id}/{status}
                if (isset($urlParts[2]) && $urlParts[2] == 'update-status' && isset($urlParts[3]) && isset($urlParts[4])) {
                    $requestId = (int)$urlParts[3];
                    $status = $urlParts[4]; // status bir string olduğu için int'e çevirmiyoruz
                    $controller->updateRequestStatus($requestId, $status);
                }
                // Silme rotası: /admin/requests/delete/{id}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'delete' && isset($urlParts[3])) {
                    $controller->deleteRequest((int)$urlParts[3]);
                }
                // Listeleme rotası: /admin/requests
                else {
                    $controller->listRequests();
                }
            }
            
                     // /admin/settings/...
            
            elseif ($urlParts[1] == 'settings') {
                $controller = new AdminController();
                
                $page = $urlParts[2] ?? 'general'; // Varsayılan sayfa 'general' olsun

                if ($page == 'general') {
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateGeneralSettings();
                    } else {
                        $controller->showGeneralSettingsForm();
                    }
                }
                elseif ($page == 'api') {
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateApiSettings();
                    } else {
                        $controller->showApiSettingsForm();
                    }
                }
                elseif ($page == 'security') {
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateSecuritySettings();
                    } else {
                        $controller->showSecuritySettingsForm();
                    }
                }
                // Eski rotaları koruyalım
                elseif ($page == 'test-mail') {
                    $controller->sendTestEmail();
                }
                elseif ($page == 'email-templates') {
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateEmailTemplates();
                    } else {
                        $controller->showEmailTemplatesForm();
                    }
                }
            }

            // /admin/ads-settings
            elseif ($urlParts[1] == 'ads-settings') {
                $controller = new \App\Controllers\AdminController();
                if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                    $controller->updateAdsSettings();
                } else {
                    $controller->showAdsSettingsForm();
                }
            }

            // /admin/genres/...
            elseif ($urlParts[1] == 'genres') {
                $controller = new \App\Controllers\AdminController();

                // Add Genre: /admin/genres/add
                if (isset($urlParts[2]) && $urlParts[2] == 'add') {
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->storeGenre();
                    } else {
                        $controller->showAddGenreForm();
                    }
                }
                // Edit and Update Genre: /admin/genres/edit/{id}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'edit' && isset($urlParts[3])) {
                    $id = (int)$urlParts[3];
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateGenre($id);
                    } else {
                        $controller->showEditGenreForm($id);
                    }
                }
                // Delete Genre: /admin/genres/delete/{id}
                elseif (isset($urlParts[2]) && $urlParts[2] == 'delete' && isset($urlParts[3])) {
                    $id = (int)$urlParts[3];
                    $controller->deleteGenre($id);
                }
                // List Genres: /admin/genres
                else {
                    $controller->listGenres();
                }
            }

            // /admin/content-networks
            elseif ($urlParts[1] == 'content-networks') {
                $controller = new \App\Controllers\AdminController();
                if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                    $controller->updateContentNetworks();
                } else {
                    $controller->showContentNetworksForm();
                }
            }

            // /admin/platforms/...
            elseif ($urlParts[1] == 'platforms') {
                $controller = new \App\Controllers\AdminController();
                if (isset($urlParts[2]) && $urlParts[2] === 'delete' && isset($urlParts[3])) {
                    $controller->deletePlatform((int)$urlParts[3]);
                }
                elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
                    $controller->storePlatform();
                }
                else {
                    $controller->listPlatforms();
                }
            }

            // /admin/smtp-settings
            elseif ($urlParts[1] == 'smtp-settings') {
                $controller = new AdminController();
                if (isset($urlParts[2]) && $urlParts[2] == 'test-mail') {
                    $controller->sendTestEmail();
                } else {
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateSmtpSettings();
                    } else {
                        $controller->showSmtpSettingsForm();
                    }
                }
            }

            elseif ($urlParts[2] == 'delete' && isset($urlParts[3])) {
                    $id = (int)$urlParts[3];
                    $controller = new AdminController();
                    $controller->deleteMenuItem($id);
                }

                // /admin/menu/edit/{id}
            elseif ($urlParts[2] == 'edit' && isset($urlParts[3])) {
                    $id = (int)$urlParts[3];
                    $controller = new AdminController();
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $controller->updateMenuItem($id);
                    } else {
                        $controller->showEditMenuItemForm($id);
                    }
                }
        }
        // 404 Not Found
        else {
            http_response_code(404);
            echo '404 - Page Not Found';
        }
    }
}