<?php
session_start();

// Check if the user is logged in
if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit();
}

// Database credentials
define('DB_HOST', '172.19.0.2');
define('DB_PORT', '3306');
define('DB_USER', 'admin');
define('DB_PASSWORD', 'password');
define('DB_NAME', 'user_authentication');
define('DB_CHARSET', 'utf8mb4_general_ci');

// Create a database connection
$conn = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Function to authenticate user credentials
function authenticateUser($username, $password, $conn) {
    $sql = "SELECT * FROM user WHERE login = '$username' AND password = '$password'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        return true;
    } else {
        return false;
    }
}

// Check if the user submitted the login form
if (isset($_POST['login'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Authenticate user credentials
    if (authenticateUser($username, $password, $conn)) {
        $_SESSION['username'] = $username;
    } else {
        $loginError = "Invalid username or password";
    }
}

// Logout the user
if (isset($_GET['logout'])) {
    session_destroy();
    header("Location: login.php");
    exit();
}

// File upload handling
if (isset($_POST['upload'])) {
    $targetDir = "uploads/";
    $filename = basename($_FILES['file']['name']);
    $targetPath = $targetDir . $filename;

    if (move_uploaded_file($_FILES['file']['tmp_name'], $targetPath)) {
        $uploadSuccess = "File uploaded successfully";
    } else {
        $uploadError = "Error uploading the file";
    }
}

// File deletion handling
if (isset($_GET['delete'])) {
    $filename = $_GET['delete'];
    $filePath = "uploads/" . $filename;

    if (file_exists($filePath)) {
        unlink($filePath);
        $deleteSuccess = "File deleted successfully";
    } else {
        $deleteError = "File not found";
    }
}

// Get the list of files in the upload directory
$files = scandir("uploads");

// Display the file manager interface
?>
<!DOCTYPE html>
<html>
<head>
    <title>File Manager</title>
</head>
<body>
    <h1>File Manager</h1>
    <h3>Welcome, <?php echo $_SESSION['username']; ?>!</h3>

    <a href="?logout=true">Logout</a>

    <h2>File List</h2>
    <?php
    if (!empty($files)) {
        foreach ($files as $file) {
            if ($file != '.' && $file != '..') {
                echo "<a href='uploads/$file'>$file</a> ";
                echo "<a href='?delete=$file'>Delete</a><br>";

                // Display preview for image files
                $fileExt = pathinfo($file, PATHINFO_EXTENSION);
                if (in_array($fileExt, ['jpg', 'jpeg', 'png', 'gif'])) {
                    echo "<img src='uploads/$file' width='100'><br>";
                }

                // Display preview for text files
                if ($fileExt === 'txt') {
                    $fileContent = file_get_contents("uploads/$file");
                    echo "<pre>$fileContent</pre><br>";
                }
            }
        }
    } else {
        echo "No files found";
    }
    ?>

    <h2>Upload File</h2>
    <?php
        if (isset($uploadSuccess)) {
            echo "<p style='color: green;'>$uploadSuccess</p>";
        } elseif (isset($uploadError)) {
            echo "<p style='color: red;'>$uploadError</p>";
        }
    ?>
    <form method="post" enctype="multipart/form-data">
        <input type="file" name="file" required>
        <input type="submit" name="upload" value="Upload">
    </form>
    <?php
        // Display delete success message
        if (isset($deleteSuccess)) {
            echo "<p style='color: green;'>$deleteSuccess</p>";
        } elseif (isset($deleteError)) {
            echo "<p style='color: red;'>$deleteError</p>";
        }
    ?>
</body>
</html>