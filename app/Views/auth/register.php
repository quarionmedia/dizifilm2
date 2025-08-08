<?php require_once __DIR__ . '/../partials/header.php'; ?>

<h1>Register</h1>
<form action="/register" method="POST">
    <label for="email">Email:</label><br>
    <input type="email" id="email" name="email" required><br><br>

    <label for="password">Password:</label><br>
    <input type="password" id="password" name="password" required><br><br>

    <label for="password_confirm">Confirm Password:</label><br>
    <input type="password" id="password_confirm" name="password_confirm" required><br><br>

    <button type="submit">Register</button>
</form>

<?php require_once __DIR__ . '/../partials/footer.php'; ?>