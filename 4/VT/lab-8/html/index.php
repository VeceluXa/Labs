<?php
// Database connection details
$dbHost = '172.22.0.2';
$dbPort = '3306';
$dbUser = 'admin';
$dbPassword = 'admin';
$dbName = 'mydb';
$dbCharset = 'utf8mb4_general_ci';

// Create connection
$conn = mysqli_connect($dbHost, $dbUser, $dbPassword, $dbName, $dbPort);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Function to get visitor's IP address
function getIPAddress() {
    if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
        // IP from shared internet
        $ip = $_SERVER['HTTP_CLIENT_IP'];
    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        // IP passed from proxy
        $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
    } else {
        // Remote IP address
        $ip = $_SERVER['REMOTE_ADDR'];
    }
    return $ip;
}

// Get visitor's IP address
$ip = getIPAddress();

// Check if IP address exists in the database
$sql = "SELECT * FROM visitors WHERE ip_address = INET_ATON('$ip')";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // IP address already exists, update visit count
    $row = $result->fetch_assoc();
    $visitCount = $row['visits_count'] + 1;
    $sql = "UPDATE visitors SET visits_count = $visitCount WHERE ip_address = INET_ATON('$ip')";
    $conn->query($sql);
} else {
    // IP address doesn't exist, insert new record
    $sql = "INSERT INTO visitors (ip_address, visits_count) VALUES (INET_ATON('$ip'), 1)";
    $conn->query($sql);
}

// Retrieve all visitors' data in ascending order
$sql = "SELECT INET_NTOA(ip_address) AS ip, visits_count FROM visitors ORDER BY visits_count DESC";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Visits Tracker</title>
    <style>
        table {
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
            padding: 8px;
        }
    </style>
</head>
<body>
    <h1>Visits Tracker</h1>
    <table>
        <tr>
            <th>IP Address</th>
            <th>Number of Visits</th>
        </tr>
        <?php
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                echo "<tr>";
                echo "<td>" . $row['ip'] . "</td>";
                echo "<td>" . $row['visits_count'] . "</td>";
                echo "</tr>";
            }
        } else {
            echo "<tr><td colspan='2'>No records found.</td></tr>";
        }
        ?>
    </table>
</body>
</html>

<?php
// Close the database connection
$conn->close();
?>
