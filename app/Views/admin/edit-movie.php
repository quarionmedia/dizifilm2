<?php require_once __DIR__ . '/partials/header.php'; ?>

<style>
    .media-manager { margin-top: 30px; border-top: 1px solid #444; padding-top: 20px; }
    .media-item { margin-bottom: 20px; }
    .media-item label { font-weight: bold; display: block; margin-bottom: 5px; }
    .media-preview img { max-width: 300px; max-height: 300px; display: block; margin-bottom: 10px; background: #111; }
    .media-input-group { display: flex; gap: 10px; }
    .media-input-group input { flex-grow: 1; }
</style>

<main>
    <h1>Edit Movie: <?php echo htmlspecialchars($movie['title']); ?></h1>

    <form action="/admin/movies/edit/<?php echo $movie['id']; ?>" method="POST">
        
        <div>
            <label for="title">Title:</label><br>
            <input type="text" id="title" name="title" required style="width: 400px;" value="<?php echo htmlspecialchars($movie['title']); ?>"><br><br>
            
            <label for="overview">Overview:</label><br>
            <textarea id="overview" name="overview" rows="5" style="width: 400px;"><?php echo htmlspecialchars($movie['overview']); ?></textarea><br><br>

            <label for="release_date">Release Date:</label><br>
            <input type="date" id="release_date" name="release_date" value="<?php echo $movie['release_date']; ?>"><br><br>

            <label for="runtime">Runtime (minutes):</label><br>
            <input type="number" id="runtime" name="runtime" value="<?php echo $movie['runtime']; ?>"><br><br>

            <label for="video_url">Video URL (.m3u8, .mpd, etc.):</label><br>
            <input type="text" id="video_url" name="video_url" style="width: 400px;" value="<?php echo htmlspecialchars($movie['video_url'] ?? ''); ?>"><br><br>
            
            <input type="hidden" id="poster_path" name="poster_path" value="<?php echo htmlspecialchars($movie['poster_path']); ?>">
            <input type="hidden" id="backdrop_path" name="backdrop_path" value="<?php echo htmlspecialchars($movie['backdrop_path']); ?>">
            <input type="hidden" id="logo_path" name="logo_path" value="<?php echo htmlspecialchars($movie['logo_path'] ?? ''); ?>">
            <input type="hidden" id="trailer_key" name="trailer_key" value="<?php echo htmlspecialchars($movie['trailer_key'] ?? ''); ?>">

            <button type="submit">Save Changes</button>
        </div>
    </form>

    <div class="media-manager">
        <h2>Media Management</h2>

        <div class="media-item">
            <label>Poster</label>
            <div class="media-preview" id="poster-preview">
                <img src="https://image.tmdb.org/t/p/w300<?php echo htmlspecialchars($movie['poster_path']); ?>" alt="Poster">
            </div>
            <div class="media-input-group">
                <input type="text" id="manual_poster_path" placeholder="Enter new poster path or full URL">
                <button type="button" onclick="updatePreview('poster')">Update Preview</button>
            </div>
        </div>

        <div class="media-item">
            <label>Backdrop</label>
            <div class="media-preview" id="backdrop-preview">
                 <img src="https://image.tmdb.org/t/p/w300<?php echo htmlspecialchars($movie['backdrop_path']); ?>" alt="Backdrop">
            </div>
            <div class="media-input-group">
                <input type="text" id="manual_backdrop_path" placeholder="Enter new backdrop path or full URL">
                <button type="button" onclick="updatePreview('backdrop')">Update Preview</button>
            </div>
        </div>

        <div class="media-item">
            <label>Logo</label>
            <div class="media-preview" id="logo-preview" style="background: #333; padding: 10px;">
                <?php if (!empty($movie['logo_path'])): ?>
                    <img src="https://image.tmdb.org/t/p/w300<?php echo htmlspecialchars($movie['logo_path']); ?>" alt="Logo">
                <?php else: ?>
                    <p>No logo found.</p>
                <?php endif; ?>
            </div>
            <div class="media-input-group">
                <input type="text" id="manual_logo_path" placeholder="Enter new logo path or full URL">
                <button type="button" onclick="updatePreview('logo')">Update Preview</button>
            </div>
        </div>

        <div class="media-item">
            <label>Trailer</label>
            <div class="media-preview" id="trailer-preview">
                <?php if (!empty($movie['trailer_key'])): ?>
                    <a href="https://www.youtube.com/watch?v=<?php echo htmlspecialchars($movie['trailer_key']); ?>" target="_blank">Watch current trailer on YouTube</a>
                <?php else: ?>
                    <p>No trailer found.</p>
                <?php endif; ?>
            </div>
            <div class="media-input-group">
                <input type="text" id="manual_trailer_key" placeholder="Enter new YouTube Video Key (e.g., d_m5c_4_g)">
                <button type="button" onclick="updatePreview('trailer')">Update Preview</button>
            </div>
        </div>
    </div>
</main>

<script>
    function getImageUrl(path) {
        if (!path) return '';
        // Eğer tam bir URL ise, olduğu gibi kullan. Değilse, TMDb URL'si oluştur.
        if (path.startsWith('http')) {
            return path;
        }
        return 'https://image.tmdb.org/t/p/w300' + path;
    }

    function updatePreview(type) {
        const inputElement = document.getElementById('manual_' + type + '_path') || document.getElementById('manual_' + type + '_key');
        const hiddenInputElement = document.getElementById(type + '_path') || document.getElementById(type + '_key');
        const previewElement = document.getElementById(type + '-preview');

        const newValue = inputElement.value.trim();
        hiddenInputElement.value = newValue; // Gizli alanı her zaman güncelle

        if (type === 'trailer') {
            if (newValue) {
                previewElement.innerHTML = '<a href="https://www.youtube.com/watch?v=' + newValue + '" target="_blank">Watch new trailer on YouTube</a>';
            } else {
                previewElement.innerHTML = '<p>No trailer found.</p>';
            }
        } else {
            if (newValue) {
                previewElement.innerHTML = '<img src="' + getImageUrl(newValue) + '" alt="' + type + '">';
            } else {
                previewElement.innerHTML = '<p>No ' + type + ' found.</p>';
            }
        }
    }
</script>

<?php require_once __DIR__ . '/partials/footer.php'; ?>