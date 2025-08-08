<?php
// Session başlatma (eğer zaten başlatılmadıysa)
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
?>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo isset($title) ? htmlspecialchars($title) . ' | ' . htmlspecialchars(setting('site_name', 'MuvixTV')) : htmlspecialchars(setting('site_name', 'MuvixTV')); ?></title>
    
    <link rel="icon" type="image/png" href="/assets/images/<?php echo htmlspecialchars(setting('favicon_path', 'favicon.png')); ?>">
    
    <link rel="stylesheet" href="/assets/css/style.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <style>
        body {
            background-color: #121212;
            color: #fff;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            margin: 0;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }
        .site-header {
            background-color: rgba(18, 18, 18, 0.8); /* Yarı şeffaf header */
            padding: 20px 0;
            position: fixed;
            width: 100%;
            z-index: 100;
        }
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }
        .site-header .logo {
            font-size: 24px;
            font-weight: bold;
            color: #42ca1a;
            text-decoration: none;
        }
        .main-nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 20px;
        }
        .main-nav a {
            color: #fff;
            text-decoration: none;
            font-weight: bold;
        }
        .header-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .header-actions .search-icon, .header-actions .user-icon {
            font-size: 18px;
            cursor: pointer;
        }
        .sign-in-btn {
            background-color: #42ca1a;
            color: #fff;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>

<header class="site-header">
    <div class="header-content">
        <a href="/" class="logo">
            <?php if (!empty(setting('logo_path'))): ?>
                <img src="/assets/images/<?php echo htmlspecialchars(setting('logo_path')); ?>" alt="<?php echo htmlspecialchars(setting('site_name')); ?>" style="max-height: 40px;">
            <?php else: ?>
                <?php echo htmlspecialchars(setting('site_name', 'MuvixTV')); ?>
            <?php endif; ?>
        </a>

        <nav class="main-nav">
            <ul>
                <li><a href="/">HOME</a></li>
                <li><a href="#">CATALOG</a></li>
            </ul>
        </nav>

        <div class="header-actions">
            <i class="fas fa-search search-icon"></i>
            <?php if (isset($_SESSION['user_id'])): ?>
                <span><?php echo htmlspecialchars($_SESSION['user_email']); ?></span>
                <a href="/logout">Logout</a>
            <?php else: ?>
                <a href="/login" class="sign-in-btn">SIGN IN</a>
            <?php endif; ?>
        </div>
    </div>
</header>