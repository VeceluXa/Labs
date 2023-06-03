<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task 2</title>
    <style>
        .menu-container {
            display: flex;
            gap: 10px;
        }

        .menu-container a {
            text-decoration: none;
            color: black;
        }

        .menu-container .active a {
            text-decoration: none;
            color: purple;
        }

        .form-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin: 20px 10px 20px 10px;
        }
    </style>
</head>
<body>

    <header>

    </header>
    <main>
        <div class='menu-container'>
            <?php
                $menu_items = array(
                    "О компании",
                    "Услуги",
                    "Прайс",
                    "Контакты"
                );
                if (!isset($_GET['active'])) {
                    $_GET['active'] = 0;
                }
                for ($i = 0; $i < count($menu_items); $i++) {
                    if ($i == $_GET['active']) {
                        echo '<span class="active">';
                    }
                    echo '<a href="?active='.$i.'">'.$menu_items[$i].'</a>';
                    if ($i == $_GET['active']) {
                        echo '</span>';
                    }
                }
            ?>
        </div>
        <!-- TODO Add menu toolbar -->
        <div class='form-container'>
            <h2>Number of rows</h2>
            <form 
                action="" 
                method="get"
                style="
                    display: flex;
                    flex-direction: column;
                    gap: 10px;
                "    
            >
                <input type="number" min="10" max="318" name="rows">
                <input type="submit">
            </form>
        </div>
        
        <?php
            $rows = $_GET["rows"];

            // Check if data is invalid
            if (!is_numeric($rows) || $rows < 10 || $rows > 318) {
                return;
            }

            // Convert to int
            $rows = (int)$rows;
            
            // Number of green rows
            $count_green = (int) floor($rows / 5);
            
            // Color divisor
            $color_div = (int)floor((255 / ($rows - $count_green)));

            $color = 0;
            echo '<table style=\'width:100%; height:auto\'>';
            for ($i = 1; $i <= $rows; $i++) {
                if ($i % 5 == 0) { // Green row
                    echo '<tr><td style=\'height:20px; width=100%; background-color:green\'></td></tr>';
                } else { // Grey row
                    echo '<tr><td style=\'height:20px; width=100%; background-color: ' . dec2color($color) . '\'></td></tr>';
                    $color = $color + $color_div; //*16**0 + $color_div*16**1;
                }
            }
            echo "</table>";

            // Convert single decimal (0-255) to hex grey color
            function dec2color($dec) {
                $color = "#";

                if ($dec >= 16) {
                    $color = $color . dechex($dec) . dechex($dec) . dechex($dec);
                } else {
                    $color = $color . "0" . dechex($dec) . "0" . dechex($dec) . "0" . dechex($dec);
                }

                return $color;
            }
        ?>
    </main>
</body>
</html>

