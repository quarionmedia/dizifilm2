<?php
// Tarayıcının admin sayfalarını cache'lemesini (önbelleğe almasını) engelle
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

// Session başlatma (eğer zaten başlatılmadıysa)
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title><?php echo isset($title) ? $title . ' | ' . htmlspecialchars(setting('site_name', 'MuvixTV')) . ' Admin' : htmlspecialchars(setting('site_name', 'MuvixTV')) . ' Admin'; ?></title>
    <link rel="icon" type="image/png" href="/assets/images/<?php echo htmlspecialchars(setting('favicon_path', 'favicon.png')); ?>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <style>
        body { margin: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; background-color: #0e0e0eff; color: #d1d5db; }
        * { box-sizing: border-box; }
        a { color: #42ca1a; text-decoration: none; }
        a:hover { color: #86efac; }
        
        .admin-wrapper { display: flex; }
        .sidebar { width: 250px; background-color: #1d1d1dff; height: 100vh; position: fixed; top: 0; left: 0; padding: 20px; overflow-y: auto; }
        .content-wrapper { margin-left: 250px; width: calc(100% - 250px); }
        .top-header { background-color: #1a1a1a; padding: 10px 30px; display: flex; justify-content: space-between; align-items: center; height: 60px; }
        .main-content { padding: 30px; }
        
        .sidebar-logo a { font-size: 35px; font-weight: bold; }
        .sidebar-nav { margin-top: 30px; }
        .sidebar-nav p { color: #888; text-transform: uppercase; font-size: 12px; font-weight: bold; margin: 20px 0 10px; }
        .sidebar-nav ul { list-style: none; padding: 0; margin: 0; }
        .sidebar-nav ul li a { color: #d1d5db; display: block; padding: 10px; border-radius: 5px; position: relative; transition: background-color 0.2s; }
        .sidebar-nav ul li a:hover { background-color: #00000041; }
        
        .sidebar-nav .sub-menu { display: none; padding-left: 20px; }
        .sidebar-nav .menu-item-has-children.open > .sub-menu { display: block; }
        .sidebar-nav .menu-item-has-children > a::after { content: '▼'; font-size: 10px; position: absolute; right: 15px; top: 50%; transform: translateY(-50%); transition: transform 0.2s; }
        .sidebar-nav .menu-item-has-children.open > a::after { transform: translateY(-50%) rotate(180deg); }

        /* Üst Header Elemanları */
        .header-left, .header-right { display: flex; align-items: center; gap: 20px; }
        .header-dropdown { position: relative; }
        .header-dropdown-button { background: #333; color: #fff; border: 1px solid #555; padding: 8px 15px; border-radius: 5px; cursor: pointer; display: flex; align-items: center; gap: 5px; }
        .header-dropdown-content { display: none; position: absolute; top: 120%; background: #333; border: 1px solid #555; border-radius: 5px; z-index: 100; min-width: 160px; padding: 5px 0; }
        .header-dropdown.open .header-dropdown-content { display: block; }
        .header-dropdown-content a { display: block; padding: 8px 15px; color: #fff; }
        .header-dropdown-content a:hover { background-color: #555; }
        .search-bar { background: #333; border: 1px solid #555; border-radius: 5px; display: flex; align-items: center; padding: 0 10px; }
        .search-bar input { background: transparent; border: none; color: #fff; padding: 8px; outline: none; }
        .header-icon { font-size: 18px; color: #aaa; cursor: pointer; }
        
        /* KULLANICI PROFİLİ DÜZELTMESİ */
        #user-dropdown .header-dropdown-button {
            background: transparent;
            border: none;
            padding: 0;
            border-radius: 50%; /* Butonu yuvarlak yap */
            width: 36px;  /* Resimden biraz daha büyük */
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        #user-dropdown .header-dropdown-button img {
            width: 32px;
            height: 32px;
            border-radius: 50%;
        }
        #user-dropdown .header-dropdown-content { right: 0; left: auto; }
    </style>
</head>
<body>

<div class="admin-wrapper">
    <aside class="sidebar">
        <div class="sidebar-logo">
            <a href="/admin"><?php echo htmlspecialchars(setting('site_name', 'MuvixTV')); ?></a>
        </div>
        <nav class="sidebar-nav">
            <p>Management</p>
            <ul>
                <li><a href="/admin">Dashboard</a></li>
                <li class="menu-item-has-children">
                    <a href="#">Movies</a>
                    <ul class="sub-menu">
                        <li><a href="/admin/movies">All Movies</a></li>
                        <li><a href="/admin/movies/add">Add Movie</a></li>
                    </ul>
                </li>
                <li class="menu-item-has-children">
                    <a href="#">TV Shows</a>
                    <ul class="sub-menu">
                        <li><a href="/admin/tv-shows">All TV Shows</a></li>
                        <li><a href="/admin/tv-shows/add">Add Tv Show</a></li>
                    </ul>
                </li>
                <li><a href="/admin/genres">Genres</a></li>
                <li><a href="/admin/platforms">Content Platforms</a></li>
            </ul>
            <p>Community</p>
            <ul>
                <li><a href="/admin/users">Users</a></li>
                <li><a href="/admin/comments">Comments</a></li>
                <li><a href="/admin/reports">Reports</a></li>
                <li><a href="/admin/requests">Requests</a></li>
            </ul>
            <p>System</p>
            <ul>
                <li class="menu-item-has-children">
                    <a href="#">General Settings</a>
                    <ul class="sub-menu">
                        <li><a href="/admin/settings/general">Site Settings</a></li>
                        <li><a href="/admin/settings/api">API Settings</a></li>
                        <li><a href="/admin/settings/security">Security</a></li>
                    </ul>
                </li>
                <li class="menu-item-has-children">
                    <a href="#">Email Settings</a>
                    <ul class="sub-menu">
                        <li><a href="/admin/smtp-settings">Smtp Settings</a></li>
                        <li><a href="/admin/settings/email-templates">Email Templates</a></li>
                    </ul>
                </li>
                <li><a href="/admin/menu">Menu Manager</a></li>
                <li><a href="/admin/ads-settings">Advertisement</a></li>
                <li><a href="/admin/content-networks">Content Networks</a></li>
                <li><a href="/logout">Logout</a></li>
            </ul>
        </nav>
    </aside>

    <div class="content-wrapper">
        <header class="top-header">
            <div class="header-left">
                <a href="/" target="_blank" class="header-dropdown-button">Back to site</a>
                <div class="header-dropdown" id="create-dropdown">
                    <button type="button" class="header-dropdown-button">Create ▼</button>
                    <div class="header-dropdown-content">
                        <a href="/admin/movies/add">Add Movie</a>
                        <a href="/admin/tv-shows/add">Add Web Series</a>
                    </div>
                </div>
            </div>
            <div class="header-right">
                <div class="search-bar">
                    <i class="fa fa-search"></i>
                    <input type="text" placeholder="Search...">
                </div>
                <i class="fa-solid fa-expand header-icon" title="Fullscreen"></i>
                <div class="header-dropdown" id="user-dropdown">
                    <button type="button" class="header-dropdown-button">
                        <img src="https://ui-avatars.com/api/?name=<?php echo urlencode($_SESSION['user_email'] ?? 'A'); ?>&background=random" alt="User Avatar">
                    </button>
                    <div class="header-dropdown-content">
                        <a href="#">Profile</a>
                        <a href="/logout" style="color: #ff4d4d;">Logout</a>
                    </div>
                </div>
            </div>
        </header>

        <main class="main-content">