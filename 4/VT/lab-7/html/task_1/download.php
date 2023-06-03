<?php
// Download from https://sourceforge.net/projects/simplehtmldom/
require 'simple_html_dom.php';

function processPage($url, $path, $depth): void
{
    if ($depth <= 1) {
        $opts = [
            "ssl" => [
                "verify_peer" => false,
                "verify_peer_name" => false,
            ],
            "http" => [
                "user_agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36",
            ],
        ];
        $context = stream_context_create($opts);

        // Get HTML of the page
        $html = file_get_html($url, false, $context);
        if ($html === false) {
            echo "<h2>Failed to parse website</h2>";
            return;
        }

        $pageFolder = $path . DIRECTORY_SEPARATOR . basename($url);
        if (!is_dir($pageFolder)) {
            echo "FOLDER: " . $pageFolder . '<br>';
            mkdir($pageFolder, 0777, true);
        }

        $class = $html->find('img');
	    $counter = 0;
	    $maxSize = 25;
        foreach ($class as $img) {
            $image_url = $img->src;
            if (!str_starts_with($image_url, "https://wallpapercave.com")) {
                $image_url = "https://wallpapercave.com" . $image_url;
            }
            echo "<p>Link: " . $image_url . "</p>";

            $filename = basename($image_url);
            $filepath = $pageFolder . DIRECTORY_SEPARATOR . $filename;

            if (!file_exists($filepath)){
                echo "DOWNLOADED: " . $filepath  . '<br>';
                $image_data = file_get_contents($image_url, false, $context);
                if ($image_data !== false) {
                    file_put_contents($filepath, $image_data);
                }
            }

            $counter++;

            if ($counter >= $maxSize) {
                break;
            }
        }

        // Find and process subpages
        $class = $html->find('a');
        foreach ($class as $link) {
            if ($link->class === "albumthumbnail") {
                $subpage_url = $link->href;
                if (!str_starts_with($subpage_url, "https://wallpapercave.com")) {
                    // Construct full URL if the link is relative
                    $subpage_url = "https://wallpapercave.com" . $subpage_url;
                }
                echo "SUBPAGE: " . $subpage_url . '<br>';

                // Process the subpage recursively
                processPage($subpage_url, $path, $depth + 1);
            }
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    // error_reporting(0);
    // ini_set('display_errors', 0);

    $url = $_POST['url'];

    $parts = parse_url($url);
    $targetDir = "./images/";
	$baseURL = $parts['host'];

    // Create the folder structure if it doesn't exist
    $folderPath = $targetDir . $baseURL;
    if (!file_exists($folderPath)) {
        mkdir($folderPath, 0777, true);
    }

    // Check if folder exists
    if (!is_dir($folderPath) || !is_writable($folderPath)) {
        echo 'Directory does not exist or non-writable';
        exit;
    }

    // Call the processPage function to start the analysis and image download
    processPage($url, $folderPath, 0);

    echo 'All images were successfully downloaded!';
} else {
    header('Location: index.html');
    exit;
}