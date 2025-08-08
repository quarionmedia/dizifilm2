-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 08 Ağu 2025, 23:05:26
-- Sunucu sürümü: 10.4.32-MariaDB
-- PHP Sürümü: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `muvixtvdb`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `episode_id` int(11) DEFAULT NULL,
  `comment_text` text NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `content_networks`
--

CREATE TABLE `content_networks` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `email_templates`
--

CREATE TABLE `email_templates` (
  `id` int(11) NOT NULL,
  `template_name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `email_templates`
--

INSERT INTO `email_templates` (`id`, `template_name`, `subject`, `body`) VALUES
(1, 'welcome_email', 'Welcome to {{site_name}}!', '<h1>Hi {{user_name}},</h1><p>Thank you for registering at {{site_name}}. We are excited to have you!</p>'),
(2, 'password_reset', 'Password Reset Request for {{site_name}}', '<h1>Password Reset</h1><p>You requested a password reset. Please click the following link: <a href=\"{{reset_link}}\">Reset Password</a></p>'),
(3, 'login_otp', 'Your Login OTP for {{site_name}}', 'Your One-Time Password for logging in is: <strong>{{otp_code}}</strong>'),
(4, 'signup_otp', 'Your Signup OTP for {{site_name}}', 'Your One-Time Password for signing up is: <strong>{{otp_code}}</strong>'),
(5, 'subscription_purchase', 'Your Subscription on {{site_name}}', '<h1>Hi {{user_name}},</h1><p>Thank you for your subscription. Your plan is now active.</p>');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `episodes`
--

CREATE TABLE `episodes` (
  `id` int(11) NOT NULL,
  `season_id` int(11) NOT NULL,
  `tmdb_episode_id` int(11) DEFAULT NULL,
  `episode_number` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `overview` text DEFAULT NULL,
  `still_path` varchar(255) DEFAULT NULL,
  `air_date` date DEFAULT NULL,
  `runtime` int(11) DEFAULT NULL,
  `is_downloadable` tinyint(1) NOT NULL DEFAULT 0,
  `type` varchar(50) NOT NULL DEFAULT 'free',
  `status` varchar(50) NOT NULL DEFAULT 'publish',
  `video_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `episodes`
--

INSERT INTO `episodes` (`id`, `season_id`, `tmdb_episode_id`, `episode_number`, `name`, `overview`, `still_path`, `air_date`, `runtime`, `is_downloadable`, `type`, `status`, `video_url`) VALUES
(2468, 136, 63339, 1, 'Days Gone Bye', 'Rick searches for his family after emerging from a coma into a world terrorized by the walking dead. Morgan and Duane, whom he meets along the way, help teach Rick the new rules for survival.', '/9ySQwesIgS804Au9vbWk9tUOp9p.jpg', '2010-10-31', 68, 0, 'free', 'publish', NULL),
(2469, 136, 63337, 2, 'Guts', 'Rick unknowingly causes a group of survivors to be trapped by walkers. The group dynamic devolves from accusations to violence, as Rick must confront an enemy far more dangerous than the undead.', '/9wGCjzZMAd7wS4LrxJadQPUelnn.jpg', '2010-11-07', 44, 0, 'free', 'publish', NULL),
(2470, 136, 63338, 3, 'Tell It to the Frogs', 'After returning to the camp with the department store survivors and an emotional reunion with his wife and son, Rick decides to go against Shane\'s advice and go back to Atlanta for Merle Dixon and his dropped bag of guns accompanied by Merle\'s younger brother, Darryl Dixon, as well as Glenn and T-Dog.', '/id5zyIRWig8wSE1cdj2TUil3xF0.jpg', '2010-11-14', 45, 0, 'free', 'publish', NULL),
(2471, 136, 63336, 4, 'Vatos', 'Rick, Glenn, T-Dog, and Daryl move on after their grisly discovery to retrieve the guns when they encounter a group of scavengers who narrowly beat them to the catch. However, Glenn is kidnapped in the scuffle, which leads to a tense stand-off and a surprising discovery. Meanwhile, back at camp, the group has to handle a serious situation when Jim begins acting unhinged.', '/9O7eh9MarFfiSo54IHlxhpC9dVi.jpg', '2010-11-21', 45, 0, 'free', 'publish', NULL),
(2472, 136, 63340, 5, 'Wildfire', 'Everyone deals with the fallout of the walker attack. Andrea has to come to grips with the fate of her sister, while Jim is found out to have been bitten. With the camp clearly no longer safe, a decision must made about the direction they are to take.', '/iuyqfagPbhEmF6yaPWmEMgKsQkd.jpg', '2010-11-28', 45, 0, 'free', 'publish', NULL),
(2473, 136, 63341, 6, 'TS-19', 'Rick and the group are allowed into the CDC by a strange doctor, but all is not what it seems in their newfound haven.', '/qOsfqcIURwZlP6umsosjE4nxhrj.jpg', '2010-12-05', 45, 0, 'free', 'publish', NULL),
(2475, 130, 333924, 1, 'Pilot (1)', 'Stripped of everything, the 48 survivors scavenge what they can from the plane for their survival. Some panic. Some pin their hopes on rescue. A few find inner strength they never knew they had-like Kate who, with no medical training, suddenly finds herself suturing the doctor\'s wounds. The band of friends, family, enemies and strangers must work together against the cruel weather and harsh terrain. But the intense howls of  mysterious creatures stalking the jungle fill them all with fear. Fortunately, thanks to the calm leadership of quick-thinking Jack and level-headed Kate, they have hope. But even heroes have secrets, as the survivors will come to learn.', '/rCpeXRevfKiJZf2mB8foGX5ikYg.jpg', '2004-09-22', 42, 0, 'free', 'publish', NULL),
(2476, 130, 333946, 2, 'Pilot (2)', 'Having escaped the \"creature\" and retrieved the plane transceiver, a group of the survivors travel to higher ground so they can transmit a signal. En route, they receive a mysterious transmission and encounter another of the island\'s inhabitants. Meanwhile, back at camp, Jack tends to a wounded man who reveals a secret about Kate.', '/bqYBx52UHGSX1ZR7LPmNZOq4ld1.jpg', '2004-09-29', 41, 0, 'free', 'publish', NULL),
(2477, 130, 333925, 3, 'Tabula Rasa', 'Jack and Hurley discover an alarming secret about Kate, as the marshal\'s life hangs in the balance and he suffers a lot of pain. Meanwhile Kate, Charlie, Sawyer, Sayid, Boone and Shannon ponder the mysteries they have begun to uncover and worry that telling the other survivors will cause panic. They decide to lie for the time being. Also, Locke\'s befriending of Walt disturbs Michael, but Walt is more concerned in finding his dog. Lastly, Kate flashes back to when she was arrested by the marshal in Australia.', '/uLxEjIirvwwfXFV9OtSi7HVzeTW.jpg', '2004-10-06', 44, 0, 'free', 'publish', NULL),
(2478, 130, 333926, 4, 'Walkabout', 'The survivors are jolted awake in the middle of the night when wild island beasts (which are wild boars) invade the beach encampment. Kate and Michael join the mysterious Locke on a hunt for food -- and a shocking secret about Locke is revealed. On the hunt for food someone is injured. Meanwhile, some survivors are horrified by Jack\'s plan for the dead bodies still scattered among the wreckage -- he wants to burn them. Jack sees someone that\'s not there, and we find out that one of the survivors was not able to walk but now he can.', '/o7yveE76RtUTRIyouCaTAh9wxUd.jpg', '2004-10-13', 43, 0, 'free', 'publish', NULL),
(2479, 130, 333927, 5, 'White Rabbit', 'Jack is nearly delirious from lack of sleep and struggles to overcome the haunting events that brought him to Australia and, subsequently, to the island. Meanwhile, Boone gets caught in a treacherous riptide trying to save a woman who went out swimming. A pregnant Claire\'s health takes a bad turn from lack of fluids, and a thief may have stolen the last bottles of water. Veronica Hamel guest-stars as Jack\'s mother, Margo.\n\nAlso, Jack flashes back at 12 years old, to find himself on the playground in an altercation with a bully, who ultimately beats him up, and later learns a life lesson from his father.', '/5x9oqSFvWUaSjyxgxtAdTX02Awh.jpg', '2004-10-20', 43, 0, 'free', 'publish', NULL),
(2480, 130, 333930, 6, 'House of the Rising Sun', 'Walt and the others are shocked when Michael is brutally beaten, but only the non-English-speaking Jin and Sun know the truth behind the attack. Meanwhile Kate, Jack, Sawyer and Sayid argue about where the survivors should camp -- on the beach, where they\'re more likely to be seen, or in a remote inland valley where fresh water abounds; and Locke discovers Charlie\'s secret.', '/jz26Xdp1URCitWEm6cZZJlRnVK7.jpg', '2004-10-27', 43, 0, 'free', 'publish', NULL),
(2481, 130, 333929, 7, 'The Moth', 'Charlie begins a painful journey of withdrawal from drugs, surprisingly aided by Locke, whose true motive for helping Charlie is a mystery. Meanwhile, survivors struggle to find and free Jack when he\'s buried alive in a cave collapse, and someone might be secretly thwarting Sayid, Kate, and Boone when they enact a plan to find the source of the French transmission.', '/5uERAOo4w73rLXzlkPW00wxSz2v.jpg', '2004-11-03', 44, 0, 'free', 'publish', NULL),
(2482, 130, 333928, 8, 'Confidence Man', 'Shannon\'s inhaler runs out and Boone believes Sawyer has the remaining three in his stash. When Sawyer refuses to give them up, Jack and Sayid resort to torturing Sawyer until he agrees to reveal the location of the inhalers. In flashback we hear Sawyer\'s story and find he is not who he says he is.', '/89pCqO5ZbeJJQYe5gY0VpJxfWCS.jpg', '2004-11-10', 44, 0, 'free', 'publish', NULL),
(2483, 130, 333945, 9, 'Solitary', 'Sayid\'s life is placed in grave danger after he stumbles upon the source of the mysterious French transmission, the woman Danielle Rousseau (guest-star Mira Furlan). She was on the distress call and is found alive. Meanwhile, Hurley has a ridiculous plan to make life on the island a little more civilized.  The plan involves golf clubs he finds in the debris, and it looks like it just might work.  Lastly, we flash back to Sayid\'s childhood friend Nadia as well as his participation in hostage situations in Iraq.', '/jMFm4Z5sjjZj9PZdQONjjEcsfpU.jpg', '2004-11-17', 44, 0, 'free', 'publish', NULL),
(2484, 130, 333931, 10, 'Raised by Another', 'Claire has a horribly realistic nightmare about her new baby being harmed or kidnapped. Flashbacks reveal Claire\'s backstory: the former boyfriend who got her pregnant, then abandoned her, and the psychic who convinced her to take the ill-fated flight that landed her on the island.  Hurley is shocked and confused when he discovers that Ethan Rom (guest-star William Mapother), another plane crash survivor, does not appear on the flight manifest.', '/xuHAWvErvWPUjHyyB5eDuQr0B3o.jpg', '2004-12-01', 43, 0, 'free', 'publish', NULL),
(2485, 130, 333932, 11, 'All the Best Cowboys Have Daddy Issues', 'Survivors wonder why Charlie and Claire have been abducted - and by whom - and a search party ventures into the treacherous jungle to look for the pair. Suspicions focus on Ethan Rom (guest-star William Mapother), who, it was recently discovered, was not a passenger on the doomed flight.  Jack battles inner demons relating to his father,  while Boone and Locke discover another island mystery.', '/qMjnRwSk2tLQ17RUAb9pEePAp5B.jpg', '2004-12-08', 43, 0, 'free', 'publish', NULL),
(2486, 130, 333933, 12, 'Whatever the Case May Be', 'Jack, Kate and Sawyer fight over possession of a newly discovered locked metal briefcase which might contain insights into Kate\'s mysterious past. Meanwhile, Sayid asks a reluctant Shannon to translate notes he took from the French woman. A rising tide threatens to engulf the fuselage and the entire beach encampment, and Rose and a grieving Charlie tentatively bond over Claire\'s baffling kidnapping.', '/dfelRtsA7WoR6fxevxW0yAcsLfH.jpg', '2005-01-05', 44, 0, 'free', 'publish', NULL),
(2487, 130, 333934, 13, 'Hearts and Minds', 'When Locke learns that Boone wants to share their \"secret\" with Shannon, Locke decides to teach him a lesson.  This leads to Shannon\'s life being placed in what seems like peril.  Boone and Shannon\'s dark past is revealed in a shocking backstory that recalls their relationship right before the plane crash and presages the return of the beast. Kate, who has become a confidante to the soft-spoken Sun, is puzzled by Sun\'s mysterious behavior and the revelation that she can speak English.  A hungry Hurley must convince Jin to share his fish by making up for offending Jin by rejecting his offer of raw fish early on, or he\'ll continue to suffer digestive problems from the limited island diet.', '/8VYANq3OdjcJXZZ1198ftVRDEoR.jpg', '2005-01-12', 44, 0, 'free', 'publish', NULL),
(2488, 130, 333935, 14, 'Special', 'Violence ensues and a mysterious island beast makes a re-appearance when Michael and Locke clash over Walt\'s upbringing. Meanwhile, Charlie is tempted to read the missing Claire\'s diary, and Sayid enlists Shannon to help decipher the French woman\'s map.', '/2yc9RUnRHAJD03hyzvfiAp4PGxZ.jpg', '2005-01-19', 44, 0, 'free', 'publish', NULL),
(2489, 130, 333936, 15, 'Homecoming', 'After the missing Claire returns with no recollection of what has happened since before she boarded the doomed Oceanic flight 815, Jack and Locke formulate a plan of defense against her kidnapper, the mysterious Ethan (guest-star William Mapother), who threatens to kill off the other survivors one by one unless Claire is returned to him. Meanwhile, the disappointment Charlie feels when Claire does not remember him triggers recollections of a woman he had let down in the past.', '/oYTqYd7ow4wBLaDYPQg0SurrOft.jpg', '2005-02-09', 42, 0, 'free', 'publish', NULL),
(2490, 130, 333937, 16, 'Outlaws', 'Kate and Sawyer divulge dark secrets to each other while tracking a renegade boar that Sawyer swears is purposely harassing him.  Hurley and Sayid worry that Charlie is losing it after facing a brush with death and killing Ethan with 6 bullets to the chest.  A shocking prior connection between Sawyer and Jack is revealed in a flashback which shows Sawyer meeting Jack\'s father in a bar. Robert Patrick (\"Terminator 2: Judgment Day,\" \"The X-File\") guest stars.', '/er6u6oh5jH6tm8bo3tA9QY4BXXn.jpg', '2005-02-16', 44, 0, 'free', 'publish', NULL),
(2491, 130, 333938, 17, '...In Translation', 'When the raft the survivors have been building mysteriously burns down, Michael is convinced that Jin is responsible for the sabotage, which only serves to escalate their rivalry. Meanwhile, Sun stuns her fellow survivors with a surprising revelation, and Boone gives Sayid a warning about his step-sister Shannon. Lastly, more details of Jin and Sun\'s troubled marriage are revealed through flashbacks.', '/nNczccBhindMyNuhmRiqWhyPXrJ.jpg', '2005-02-23', 44, 0, 'free', 'publish', NULL),
(2492, 130, 333939, 18, 'Numbers', 'When Hurley becomes obsessed with the French woman and heads into the jungle to find her, Jack, Sayid and Charlie have no choice but to follow. Hurley flashes back to the hugely life-altering experience he had before boarding the plane.', '/2vvJKfJWXCPdMJXuwSPsNNffFL.jpg', '2005-03-02', 44, 0, 'free', 'publish', NULL),
(2493, 130, 333940, 19, 'Deus Ex Machina', 'Locke thinks he\'s being sent a sign on how to get the hatch open, and he and Boone venture inland. Jack is reluctant to offer assistance when Sawyer begins to experience excruciating headaches and needs glasses.', '/rjiOyJNMM7LRBUuHvndWM9ZbBxH.jpg', '2005-03-30', 43, 0, 'free', 'publish', NULL),
(2494, 130, 333941, 20, 'Do No Harm', 'Jack tends to a severely wounded Boone after Locke returns him to the caves.  In the confusion, Locke slips away to deal with his guilt over the crisis. Meanwhile, Claire unexpectedly goes into labor while deep in the forest.', '/hypmEfrJhlDmFIcePubYVKQDent.jpg', '2005-04-06', 44, 0, 'free', 'publish', NULL),
(2495, 130, 333942, 21, 'The Greater Good', 'After another funeral, tempers rise as the survivors\' suspicions of each other grow, and an unlikely survivor vows revenge. The events that landed Sayid on Flight 815 play out as he engages Locke in a psychological game of cat and mouse to uncover the truth about the mishap that claimed Boone\'s life.', '/dl7FwbQx9czTmxqZak8lKxvboTv.jpg', '2005-05-04', 44, 0, 'free', 'publish', NULL),
(2496, 130, 333943, 22, 'Born to Run', 'Jack suspects foul play when Michael becomes violently ill while building the raft. The suspects include Sawyer and Kate, who compete for the last seat on the raft and do anything possible to prevent each other from getting it.  Meanwhile, a secret from Kate\'s past is revealed to the other survivors on the island.', '/xyyydLk6wGhOxtxdIqUnKJHo092.jpg', '2005-05-11', 44, 0, 'free', 'publish', NULL),
(2497, 130, 333944, 23, 'Exodus (1)', 'The French woman-Danielle Rousseau-shocks the survivors by showing up to the camp with a dire warning about \"the Others\" who are on the island, and the black smoke that precedes them. Meanwhile, Michael and Jin ready the raft for sailing.  In flashbacks, we see the survivors final moments before they boarded their fateful flight.', '/wdIl0UAa1XnfHjhF7rNNDPONlI7.jpg', '2005-05-18', 44, 0, 'free', 'publish', NULL),
(2498, 130, 333947, 24, 'Exodus (2)', 'The castaways on the raft are surprised at sea by something unexpected. Meanwhile, remaining islanders attempt to blow open the hatch, and a visitor to the encampment might be a threat to Claire\'s infant son.', '/xOHqUNE4CB9UQ1CDB2Z6nOZag3k.jpg', '2005-05-25', 87, 0, 'free', 'publish', NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `genres`
--

CREATE TABLE `genres` (
  `id` int(11) NOT NULL,
  `tmdb_genre_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `genres`
--

INSERT INTO `genres` (`id`, `tmdb_genre_id`, `name`) VALUES
(1, 878, 'Science Fiction'),
(2, 12, 'Adventure'),
(3, 28, 'Actions'),
(4, 10765, 'Sci-Fi & Fantasy'),
(5, 18, 'Drama'),
(6, 10759, 'Action & Adventure'),
(7, 53, 'Thriller'),
(8, 35, 'Comedy'),
(9, 80, 'Crime'),
(10, 9648, 'Mystery'),
(11, 16, 'Animation'),
(12, 10768, 'War & Politics');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `homepage_sections`
--

CREATE TABLE `homepage_sections` (
  `id` int(11) NOT NULL,
  `section_title` varchar(255) NOT NULL,
  `section_type` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `display_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `homepage_sections`
--

INSERT INTO `homepage_sections` (`id`, `section_title`, `section_type`, `is_active`, `display_order`) VALUES
(1, 'Featured Slider', 'slider', 1, 1),
(2, 'Latest Movies', 'latest_movies', 1, 3),
(3, 'Latest TV Shows', 'latest_tv_shows', 1, 4),
(4, 'Trending', 'trending', 1, 2);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `menu_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `menu_items`
--

INSERT INTO `menu_items` (`id`, `title`, `url`, `menu_order`, `is_active`) VALUES
(1, 'Movies', '/movies', 1, 1),
(2, 'TV Shows', '/tv-shows', 2, 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `movies`
--

CREATE TABLE `movies` (
  `id` int(11) NOT NULL,
  `tmdb_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `overview` text DEFAULT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `backdrop_path` varchar(255) DEFAULT NULL,
  `logo_path` varchar(255) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `runtime` int(11) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `trailer_key` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `movies`
--

INSERT INTO `movies` (`id`, `tmdb_id`, `title`, `overview`, `poster_path`, `backdrop_path`, `logo_path`, `release_date`, `runtime`, `video_url`, `trailer_key`, `created_at`) VALUES
(6, 1119878, 'Ice Road: Vengeance', 'Big rig ice road driver Mike McCann travels to Nepal to scatter his late brother’s ashes on Mt. Everest. While on a packed tour bus traversing the deadly 12,000 ft. terrain of the infamous Road to the Sky, McCann and his mountain guide encounter a group of mercenaries and must fight to save themselves, the busload of innocent travelers, and the local villagers’ homeland.', '/cQN9rZj06rXMVkk76UF1DfBAico.jpg', '/962KXsr09uK8wrmUg9TjzmE7c4e.jpg', NULL, '2025-06-27', 113, NULL, NULL, '2025-07-29 19:54:46'),
(7, 1263256, 'Happy Gilmore 2', 'Happy Gilmore isn\'t done with golf — not by a long shot. Since his retirement after his first Tour Championship win, Gilmore returns to finance his daughter\'s ballet classes.', '/ynT06XivgBDkg7AtbDbX1dJeBGY.jpg', '/x5dVPttNDZaVRTvbk7pYrtGZoZN.jpg', '', '2025-07-25', 118, NULL, 'YKzRPFvky9Y', '2025-07-29 20:52:08'),
(8, 24428, 'The Avengers', 'When an unexpected enemy emerges and threatens global safety and security, Nick Fury, director of the international peacekeeping agency known as S.H.I.E.L.D., finds himself in need of a team to pull the world back from the brink of disaster. Spanning the globe, a daring recruitment effort begins!', '/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg', '/9BBTo63ANSmhC4e6r62OJFuK2GL.jpg', '/hdCTtnf7E7vcxInVAKzYFczj7nT.png', '2012-04-25', 143, NULL, 'hIR8Ar-Z4hw', '2025-07-29 21:25:19'),
(9, 755898, 'War of the Worlds', 'Will Radford is a top cyber-security analyst for Homeland Security who tracks potential threats to national security through a mass surveillance program, until one day an attack by an unknown entity leads him to question whether the government is hiding something from him... and from the rest of the world.', '/yvirUYrva23IudARHn3mMGVxWqM.jpg', '/iZLqwEwUViJdSkGVjePGhxYzbDb.jpg', '/4U3NQ3KvqjofySTwoDbffawb00h.png', '2025-07-29', 91, NULL, 'd9erkpdh5o0', '2025-07-31 21:44:45');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `movie_cast`
--

CREATE TABLE `movie_cast` (
  `movie_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `character_name` varchar(255) DEFAULT NULL,
  `cast_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `movie_cast`
--

INSERT INTO `movie_cast` (`movie_id`, `person_id`, `character_name`, `cast_order`) VALUES
(6, 11, 'Mike McCann', 0),
(6, 12, 'Dhani Yangchen', 1),
(6, 13, 'Gurty', 2),
(6, 14, 'Starr Myers', 3),
(6, 15, 'Vijay Rai', 4),
(7, 16, 'Happy Gilmore', 0),
(7, 17, 'Virginia', 1),
(7, 18, 'Shooter McGavin', 2),
(7, 19, 'Frank Manatee', 3),
(7, 20, 'Hal L', 4),
(8, 31, 'Tony Stark / Iron Man', 0),
(8, 32, 'Steve Rogers / Captain America', 1),
(8, 33, 'Bruce Banner / The Hulk', 2),
(8, 34, 'Thor', 3),
(8, 35, 'Natasha Romanoff / Black Widow', 4),
(9, 58, 'William Radford', 0),
(9, 59, 'NASA Scientist Sandra Salas', 1),
(9, 60, 'NSA Director Donald Briggs', 2),
(9, 61, 'Faith Radford', 3),
(9, 62, 'David Radford', 4);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `movie_genres`
--

CREATE TABLE `movie_genres` (
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `movie_genres`
--

INSERT INTO `movie_genres` (`movie_id`, `genre_id`) VALUES
(6, 3),
(6, 5),
(6, 7),
(7, 8),
(8, 1),
(8, 2),
(8, 3),
(9, 1),
(9, 7);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `movie_networks`
--

CREATE TABLE `movie_networks` (
  `movie_id` int(11) NOT NULL,
  `network_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `people`
--

CREATE TABLE `people` (
  `id` int(11) NOT NULL,
  `tmdb_person_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `profile_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `people`
--

INSERT INTO `people` (`id`, `tmdb_person_id`, `name`, `profile_path`) VALUES
(1, 1785590, 'David Corenswet', '/qB0hBMu4wU1nPrqtdUQP3sQeN5t.jpg'),
(2, 993774, 'Rachel Brosnahan', '/1f9NK43gWrXN2uMmYMlennB7jCC.jpg'),
(3, 3292, 'Nicholas Hoult', '/laeAYQVBV9U3DkJ1B4Cn1XhpT8P.jpg'),
(4, 39391, 'Edi Gathegi', '/dt8yMyycDlzxkjhmuuJJ4tXDbp4.jpg'),
(5, 51797, 'Nathan Fillion', '/aW6vCxkUZtwb6iH2Wf88Uq0XNVv.jpg'),
(6, 22970, 'Peter Dinklage', '/9CAd7wr8QZyIN0E7nm8v1B6WkGn.jpg'),
(7, 239019, 'Kit Harington', '/iCFQAQqb0SgvxEdVYhJtZLhM9kp.jpg'),
(8, 12795, 'Nikolaj Coster-Waldau', '/6w2SgB20qzs2R5MQIAckINLhfoP.jpg'),
(9, 17286, 'Lena Headey', '/cDyZLf8ddz0EgoUjpv4jjzy7qxA.jpg'),
(10, 1223786, 'Emilia Clarke', '/wb8VfDPGpyqcFltnRcJR1Wj3h4Z.jpg'),
(11, 3896, 'Liam Neeson', '/sRLev3wJioBgun3ZoeAUFpkLy0D.jpg'),
(12, 64439, 'Fan Bingbing', '/pV2wYJiiPd6cgHK580PKD0GM4Dc.jpg'),
(13, 55174, 'Marcus Thomas', '/gMRYZQZ1TZxgjb8yWpkVTs0BIdm.jpg'),
(14, 2459258, 'Grace O\'Sullivan', '/ifgurjdagUpyw9Dyh4yYtN0p3R7.jpg'),
(15, 5538791, 'Saksham Sharma', NULL),
(16, 19292, 'Adam Sandler', '/iTMnXrPfC1rmom6a9q4hy6YSJWG.jpg'),
(17, 31171, 'Julie Bowen', '/5ewqnbPAY0EzZObGHIKU4VsCanD.jpg'),
(18, 4443, 'Christopher McDonald', '/gK1XhbfD9Xd8s3VXRPpgDCluyZp.jpg'),
(19, 227564, 'Benny Safdie', '/9tp4PLNyYPNfCJOWBXPPalWIpnq.jpg'),
(20, 7399, 'Ben Stiller', '/scgpxhI05JpdNXXfmpK6z0rPOWN.jpg'),
(21, 1230381, 'Sean Murray', '/1RlMqC3qL5gKlfqyAR2xzgKjWrN.jpg'),
(22, 18975, 'Wilmer Valderrama', '/uohkEwMGIGCq4k8P2AiomuKQwYv.jpg'),
(23, 164930, 'Katrina Law', '/y7LzCN8BaoPPSXDBo0UwPQ4UwSB.jpg'),
(24, 1213580, 'Brian Dietzen', '/njOHd9yWWGQrTS7btmp2vbMbQjE.jpg'),
(25, 27448, 'Rocky Carroll', '/pqjqmRChGqhDXXY7Etka3bmOatN.jpg'),
(26, 53820, 'Michael C. Hall', '/7zUMGoujuev5PUwwv4Gl6ikB50k.jpg'),
(27, 53828, 'Jennifer Carpenter', '/haxhKRJoWl71dAUWMLlDIaSd5bN.jpg'),
(28, 25879, 'Geoff Pierson', '/vIhxKBwqV19CwHdPuycmkchYOba.jpg'),
(29, 22821, 'David Zayas', '/w1E8n9gl2HcZEhfBOXdVzMvIlzg.jpg'),
(30, 1736, 'James Remar', '/56LwfMaMge2LmWYI46O6R2Wm0YX.jpg'),
(31, 3223, 'Robert Downey Jr.', '/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg'),
(32, 16828, 'Chris Evans', '/3bOGNsHlrswhyW79uvIHH1V43JI.jpg'),
(33, 103, 'Mark Ruffalo', '/5GilHMOt5PAQh6rlUKZzGmaKEI7.jpg'),
(34, 74568, 'Chris Hemsworth', '/piQGdoIQOF3C1EI5cbYZLAW1gfj.jpg'),
(35, 1245, 'Scarlett Johansson', '/zMHSGCTewNp2M3JbqAlu8dYdw9U.jpg'),
(36, 3972, 'Wentworth Miller', '/js09M98qo6rEyyIlTbRMI6XiZJH.jpg'),
(37, 10862, 'Dominic Purcell', '/30giDZ53c8f72pPbXCLK9xMSAnw.jpg'),
(38, 86468, 'Sarah Wayne Callies', '/uBtFalxNR1O0eARg0lsyLXkoJNG.jpg'),
(39, 17342, 'Paul Adelstein', '/9qkGnEWPzGayZg9gaB4xbP8UL4g.jpg'),
(40, 17345, 'Rockmond Dunbar', '/gim7zIrYkbKWsp2Kod7fp74fWyI.jpg'),
(41, 1253360, 'Pedro Pascal', '/9VYK7oxcqhjd5LAH6ZFJ3XzOlID.jpg'),
(42, 51798, 'Katee Sackhoff', '/kzcwfDDrgXnVgyTfcpG0obOn7Qk.jpg'),
(43, 62220, 'Lauren Cohan', '/zJ9nZ5jqQTUD55GLKbgfiKlUoBN.jpg'),
(44, 4886, 'Norman Reedus', '/ozHPdO5jAt7ozzdZUgyRAMNPSDW.jpg'),
(45, 47296, 'Jeffrey Dean Morgan', '/m8bdrmh6ExDCGQ64E83mHg002YV.jpg'),
(46, 31535, 'Melissa McBride', '/2omPfeMdnicJqqvgKAU2iqVyD4Z.jpg'),
(47, 84224, 'Christian Serratos', '/jP07Elhu2eZdmjIB4fJiag5CfaD.jpg'),
(48, 3266, 'Joe Mantegna', '/4jzvAE6B1eoiZDUnDUuMazirCPP.jpg'),
(49, 15423, 'Paget Brewster', '/lpT3unm2LknRSNxCeu3fZByY29P.jpg'),
(50, 49706, 'Adam Rodriguez', '/qFSbLvyNPZK40hY9gZXJDvq0qVK.jpg'),
(51, 123727, 'Kirsten Vangsness', '/davwWkIDqUoVF28YmSAqpvUUFuS.jpg'),
(52, 17236, 'A. J. Cook', '/tvEjGDQVuu7jiOvWXwEU6tEE7NW.jpg'),
(53, 52139, 'Seth MacFarlane', '/8oQJqM51Z0Qtdb7sE6ZfX1peNCB.jpg'),
(54, 24357, 'Alex Borstein', '/evbCnRe5Yfuy0B41PONLTIcvbem.jpg'),
(55, 18973, 'Mila Kunis', '/cJAHQWX9hVadDFx5WTSBIW0VjvP.jpg'),
(56, 13922, 'Seth Green', '/l4No5Eu6j0U80hCIkaSn17AOWrj.jpg'),
(57, 9657, 'Patrick Warburton', '/nDoOii5HaGwPxYa28xFC2sDkF8y.jpg'),
(58, 9778, 'Ice Cube', '/ymR7Yll7HjL6i6Z3pt435hYi91T.jpg'),
(59, 52605, 'Eva Longoria', '/1u26GLWK1DE7gBugyI9P3OMFq4A.jpg'),
(60, 9048, 'Clark Gregg', '/mq686D91XoZpqkzELn0888NOiZW.jpg'),
(61, 1632530, 'Iman Benson', '/9rcxSRoFG8wenhioplCgRlEnexe.jpg'),
(62, 60482, 'Henry Hunter Hall', '/sHlj2Nu18yV8qzYYxFQCJENlybX.jpg'),
(63, 1609347, 'Alex Høgh Andersen', '/kDO1gFqMnsV5gCQsMgEL9BZongX.jpg'),
(64, 1394429, 'Jordan Patrick Smith', '/bGPLRUkjCHm2j8VspCOgL6mti4b.jpg'),
(65, 1372317, 'Marco Ilsø', '/xfcrAKFHq81VVO9axg1zP8JrYCN.jpg'),
(66, 11263, 'Peter Franzén', '/8ltJpmctAnBxCuG725N2GclwWMZ.jpg'),
(67, 2074237, 'Georgia Hirst', '/lnUhfcYBq1iCC5g8M6YmH4fhhTl.jpg'),
(68, 28657, 'Matthew Fox', '/6VIfueb4j3GCsIhxnstsXlY5C3Y.jpg'),
(69, 19034, 'Evangeline Lilly', '/pJHX2jd7ytre3NQbF9nlyWUqxH3.jpg'),
(70, 12646, 'Terry O\'Quinn', '/kSweOGPprLe1vDvu38wJQaWIih7.jpg'),
(71, 142636, 'Josh Holloway', '/biuhUJn5BDhXpfKvVW4dVUxvB44.jpg'),
(72, 2136, 'Michael Emerson', '/71N2SMNudxEYjMJRZTJttcsRJ66.jpg');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `profiles`
--

CREATE TABLE `profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT 'default.png',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `episode_id` int(11) DEFAULT NULL,
  `reason` text NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `requests`
--

CREATE TABLE `requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_title` varchar(255) NOT NULL,
  `content_type` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `seasons`
--

CREATE TABLE `seasons` (
  `id` int(11) NOT NULL,
  `tv_show_id` int(11) NOT NULL,
  `tmdb_season_id` int(11) DEFAULT NULL,
  `season_number` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `overview` text DEFAULT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `air_date` date DEFAULT NULL,
  `episode_count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `seasons`
--

INSERT INTO `seasons` (`id`, `tv_show_id`, `tmdb_season_id`, `season_number`, `name`, `overview`, `poster_path`, `air_date`, `episode_count`) VALUES
(130, 13, 14041, 1, 'Season 12222', 'Mysteries abound on the first season of LOST as the survivors of Oceanic Air flight 815 find themselves stranded on an unidentified island with little hope of rescue.', '/fc9f4ERC09U1GziCgDWilWWgjKx.jpg', '2004-09-22', 24),
(131, 13, 14042, 2, 'Season 2', 'The motley crew of castaways remains stranded on the eerie deserted island populated by mysterious things that go bump in the night.', '/vGLddXoXJhKPsAWeDYbAsE4wW1z.jpg', '2005-09-21', 24),
(132, 13, 14043, 3, 'Season 3', 'The castaways continue to seek strength as paranoia increases, prompting the revelation of more backstories -- and more secrets about the island.', '/zLnuh6DVyrz5iaNVO6KNKubtffo.jpg', '2006-10-04', 23),
(133, 13, 14044, 4, 'Season 4', 'Picking up from the shocking Season 3 finale, learn via \"flash forwards\" who from Oceanic Airlines flight 815 gets off the island.', '/TOfSxtW76sWrPn3YSm5GooaR3Y.jpg', '2008-01-31', 13),
(134, 13, 14045, 5, 'Season 5', 'Season 5 finds six survivors of Oceanic Air Flight 815 returning to civilization and wrestling with the memories of those they left behind.', '/2OYKA6UIC56loPxgL4IMshg4mVr.jpg', '2009-01-21', 17),
(135, 13, 14046, 6, 'Season 6', 'After Season 5’s explosive finish, everything is up in the air for the survivors of flight 815. No one knows what — or who — the future will hold. Will Juliet’s sacrifice to save her friends work? Can Kate choose, once and for all, between Jack and Sawyer? Will Sun and Jin be reunited? Is it too late to save Claire? Whatever awaits everyone on the island, one thing is for certain — the moment of truth has arrived.', '/29tcXCeFa3CWmavGw4D7UlERjF2.jpg', '2010-02-02', 17),
(136, 9, 3643, 1, 'Season 1', 'Rick Grimes wakes up from a coma to a world overrun by zombies, on a journey to find his family he must learn to survive the streets of post-apocalyptic Atlanta.', '/kKN1Klhdxhbiwe8TBXIs6NYPr4C.jpg', '2010-10-31', 6),
(137, 9, 3644, 2, 'Season 2', 'Under Rick\'s leadership, the group leave Atlanta in search of sanctuary.', '/77sdrexHQx3uQRM68Ffdanw8QaV.jpg', '2011-10-15', 13),
(138, 9, 3645, 3, 'Season 3', 'Having seemingly found a place of security, the group are faced with an unprecedented new threat.', '/8Vy2SK2aMIDW3c6NeslQk7nc6on.jpg', '2012-10-13', 16),
(139, 9, 3647, 4, 'Season 4', 'As the group settle into life in a stable shelter, a new danger threatens disaster.', '/1bFtBZg4ehney9ogQncllQAeX8o.jpg', '2013-10-12', 16),
(140, 9, 60391, 5, 'Season 5', 'After the season 4 finale left most of the main characters at the mercy of the sadistic inhabitants of Terminus. Season 5 will offer new directions for the group of survivors as scientist Eugene Porter promises a cure to the zombie virus if he can be safely escorted to Washington DC, but getting there is easier said than done.', '/cimCEzhKLayG91lrAkn8E5ZQc7x.jpg', '2014-10-11', 16),
(141, 9, 68814, 6, 'Season 6', 'Rick attempts to use his authority in Alexandria to keep the inhabitants safe, even as a new threat looms.', '/xXTDbcXFOm7vCxQHl4D7lblb88U.jpg', '2015-10-10', 16),
(142, 9, 76834, 7, 'Season 7', 'Rick and his group\'s world becomes even more brutal due to Negan\'s deadly example of what happens if they don\'t live under his rules. Everyone must begin again.', '/bz6IMoRiw6eV2pawWGeOlLGKilZ.jpg', '2016-10-22', 16),
(143, 9, 91735, 8, 'Season 8', 'Rick and his survivors bring \"All-Out War\" to Negan and his forces. The Saviors are larger, better-equipped, and ruthless - but Rick and the unified communities are fighting for the promise of a brighter future. The battle lines are drawn as they launch into a kinetic, action-packed offensive.', '/jP6XyARVDEMKAncIbUql3krIOyd.jpg', '2017-10-21', 16),
(144, 9, 109531, 9, 'Season 9', 'With the defeat of Negan and the Saviors, the survivors are now rebuilding civilisation under Rick’s leadership. However, the group are forced to face their biggest threat yet as the walkers around them have started whispering.', '/gLraG3uYQFjnSBktU8DM4ylh6By.jpg', '2018-10-07', 16),
(145, 9, 123967, 10, 'Season 10', 'It is now Spring, a few months after the end of Season 9, when our group of survivors dared to cross into Whisperer territory during the harsh winter. The collected communities are still dealing with the after effects of Alpha’s horrific display of power, reluctantly respecting the new borderlines being imposed on them, all while organizing themselves into a militia-style fighting force, preparing for a battle that may be unavoidable. But the Whisperers are a threat unlike any they have ever faced. Backed by a massive horde of the dead it is seemingly a fight they cannot win.', '/js9kgo7xGR3rhL7E2hyGM2oED0m.jpg', '2019-10-06', 22),
(146, 9, 189337, 11, 'Season 11', 'All who live in Alexandria struggle to refortify it and feed its increasing number of residents, which include the survivors from the fall of the Kingdom and the burning of Hilltop; along with Maggie and her new group, the Wardens. Alexandria has more people than it can manage to feed and protect. Their situation is dire as tensions heat up over past events and self-preservation rises to the surface within the ravaged walls. They must secure more food while they attempt to restore Alexandria before it collapses like countless other communities they have come across throughout the years. But where and how? More haggard and hungrier than ever before, they must dig deeper to find the effort and strength to safeguard the lives of their children, even if it means losing their own. Meanwhile, unbeknownst to those at Alexandria, Eugene, Ezekiel, Yumiko, and Princess are still being held captive by mysterious soldiers who are members of a larger and unforthcoming group.', '/2ypIGPkSJSaY1F059VzgVA6f6OJ.jpg', '2021-08-22', 24);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `setting_name` varchar(255) NOT NULL,
  `setting_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `settings`
--

INSERT INTO `settings` (`id`, `setting_name`, `setting_value`) VALUES
(1, 'site_name', 'MuvixTV'),
(2, 'site_description', 'A great place to watch movies and TV shows.'),
(3, 'tmdb_api_key', '88c4b87bb42b453174d8e4cf9b5b7863'),
(4, 'logo_path', 'logo_1753927480_5.png'),
(5, 'favicon_path', 'favicon_1753927480_5.png'),
(6, 'login_required', '1'),
(7, 'smtp_host', NULL),
(8, 'smtp_port', NULL),
(9, 'smtp_user', NULL),
(10, 'smtp_pass', NULL),
(11, 'smtp_secure', 'ssl'),
(12, 'site_email', NULL),
(13, 'ads_network', 'admob'),
(14, 'admob_publisher_id', ''),
(15, 'admob_app_id', ''),
(16, 'admob_banner_ad_id', ''),
(17, 'admob_interstitial_ad_id', ''),
(18, 'admob_native_ad_id', ''),
(19, 'facebook_banner_ad_id', ''),
(20, 'facebook_interstitial_ad_id', ''),
(21, 'facebook_native_ad_id', ''),
(22, 'startapp_app_id', ''),
(23, 'adcolony_app_id', ''),
(24, 'adcolony_banner_zone_id', ''),
(25, 'adcolony_interstitial_zone_id', ''),
(26, 'unity_game_id', ''),
(27, 'unity_banner_zone_id', ''),
(28, 'unity_interstitial_zone_id', ''),
(29, 'custom_banner_url', ''),
(30, 'custom_banner_click_url_type', 'none'),
(31, 'custom_banner_click_url', ''),
(32, 'custom_interstitial_url', ''),
(33, 'custom_interstitial_click_url_type', 'none'),
(34, 'custom_interstitial_click_url', ''),
(35, 'applovin_sdk_key', ''),
(36, 'applovin_banner_id', ''),
(37, 'applovin_interstitial_id', ''),
(38, 'ironsource_app_key', ''),
(39, 'vortex_ad_key', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `subtitles`
--

CREATE TABLE `subtitles` (
  `id` int(11) NOT NULL,
  `video_link_id` int(11) NOT NULL,
  `language` varchar(255) NOT NULL,
  `url` text NOT NULL,
  `type` varchar(10) DEFAULT 'vtt',
  `status` varchar(50) DEFAULT 'publish'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `subtitles`
--

INSERT INTO `subtitles` (`id`, `video_link_id`, `language`, `url`, `type`, `status`) VALUES
(3, 7, 's', 's', 'vtt', 'publish');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tv_shows`
--

CREATE TABLE `tv_shows` (
  `id` int(11) NOT NULL,
  `tmdb_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `overview` text DEFAULT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `backdrop_path` varchar(255) DEFAULT NULL,
  `logo_path` varchar(255) DEFAULT NULL,
  `first_air_date` date DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `trailer_key` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `tv_shows`
--

INSERT INTO `tv_shows` (`id`, `tmdb_id`, `title`, `overview`, `poster_path`, `backdrop_path`, `logo_path`, `first_air_date`, `status`, `trailer_key`, `created_at`) VALUES
(1, 1396, 'Breaking Bad', 'New Mexico\'lu bir kimya öğretmeni olan Walter White\'a Evre III kanser teşhisi kondu ve yaşamak için sadece iki yıllık bir prognoz verildi. Uyuşturucu ve suçun tehlikeli dünyasına girerken korkusuzluk duygusu ve ailesinin finansal geleceğini ne pahasına olursa olsun güvence altına almak için amansız bir arzuyla dolar.', '/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg', NULL, NULL, '2008-01-20', NULL, NULL, '2025-07-29 01:04:05'),
(3, 93405, 'Squid Game', 'Hundreds of cash-strapped players accept a strange invitation to compete in children\'s games. Inside, a tempting prize awaits — with deadly high stakes.', '/onV0JoOJeiUHG1rfpB2lFTVw1vN.jpg', NULL, NULL, '2021-09-17', NULL, NULL, '2025-07-29 19:08:21'),
(4, 1399, 'Game of Thrones', 'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.', '/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg', '/2OMB0ynKlyIenMJWI2Dy9IWT4c.jpg', NULL, '2011-04-17', NULL, NULL, '2025-07-29 19:53:34'),
(5, 4614, 'NCIS', 'From murder and espionage to terrorism and stolen submarines, a team of special agents investigates any crime that has a shred of evidence connected to Navy and Marine Corps personnel, regardless of rank or position.', '/mBcu8d6x6zB1el3MPNl7cZQEQ31.jpg', '/c1aBrG5s5xFa6Tbnihu2Hhj4t2q.jpg', NULL, '2003-09-23', NULL, NULL, '2025-07-29 20:56:25'),
(6, 1405, 'Dexter', 'Dexter Morgan, a blood spatter pattern analyst for the Miami Metro Police also leads a secret life as a serial killer, hunting down criminals who have slipped through the cracks of justice.', '/q8dWfc4JwQuv3HayIZeO84jAXED.jpg', '/aSGSxGMTP893DPMCvMl9AdnEICE.jpg', NULL, '2006-10-01', NULL, NULL, '2025-07-29 21:00:43'),
(7, 2288, 'Prison Break', 'Due to a political conspiracy, an innocent man is sent to death row and his only hope is his brother, who makes it his mission to deliberately get himself sent to the same prison in order to break the both of them out, from the inside out.', '/5E1BhkCgjLBlqx557Z5yzcN0i88.jpg', '/7w165QdHmJuTHSQwEyJDBDpuDT7.jpg', '/pX2ceIs6ZJIbYQKKQpk0bvqjUi2.png', '2005-08-29', 'Ended', 'AL9zLctDJaU', '2025-07-29 21:45:11'),
(8, 82856, 'The Mandalorian', 'After the fall of the Galactic Empire, lawlessness has spread throughout the galaxy. A lone gunfighter makes his way through the outer reaches, earning his keep as a bounty hunter.', '/eU1i6eHXlzMOlEq0ku1Rzq7Y4wA.jpg', '/9zcbqSxdsRMZWHYtyCd1nXPr2xq.jpg', NULL, '2019-11-12', NULL, NULL, '2025-07-29 22:09:15'),
(9, 1402, 'The Walking Dead', 'Sheriff\'s deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.', '/aN29llVoCFtBTwDZFtqdD9d8dHb.jpg', '/rAOjnEFTuNysY7bot8zonhImGMh.jpg', '/7CIJHjFz2fh4bo6kg1gfE51oENa.png', '2010-10-31', 'Ended', 'M84QqU7H6kQ', '2025-07-30 20:23:58'),
(10, 4057, 'Criminal Minds', 'An elite team of FBI profilers analyze the country\'s most twisted criminal minds, anticipating their next moves before they strike again. The Behavioral Analysis Unit\'s most experienced agent is David Rossi, a founding member of the BAU who returns to help the team solve new cases.', '/wLMQebhTApmn4F6Fzg6FovdwVvL.jpg', '/w88B4ooZ2LSYPw5107JOkjvI8PI.jpg', '/zFNsNJ3GVmEtHEIjaaaALoZ8LL8.png', '2005-09-22', 'Returning Series', 'NTYxiJBbEZk', '2025-07-30 20:30:04'),
(11, 1434, 'Family Guy', 'Sick, twisted, politically incorrect and Freakin\' Sweet animated series featuring the adventures of the dysfunctional Griffin family. Bumbling Peter and long-suffering Lois have three kids. Stewie (a brilliant but sadistic baby bent on killing his mother and taking over the world), Meg (the oldest, and is the most unpopular girl in town) and Chris (the middle kid, he\'s not very bright but has a passion for movies). The final member of the family is Brian - a talking dog and much more than a pet, he keeps Stewie in check whilst sipping Martinis and sorting through his own life issues.', '/8o8kiBkWFK3gVytHdyzEWUBXVfK.jpg', '/lgGZ2ysbRyAOi2VgIZpp6k8qILj.jpg', '/d0qh15QxRMBigvAnuZ8bSaN02jS.png', '1999-01-31', 'Returning Series', 'J32iwo65RMc', '2025-07-30 20:40:04'),
(12, 44217, 'Vikings', 'The adventures of Ragnar Lothbrok, the greatest hero of his age. The series tells the sagas of Ragnar\'s band of Viking brothers and his family, as he rises to become King of the Viking tribes. As well as being a fearless warrior, Ragnar embodies the Norse traditions of devotion to the gods. Legend has it that he was a direct descendant of Odin, the god of war and warriors.', '/bQLrHIRNEkE3PdIWQrZHynQZazu.jpg', '/lHe8iwM4Cdm6RSEiara4PN8ZcBd.jpg', '/4GKqOzFXX8UXqmF5XzEO7AQlNqY.png', '2013-03-03', 'Ended', '7rcozIVtujw', '2025-07-31 21:45:23'),
(13, 4607, 'Lost', 'Stripped of everything, the survivors of a horrific plane crash  must work together to stay alive. But the island holds many secrets.', '/og6S0aTZU6YUJAbqxeKjCa3kY1E.jpg', '/yUOFocKDW7MCC5isx4FK8A68QFp.jpg', '/3OdGyeRpm56so0xmXjhBs8DbXv5.png', '2004-09-22', 'Ended', 'KTu8iDynwNc', '2025-08-03 02:00:35');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tv_show_cast`
--

CREATE TABLE `tv_show_cast` (
  `tv_show_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `character_name` varchar(255) DEFAULT NULL,
  `cast_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `tv_show_cast`
--

INSERT INTO `tv_show_cast` (`tv_show_id`, `person_id`, `character_name`, `cast_order`) VALUES
(4, 6, 'Tyrion \'The Halfman\' Lannister', 0),
(4, 7, 'Jon Snow', 1),
(4, 8, 'Sir Jaime \'Kingslayer\' Lannister', 5),
(4, 9, 'Cersei Lannister', 6),
(4, 10, 'Daenerys Targaryen', 8),
(5, 21, 'Timothy McGee', 1),
(5, 22, 'Nick Torres', 3),
(5, 23, 'Jessica Knight', 4),
(5, 24, 'Jimmy Palmer', 6),
(5, 25, 'Leon Vance', 15),
(6, 26, 'Dexter Morgan', 0),
(6, 27, 'Debra Morgan', 2),
(6, 28, 'Thomas Matthews', 3),
(6, 29, 'Angel Batista', 4),
(6, 30, 'Harry Morgan', 5),
(7, 36, 'Michael Scofield', 0),
(7, 37, 'Lincoln Burrows', 2),
(7, 38, 'Sara Tancredi', 3),
(7, 39, 'Paul Kellerman', 5),
(7, 40, 'Benjamin \'C-Note\' Franklin', 7),
(8, 41, 'Din Djarin / The Mandalorian', 0),
(8, 42, 'Bo-Katan Kryze', 3),
(9, 43, 'Maggie Greene', 3),
(9, 44, 'Daryl Dixon', 4),
(9, 45, 'Negan Smith', 8),
(9, 46, 'Carol Peletier', 9),
(9, 47, 'Rosita Espinosa', 15),
(10, 48, 'David Rossi', 1),
(10, 49, 'Emily Prentiss', 2),
(10, 50, 'Luke Alvez', 4),
(10, 51, 'Penelope Garcia', 5),
(10, 52, 'Jennifer Jareau', 7),
(11, 53, 'Peter Griffin / Brian Griffin / Stewie Griffin / Glenn Quagmire / Tom Tucker (voice)', 0),
(11, 54, 'Lois Griffin / Tricia Takanawa / Loretta Brown / Barbara Pewterschmidt (voice)', 1),
(11, 55, 'Meg Griffin (voice)', 2),
(11, 56, 'Chris Griffin (voice)', 3),
(11, 57, 'Joe Swanson (voice)', 6),
(12, 63, 'Ivar Lothbrok / Ivar the Boneless', 1),
(12, 64, 'Ubbe Lothbrok', 3),
(12, 65, 'Hvitserk Lothbrok', 5),
(12, 66, 'King Harald Finehair', 9),
(12, 67, 'Torvi', 12),
(13, 68, 'Jack Shephard', 0),
(13, 69, 'Kate Austen', 1),
(13, 70, 'John Locke', 2),
(13, 71, 'James Sawyer', 3),
(13, 72, 'Benjamin Linus', 4);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tv_show_genres`
--

CREATE TABLE `tv_show_genres` (
  `tv_show_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `tv_show_genres`
--

INSERT INTO `tv_show_genres` (`tv_show_id`, `genre_id`) VALUES
(4, 4),
(4, 5),
(4, 6),
(5, 5),
(5, 6),
(5, 9),
(6, 5),
(6, 9),
(6, 10),
(7, 5),
(7, 6),
(7, 9),
(8, 4),
(8, 5),
(8, 6),
(9, 4),
(9, 5),
(9, 6),
(10, 5),
(10, 9),
(10, 10),
(11, 8),
(11, 11),
(12, 5),
(12, 6),
(12, 12),
(13, 5),
(13, 6),
(13, 10);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tv_show_networks`
--

CREATE TABLE `tv_show_networks` (
  `tv_show_id` int(11) NOT NULL,
  `network_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `1` tinyint(1) NOT NULL DEFAULT 0,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `email`, `password_hash`, `1`, `is_admin`, `created_at`) VALUES
(3, 'randomhesapgen@gmail.com', '$2y$10$UC7dMoVKL63bMmx2r.vBM.pXYSlfIYSioRkb.4uYIDmTLrq6IWZRy', 0, 1, '2025-07-28 18:31:10'),
(7, 'quarionmedia@gmail.com', '$2y$10$oBGtipc3q2e/vMn2GXG2XO.m7Udb0eAY0Jw8tjC4ohfdiuCjJBS3q', 0, 0, '2025-07-28 20:26:04');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `video_links`
--

CREATE TABLE `video_links` (
  `id` int(11) NOT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `episode_id` int(11) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `quality` varchar(255) DEFAULT NULL,
  `size` varchar(100) DEFAULT NULL,
  `source` varchar(255) NOT NULL,
  `url` text NOT NULL,
  `link_type` varchar(50) DEFAULT 'stream',
  `status` varchar(50) DEFAULT 'publish'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `video_links`
--

INSERT INTO `video_links` (`id`, `movie_id`, `episode_id`, `label`, `quality`, `size`, `source`, `url`, `link_type`, `status`) VALUES
(3, 9, NULL, '', '', '', 'Youtube', '2', 'stream', 'publish'),
(7, NULL, 2468, '', '', '', 'Youtube', 'ss', 'stream', 'publish'),
(9, NULL, 2475, 's', '', '', 'Youtube', 's', 'stream', 'publish'),
(10, 8, NULL, 'ss', '', '', 'Youtube', 'ss', 'stream', 'publish');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `content_networks`
--
ALTER TABLE `content_networks`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `template_name` (`template_name`);

--
-- Tablo için indeksler `episodes`
--
ALTER TABLE `episodes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tmdb_episode_id` (`tmdb_episode_id`),
  ADD KEY `season_id` (`season_id`);

--
-- Tablo için indeksler `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tmdb_genre_id` (`tmdb_genre_id`);

--
-- Tablo için indeksler `homepage_sections`
--
ALTER TABLE `homepage_sections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `section_type` (`section_type`);

--
-- Tablo için indeksler `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tmdb_id` (`tmdb_id`);

--
-- Tablo için indeksler `movie_cast`
--
ALTER TABLE `movie_cast`
  ADD PRIMARY KEY (`movie_id`,`person_id`),
  ADD KEY `person_id` (`person_id`);

--
-- Tablo için indeksler `movie_genres`
--
ALTER TABLE `movie_genres`
  ADD PRIMARY KEY (`movie_id`,`genre_id`),
  ADD KEY `genre_id` (`genre_id`);

--
-- Tablo için indeksler `movie_networks`
--
ALTER TABLE `movie_networks`
  ADD PRIMARY KEY (`movie_id`,`network_id`);

--
-- Tablo için indeksler `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tmdb_person_id` (`tmdb_person_id`);

--
-- Tablo için indeksler `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `seasons`
--
ALTER TABLE `seasons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tmdb_season_id` (`tmdb_season_id`),
  ADD KEY `tv_show_id` (`tv_show_id`);

--
-- Tablo için indeksler `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_name` (`setting_name`);

--
-- Tablo için indeksler `subtitles`
--
ALTER TABLE `subtitles`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `tv_shows`
--
ALTER TABLE `tv_shows`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tmdb_id` (`tmdb_id`);

--
-- Tablo için indeksler `tv_show_cast`
--
ALTER TABLE `tv_show_cast`
  ADD PRIMARY KEY (`tv_show_id`,`person_id`),
  ADD KEY `person_id` (`person_id`);

--
-- Tablo için indeksler `tv_show_genres`
--
ALTER TABLE `tv_show_genres`
  ADD PRIMARY KEY (`tv_show_id`,`genre_id`),
  ADD KEY `genre_id` (`genre_id`);

--
-- Tablo için indeksler `tv_show_networks`
--
ALTER TABLE `tv_show_networks`
  ADD PRIMARY KEY (`tv_show_id`,`network_id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Tablo için indeksler `video_links`
--
ALTER TABLE `video_links`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `content_networks`
--
ALTER TABLE `content_networks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `episodes`
--
ALTER TABLE `episodes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2499;

--
-- Tablo için AUTO_INCREMENT değeri `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Tablo için AUTO_INCREMENT değeri `homepage_sections`
--
ALTER TABLE `homepage_sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `movies`
--
ALTER TABLE `movies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Tablo için AUTO_INCREMENT değeri `people`
--
ALTER TABLE `people`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- Tablo için AUTO_INCREMENT değeri `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `seasons`
--
ALTER TABLE `seasons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- Tablo için AUTO_INCREMENT değeri `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- Tablo için AUTO_INCREMENT değeri `subtitles`
--
ALTER TABLE `subtitles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `tv_shows`
--
ALTER TABLE `tv_shows`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Tablo için AUTO_INCREMENT değeri `video_links`
--
ALTER TABLE `video_links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `episodes`
--
ALTER TABLE `episodes`
  ADD CONSTRAINT `episodes_ibfk_1` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `movie_cast`
--
ALTER TABLE `movie_cast`
  ADD CONSTRAINT `movie_cast_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `movie_cast_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `movie_genres`
--
ALTER TABLE `movie_genres`
  ADD CONSTRAINT `movie_genres_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `movie_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `seasons`
--
ALTER TABLE `seasons`
  ADD CONSTRAINT `seasons_ibfk_1` FOREIGN KEY (`tv_show_id`) REFERENCES `tv_shows` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `tv_show_cast`
--
ALTER TABLE `tv_show_cast`
  ADD CONSTRAINT `tv_show_cast_ibfk_1` FOREIGN KEY (`tv_show_id`) REFERENCES `tv_shows` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tv_show_cast_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`) ON DELETE CASCADE;

--
-- Tablo kısıtlamaları `tv_show_genres`
--
ALTER TABLE `tv_show_genres`
  ADD CONSTRAINT `tv_show_genres_ibfk_1` FOREIGN KEY (`tv_show_id`) REFERENCES `tv_shows` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tv_show_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
