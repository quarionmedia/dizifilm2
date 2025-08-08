<?php

/**
 * Loads a view file and passes data to it.
 * @param string $name The name of the view file to load.
 * @param array $data The data to pass to the view.
 */
function view($name, $data = []) {
    // Converts array keys into variables.
    // Example: ['title' => 'Homepage'] becomes $title = 'Homepage';
    extract($data);
    
    // Require the corresponding view file
    // The path is relative to the `app` directory
    return require_once __DIR__ . "/Views/{$name}.php";
}

/**
 * Gets a setting value from the database.
 * It loads all settings once and stores them in a static variable for efficiency.
 * @param string $key The name of the setting to get.
 * @param mixed $default The default value to return if the setting is not found.
 * @return mixed The value of the setting or the default value.
 */
function setting($key, $default = null) {
    static $settings = null;

    // If settings have not been loaded yet, load them from the database
    if (is_null($settings)) {
        // Use the fully qualified namespace to find the class from the global scope
        $settingModel = new \App\Models\SettingModel();
        $settings = $settingModel->getAllSettings();
    }

    // Return the specific setting, or the default value if it doesn't exist
    return $settings[$key] ?? $default;
}