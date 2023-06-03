<?php
session_start();

// Redirect to file manager if user is already logged in
if (isset($_SESSION['username'])) {
    header("Location: index.php");
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
    $rememberMe = isset($_POST['remember_me']) ? $_POST['remember_me'] : false;

    // Authenticate user credentials
    if (authenticateUser($username, $password, $conn)) {
        $_SESSION['username'] = $username;

        // Set remember me cookie if requested
        if ($rememberMe) {
            $expiryTime = time() + 86400; // 1 day (24 hours)
            setcookie('remember_me', $username, $expiryTime);
        }

        header("Location: index.php");
        exit();
    } else {
        $loginError = "Invalid username or password";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h1>Login</h1>

    <?php
    if (isset($loginError)) {
        echo "<p style='color: red;'>$loginError</p>";
    }
    ?>

    <form method="post">
        <label for="username">Username:</label>
        <input type="text" name="username" required><br><br>

        <label for="password">Password:</label>
        <input type="password" name="password" required><br><br>
        <label for="remember_me">Remember Me:</label>
        <input type="checkbox" name="remember_me"><br><br>

        <input type="submit" name="login" value="Login">
    </form>
</body>
</html>