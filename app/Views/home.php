<?php require_once __DIR__ . '/partials/header.php'; ?>

<!-- Yatay kaydırma (Carousel) için SwiperJS kütüphanesi -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<style>
    /* STREAM X - Netflix Tarzı Tam Genişlikli Tasarım */
    .hero-section {
        height: 80vh;
        min-height: 500px;
        background-size: cover;
        background-position: center 20%;
        display: flex;
        align-items: center;
        position: relative;
    }
    .hero-section::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(to right, rgba(18, 18, 18, 1) 10%, rgba(18, 18, 18, 0) 50%, rgba(18, 18, 18, 1) 100%), 
                    linear-gradient(to top, rgba(18, 18, 18, 1) 10%, rgba(18, 18, 18, 0) 50%);
    }
    .hero-content {
        z-index: 1;
        max-width: 50%;
        padding-left: 5%; /* Yan boşluk */
    }
    .hero-content .logo-image {
        max-width: 80%;
        height: auto;
        max-height: 200px;
        margin-bottom: 20px;
    }
    .hero-content h1 {
        font-size: 48px;
        margin: 0 0 10px 0;
        text-shadow: 2px 2px 8px rgba(0,0,0,0.7);
    }
    .hero-content p {
        font-size: 16px;
        line-height: 1.6;
        max-width: 500px;
    }
    .hero-buttons {
        margin-top: 20px;
    }
    .hero-buttons .btn {
        padding: 12px 25px;
        text-decoration: none;
        border-radius: 5px;
        font-weight: bold;
        margin-right: 15px;
        font-size: 16px;
        display: inline-block;
    }
    .btn-watch {
        background-color: #42ca1a;
        color: #fff;
    }
    .btn-info {
        background-color: rgba(100, 100, 100, 0.7);
        color: #fff;
    }

    .content-section {
        padding: 0 5%; /* Yan boşluklar */
        margin-bottom: 40px;
    }
    .section-header {
        margin-bottom: 20px;
    }
    .section-header h2 {
        margin: 0;
        font-size: 24px;
    }

    /* Carousel Stilleri */
    .content-carousel {
        width: 100%;
        overflow: hidden;
    }
    .swiper-slide {
        width: 320px; /* Yatay poster genişliği */
    }
    .swiper-slide a {
        display: block;
        text-decoration: none;
        color: #fff;
        position: relative; /* Logo konumlandırması için */
        border-radius: 5px;
        overflow: hidden;
    }
    .swiper-slide .backdrop-img {
        width: 100%;
        height: 180px; /* 16:9 oran için yükseklik */
        object-fit: cover;
        transition: transform 0.2s;
    }
    .swiper-slide:hover .backdrop-img {
        transform: scale(1.05);
    }
    .swiper-slide .logo-overlay {
        position: absolute;
        bottom: 15px;
        left: 15px;
        max-width: 60%;
        max-height: 60px;
    }
    
    /* Trendler Bölümü Stilleri */
    .trending-list {
        display: flex;
        gap: 20px;
        align-items: flex-end;
        overflow-x: auto;
        padding-bottom: 15px;
    }
    .trending-item {
        display: flex;
        align-items: center;
        flex-shrink: 0;
    }
    .trending-item .rank {
        font-size: 150px;
        font-weight: bold;
        line-height: 1;
        margin-right: -20px;
        z-index: 1;
        -webkit-text-stroke: 2px #555;
        color: #121212;
    }
    .trending-item img {
        width: 150px;
        height: 225px;
        object-fit: cover;
        border-radius: 5px;
        transition: transform 0.2s;
    }
    .trending-item a:hover img {
        transform: scale(1.05);
    }
</style>

<!-- Hero Section -->
<?php $heroContent = $latestMovies[0] ?? $latestTvShows[0] ?? null; ?>
<?php if ($heroContent): ?>
<div class="hero-section" style="background-image: url('https://image.tmdb.org/t/p/original<?php echo $heroContent['backdrop_path']; ?>');">
    <div class="hero-content">
        <?php if (!empty($heroContent['logo_path'])): ?>
            <img class="logo-image" src="https://image.tmdb.org/t/p/w500<?php echo $heroContent['logo_path']; ?>" alt="<?php echo htmlspecialchars($heroContent['title']); ?>">
        <?php else: ?>
            <h1><?php echo htmlspecialchars($heroContent['title']); ?></h1>
        <?php endif; ?>
        
        <p><?php echo htmlspecialchars(substr($heroContent['overview'], 0, 150)); ?>...</p>
        <div class="hero-buttons">
            <a href="#" class="btn btn-watch"><i class="fas fa-play"></i> Watch Now</a>
            <a href="#" class="btn btn-info">More Info</a>
        </div>
    </div>
</div>
<?php endif; ?>

<!-- Ana İçerik Alanı -->
<div style="margin-top: 40px;">

    <!-- Latest & Trending Section -->
    <div class="content-section">
        <div class="section-header">
            <h2>Latest & Trending</h2>
        </div>
        <div class="trending-list">
            <?php foreach (array_slice($latestTvShows, 0, 5) as $index => $tvShow): ?>
                <div class="trending-item">
                    <span class="rank"><?php echo $index + 1; ?></span>
                    <a href="#"><img src="https://image.tmdb.org/t/p/w300<?php echo $tvShow['poster_path']; ?>" alt="<?php echo htmlspecialchars($tvShow['title']); ?>"></a>
                </div>
            <?php endforeach; ?>
        </div>
    </div>

    <!-- Latest Movies Carousel (Yazılı Posterler) -->
    <div class="content-section">
         <div class="section-header">
            <h2>Latest Movies</h2>
        </div>
        <div class="swiper-container content-carousel">
            <div class="swiper-wrapper">
                <?php foreach($latestMovies as $movie): ?>
                    <div class="swiper-slide">
                        <a href="#">
                            <img class="backdrop-img" src="https://image.tmdb.org/t/p/w500<?php echo $movie['backdrop_path']; ?>" alt="<?php echo htmlspecialchars($movie['title']); ?>">
                            <?php if (!empty($movie['logo_path'])): ?>
                                <img class="logo-overlay" src="https://image.tmdb.org/t/p/w500<?php echo $movie['logo_path']; ?>" alt="">
                            <?php endif; ?>
                        </a>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>

    <!-- Latest TV Shows Carousel (Yazılı Posterler) -->
    <div class="content-section">
        <div class="section-header">
            <h2>Latest TV Shows</h2>
        </div>
        <div class="swiper-container content-carousel">
            <div class="swiper-wrapper">
                <?php foreach($latestTvShows as $tvShow): ?>
                    <div class="swiper-slide">
                        <a href="#">
                            <img class="backdrop-img" src="https://image.tmdb.org/t/p/w500<?php echo $tvShow['backdrop_path']; ?>" alt="<?php echo htmlspecialchars($tvShow['title']); ?>">
                             <?php if (!empty($tvShow['logo_path'])): ?>
                                <img class="logo-overlay" src="https://image.tmdb.org/t/p/w500<?php echo $tvShow['logo_path']; ?>" alt="">
                            <?php endif; ?>
                        </a>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
    
</div>

<script>
    // Tüm Carousel'ları Başlat
    var swiper = new Swiper('.content-carousel', {
        slidesPerView: 'auto',
        spaceBetween: 20,
        freeMode: true,
    });
</script>

<?php require_once __DIR__ . '/partials/footer.php'; ?>