<?php require_once __DIR__ . '/partials/header.php'; ?>

<style>
    /* İki sütunlu düzen ve form stilleri */
    .edit-container { display: flex; flex-wrap: wrap; gap: 30px; }
    .main-column { flex: 2; min-width: 400px; }
    .side-column { flex: 1; min-width: 300px; }
    .form-group { margin-bottom: 20px; }
    .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
    .form-group input, .form-group textarea, .form-group select { width: 100%; box-sizing: border-box; padding: 8px; background-color: #333; border: 1px solid #555; color: #fff; border-radius: 4px; }
    .form-group textarea { min-height: 100px; resize: vertical; }
    .action-buttons { display: flex; gap: 10px; align-items: center; margin-top: 20px; }
    .action-buttons button, .action-buttons a { padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 14px; }
    .action-buttons .save-btn { background-color: #00aaff; color: #fff; }
    .action-buttons .seasons-btn { background-color: #555; color: #fff; }
    .media-manager { background-color: #2a2a2a; padding: 20px; border-radius: 5px; }
    .media-item { margin-bottom: 20px; }
    .media-item label { font-weight: bold; display: block; margin-bottom: 5px; }
    .media-preview img { max-width: 100%; height: auto; display: block; margin-bottom: 10px; background: #111; border-radius: 4px;}
    .media-input-group { display: flex; gap: 10px; }
    .media-input-group input { flex-grow: 1; }
    .cast-list { display: flex; flex-wrap: wrap; gap: 15px; margin-top: 5px; }
    .cast-member { display: flex; align-items: center; gap: 8px; background-color: #2a2a2a; padding: 5px; border-radius: 4px; font-size: 14px; }
    .cast-member img { width: 40px; height: 60px; object-fit: cover; border-radius: 3px; }
    .cast-member em { color: #ccc; font-style: normal; }
</style>

<main>
    <h1>Edit TV Show: <?php echo htmlspecialchars($tvShow['title']); ?></h1>
    <p><a href="/admin/tv-shows">&larr; Back to TV Show List</a></p>
    <hr>

    <div class="edit-container">
        <div class="main-column">
            <form action="/admin/tv-shows/edit/<?php echo $tvShow['id']; ?>" method="POST">
                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" id="title" name="title" required value="<?php echo htmlspecialchars($tvShow['title']); ?>">
                </div>
                
                <div class="form-group">
                    <label for="overview">Overview</label>
                    <textarea id="overview" name="overview" rows="8"><?php echo htmlspecialchars($tvShow['overview']); ?></textarea>
                </div>

                <div class="form-group">
                    <label for="first_air_date">First Air Date</label>
                    <input type="date" id="first_air_date" name="first_air_date" value="<?php echo $tvShow['first_air_date']; ?>">
                </div>
                
                <div class="form-group">
                    <label for="status">Status</label>
                    <select id="status" name="status">
                        <?php
                        $statuses = ['Returning Series', 'Ended', 'Canceled', 'In Production', 'Planned'];
                        $currentStatus = $tvShow['status'];
                        foreach ($statuses as $statusOption) {
                            $selected = ($statusOption == $currentStatus) ? 'selected' : '';
                            echo "<option value=\"{$statusOption}\" {$selected}>{$statusOption}</option>";
                        }
                        if (!in_array($currentStatus, $statuses) && !empty($currentStatus)) {
                            echo "<option value=\"" . htmlspecialchars($currentStatus) . "\" selected>" . htmlspecialchars($currentStatus) . " (Custom)</option>";
                        }
                        ?>
                    </select>
                </div>
                
                <input type="hidden" id="poster_path" name="poster_path" value="<?php echo htmlspecialchars($tvShow['poster_path']); ?>">
                <input type="hidden" id="backdrop_path" name="backdrop_path" value="<?php echo htmlspecialchars($tvShow['backdrop_path']); ?>">
                <input type="hidden" id="logo_path" name="logo_path" value="<?php echo htmlspecialchars($tvShow['logo_path'] ?? ''); ?>">
                <input type="hidden" id="trailer_key" name="trailer_key" value="<?php echo htmlspecialchars($tvShow['trailer_key'] ?? ''); ?>">

                <div class="action-buttons">
                    <button type="submit" class="save-btn">Save Changes</button>
                    <a href="/admin/manage-seasons/<?php echo $tvShow['id']; ?>" class="seasons-btn">Manage Seasons</a>
                </div>
            </form>

            <div id="genres-and-cast" style="margin-top: 20px; border-top: 1px solid #444; padding-top: 20px;">
                <div id="genres-preview">
                    <strong>Genres:</strong> 
                    <?php if (!empty($genres)): echo implode(', ', array_map(fn($g) => htmlspecialchars($g['name']), $genres)); else: echo 'N/A'; endif; ?>
                </div>
                <div id="cast-preview" style="margin-top: 20px;">
                    <strong>Cast:</strong>
                    <div class="cast-list">
                        <?php if (!empty($cast)): ?>
                            <?php foreach (array_slice($cast, 0, 10) as $person): ?>
                                <div class="cast-member">
                                    <img src="<?php echo !empty($person['profile_path']) ? 'https://image.tmdb.org/t/p/w45'.$person['profile_path'] : 'https://via.placeholder.com/40x60.png?text=N/A' ?>" alt="<?php echo htmlspecialchars($person['name']); ?>">
                                    <span><?php echo htmlspecialchars($person['name']); ?> <em>as <?php echo htmlspecialchars($person['character_name']); ?></em></span>
                                </div>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <p>N/A</p>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>

        <div class="side-column">
            <div class="media-manager">
                <h2>Media Management</h2>
                <div class="media-item">
                    <label>Poster</label>
                    <div class="media-preview" id="poster-preview">
                        <?php if (!empty($tvShow['poster_path'])): ?><img src="https://image.tmdb.org/t/p/w300<?php echo htmlspecialchars($tvShow['poster_path']); ?>" alt="Poster"><?php endif; ?>
                    </div>
                    <div class="media-input-group">
                        <input type="text" id="manual_poster_path" placeholder="Enter new poster path or full URL">
                        <button type="button" onclick="updatePreview('poster')">Update</button>
                    </div>
                </div>
                <div class="media-item">
                    <label>Backdrop</label>
                    <div class="media-preview" id="backdrop-preview">
                         <?php if (!empty($tvShow['backdrop_path'])): ?><img src="https://image.tmdb.org/t/p/w300<?php echo htmlspecialchars($tvShow['backdrop_path']); ?>" alt="Backdrop"><?php endif; ?>
                    </div>
                    <div class="media-input-group">
                        <input type="text" id="manual_backdrop_path" placeholder="Enter new backdrop path or full URL">
                        <button type="button" onclick="updatePreview('backdrop')">Update</button>
                    </div>
                </div>
                <div class="media-item">
                    <label>Logo</label>
                    <div class="media-preview" id="logo-preview" style="background: #222; padding: 10px; border-radius: 5px;">
                        <?php if (!empty($tvShow['logo_path'])): ?><img src="https://image.tmdb.org/t/p/w300<?php echo htmlspecialchars($tvShow['logo_path']); ?>" alt="Logo"><?php endif; ?>
                    </div>
                     <div class="media-input-group">
                        <input type="text" id="manual_logo_path" placeholder="Enter new logo path or full URL">
                        <button type="button" onclick="updatePreview('logo')">Update</button>
                    </div>
                </div>
                <div class="media-item">
                    <label>Trailer</label>
                    <div class="media-preview" id="trailer-preview">
                        <?php if (!empty($tvShow['trailer_key'])): ?>
                            <a href="https://www.youtube.com/watch?v=<?php echo htmlspecialchars($tvShow['trailer_key']); ?>" target="_blank">Watch current trailer</a>
                        <?php else: ?><p>No trailer found.</p><?php endif; ?>
                    </div>
                    <div class="media-input-group">
                        <input type="text" id="manual_trailer_key" placeholder="Enter new YouTube Key">
                        <button type="button" onclick="updatePreview('trailer')">Update</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    function getImageUrl(path) {
        if (!path || path.trim() === '') return '';
        if (path.startsWith('http')) return path;
        return 'https://image.tmdb.org/t/p/w300' + path;
    }
    function updatePreview(type) {
        const inputElement = document.getElementById('manual_' + type + '_path') || document.getElementById('manual_' + type + '_key');
        const hiddenInputElement = document.getElementById(type + '_path') || document.getElementById(type + '_key');
        const previewElement = document.getElementById(type + '-preview');
        const newValue = inputElement.value.trim();
        hiddenInputElement.value = newValue;
        if (type === 'trailer') {
            if (newValue) {
                previewElement.innerHTML = '<a href="https://www.youtube.com/watch?v=' + newValue + '" target="_blank">Watch new trailer</a>';
            } else {
                previewElement.innerHTML = '<p>No trailer found.</p>';
            }
        } else {
            const imageUrl = getImageUrl(newValue);
            if (imageUrl) {
                previewElement.innerHTML = '<img src="' + imageUrl + '" alt="' + type + '">';
            } else {
                previewElement.innerHTML = '<p>No ' + type + ' found.</p>';
            }
        }
    }
</script>

<?php require_once __DIR__ . '/partials/footer.php'; ?>