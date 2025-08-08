<?php require_once __DIR__ . '/../partials/header.php'; ?>

<h1>Login</h1>
<form action="/login" method="POST">
    <label for="email">Email:</label><br>
    <input type="email" id="email" name="email" required><br><br>

    <label for="password">Password:</label><br>
    <input type="password" id="password" name="password" required><br><br>

    <button type="submit">Login</button>
</form>

<?php require_once __DIR__ . '/../partials/footer.php'; ?>