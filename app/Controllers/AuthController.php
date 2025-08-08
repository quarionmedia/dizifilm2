<?php
namespace App\Controllers;
use App\Models\UserModel;
class AuthController {
    public function showRegisterForm() {
        return view('auth/register', ['title' => 'Register']);
    }

    public function register() {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        $email = $_POST['email'] ?? '';
        $password = $_POST['password'] ?? '';
        $password_confirm = $_POST['password_confirm'] ?? '';

        if (empty($email) || empty($password)) {
            die('Email and password cannot be empty.');
        }
        if ($password !== $password_confirm) {
            die('Passwords do not match.');
        }
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            die('Please enter a valid email address.');
        }

        $userModel = new UserModel();
        $newUserId = $userModel->create($email, $password);

        if ($newUserId) {
            // Kayıt başarılı, şimdi otomatik olarak giriş yapalım
            $_SESSION['user_id'] = $newUserId;
            $_SESSION['user_email'] = $email;
            $_SESSION['is_admin'] = 0; // Yeni her kullanıcı standart kullanıcıdır.

            // Ana sayfaya yönlendir
            header("Location: /");
            exit();
        } else {
            die("An error occurred during registration, or this email is already in use.");
        }
    }

    public function showLoginForm() {
        return view('auth/login', ['title' => 'Login']);
    }

    public function login() {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        $email = $_POST['email'] ?? '';
        $password = $_POST['password'] ?? '';

        if (empty($email) || empty($password)) {
            die('Email and password are required.');
        }

        $userModel = new UserModel();
        $user = $userModel->findByEmail($email);

        if ($user && password_verify($password, $user['password_hash'])) {
            // Şifre doğru, giriş başarılı.
            // Kullanıcı bilgilerini ve YETKİSİNİ session'a kaydet.
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['user_email'] = $user['email'];
            $_SESSION['is_admin'] = $user['is_admin']; // <-- YAPILAN DEĞİŞİKLİK BURADA

            // Ana sayfaya yönlendir
            header("Location: /");
            exit();
        } else {
            // Hatalı giriş
            die('Invalid email or password.');
        }
    }

    public function logout() {
        // Session'ı başlatmadan önce kontrol et
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
        // Tüm session verilerini temizle
        session_unset();
        // Session'ı sonlandır
        session_destroy();

        // Kullanıcıyı ana sayfaya yönlendir
        header('Location: /');
        exit();
    }
}