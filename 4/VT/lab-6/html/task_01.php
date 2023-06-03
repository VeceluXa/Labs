<?php
    // Check if the form is submitted
    if (isset($_POST['submit'])) {
        // Get the selected values from the form
        $backgroundColor = $_POST['background_color'];
        $fontSize = $_POST['font_size'];
        $fontColor = $_POST['font_color'];
        $headingColor = $_POST['heading_color'];

        // Set the corresponding cookies
        setcookie('background_color', $backgroundColor, time() + (86400 * 30), '/');
        setcookie('font_size', $fontSize, time() + (86400 * 30), '/');
        setcookie('font_color', $fontColor, time() + (86400 * 30), '/');
        setcookie('heading_color', $headingColor, time() + (86400 * 30), '/');
    }

    // Check if the cookies are set
    $backgroundColor = isset($_COOKIE['background_color']) ? $_COOKIE['background_color'] : '';
    $fontSize = isset($_COOKIE['font_size']) ? $_COOKIE['font_size'] : '';
    $fontColor = isset($_COOKIE['font_color']) ? $_COOKIE['font_color'] : '';
    $headingColor = isset($_COOKIE['heading_color']) ? $_COOKIE['heading_color'] : '';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Style Settings</title>
</head>
<body>
    <h1>Style Settings</h1>

    <form method="post">
        <label for="background_color">Background Color:</label>
        <select name="background_color">
            <option value="">-- Select Background Color --</option>
            <option value="red" <?php if ($backgroundColor === 'red') echo 'selected'; ?>>Red</option>
            <option value="green" <?php if ($backgroundColor === 'green') echo 'selected'; ?>>Green</option>
            <option value="blue" <?php if ($backgroundColor === 'blue') echo 'selected'; ?>>Blue</option>
        </select><br><br>

        <label for="font_size">Font Size:</label>
        <select name="font_size">
            <option value="">-- Select Font Size --</option>
            <option value="small" <?php if ($fontSize === 'small') echo 'selected'; ?>>Small</option>
            <option value="medium" <?php if ($fontSize === 'medium') echo 'selected'; ?>>Medium</option>
            <option value="large" <?php if ($fontSize === 'large') echo 'selected'; ?>>Large</option>
        </select><br><br>

        <label for="font_color">Font Color:</label>
        <select name="font_color">
            <option value="">-- Select Font Color --</option>
            <option value="black" <?php if ($fontColor === 'black') echo 'selected'; ?>>Black</option>
            <option value="white" <?php if ($fontColor === 'white') echo 'selected'; ?>>White</option>
            <option value="gray" <?php if ($fontColor === 'gray') echo 'selected'; ?>>Gray</option>
        </select><br><br>

        <label for="heading_color">Heading Color:</label>
        <select name="heading_color">
            <option value="">-- Select Heading Color --</option>
            <option value="orange" <?php if ($headingColor === 'orange') echo 'selected'; ?>>Orange</option>
            <option value="purple" <?php if ($headingColor === 'purple') echo 'selected'; ?>>Purple</option>
            <option value="pink" <?php if ($headingColor === 'pink') echo 'selected'; ?>>Pink</option>
        </select><br><br>
        <input type="submit" name="submit" value="Save">
    </form>

    <h2>Preview</h2>
    <div style="background-color: <?php echo $backgroundColor; ?>;
            font-size: <?php echo $fontSize; ?>;
            color: <?php echo $fontColor; ?>;">
    <h3 style="color: <?php echo $headingColor; ?>">Sample Heading</h3>
    <p>This is a sample paragraph.</p>
    </div>
</body>
</html>
