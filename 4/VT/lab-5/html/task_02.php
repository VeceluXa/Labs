<?php
    define('DB_HOST', '172.20.0.4');
    define('DB_PORT', '3306');
    define('DB_USER', 'user');
    define('DB_PASSWORD', 'password');
    define('DB_NAME', 'task_database');
    define('DB_CHARSET', 'utf8mb4_general_ci');

    // Подключение к БД
    $conn = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT);
    if (!$conn) {
        die('Ошибка подключения к БД: ' . mysqli_connect_error());
    }

    // Установка кодировки UTF8
    mysqli_set_charset($conn, "utf8");

    // Получение данных из БД
    $sql = "SELECT * FROM authors ORDER BY id ASC";
    $result = mysqli_query($conn, $sql);

    // Вывод данных в табличном виде
    echo '<table>';
    echo '<tr><th>ID</th><th>Название</th><th>Действия</th></tr>';
    while ($row = mysqli_fetch_assoc($result)) {
        echo '<tr>';
        echo '<td>' . $row['id'] . '</td>';
        echo '<td>' . $row['name'] . '</td>';
        echo '<td>';
        echo '<form action="" method="POST" style="display: inline-block;">';
        echo '<input type="hidden" name="id" value="' . $row['id'] . '">';
        echo '<button type="submit" name="delete_author">Удалить</button>';
        echo '</form>';
        echo '</td>';
        echo '</tr>';
    }
    echo '</table>';


    // Объединение данных из двух таблиц
    $sql = "SELECT articles.title, authors.name FROM articles INNER JOIN authors ON articles.author_id = authors.id";
    $result = mysqli_query($conn, $sql);
    echo '<table>';
    echo '<tr><th>Заголовок книги</th><th>Автор</th></tr>';
    while ($row = mysqli_fetch_assoc($result)) {
        echo '<tr>';
        echo '<td>' . $row['title'] . '</td>';
        echo '<td>' . $row['name'] . '</td>';
        echo '</tr>';
    }
    echo '</table>';

    echo '<h2>Добавление нового автора</h2>';
    echo '<form action="" method="POST">';
    echo '<label for="name">Имя:</label>';
    echo '<input type="text" id="name" name="name" required>';
    echo '<button type="submit" name="add_author">Добавить</button>';
    echo '</form>';

    if (isset($_POST['add_author'])) {
        $name = mysqli_real_escape_string($conn, $_POST['name']);
        $sql = "INSERT INTO authors (name) VALUES ('$name')";
        if (mysqli_query($conn, $sql)) {
            echo '<p>Автор добавлен</p>';
        } else {
            echo '<p>Ошибка: ' . mysqli_error($conn) . '</p>';
        }
    }

    if (isset($_POST['delete_author'])) {
        $id = mysqli_real_escape_string($conn, $_POST['id']);
        $sql = "DELETE FROM authors WHERE id = $id";
        if (!mysqli_query($conn, $sql)) {
            echo '<p>Ошибка: ' . mysqli_error($conn) . '</p>';
        }
    }

    echo '<h2>Изменение автора</h2>';
    echo '<form action="" method="POST">';
    echo '<label for="id">Id:</label>';
    echo '<input type="text" id="id" name="id" required>';
    echo '<label for="name">Name:</label>';
    echo '<input type="text" id="name" name="name" required>';
    echo '<button type="submit" name="edit_author">Изменить</button>';
    echo '</form>';

    if (isset($_POST['edit_author'])) {
        $id = $_POST['id'];
        $name = $_POST['name'];
        $sql = "UPDATE authors SET name = '$name' WHERE id = $id";
        if (mysqli_query($conn, $sql)) {
            
        }
    }



    // Закрытие соединения
    mysqli_close($conn);

?>