<?php
    // Получаем HTML-документ из файла
    $html = file_get_contents('task_11_file.html');

    // Красим все заголовки в синий
    $html = preg_replace_callback(
        '/<h(\d)>(.*?)<\/h\1>/s',
        function ($matches) {
            return "<h{$matches[1]} style='color: blue;'>{$matches[2]}</h{$matches[1]}>";
        },
        $html
    );

    // Красим все наклонные фрагменты текста в зелёный
    $html = preg_replace_callback(
        '/<em>(.*?)<\/em>/s', 
        function ($matches) {
            return "<em style='color: green;'>{$matches[1]}</em>";
        },
        $html
    );

    // Красим все жирные фрагменты текста в красный
    $html = preg_replace_callback(
        '/<strong>(.*?)<\/strong>/s',
        function ($matches) {
            return "<strong style='color: red;'>{$matches[1]}</strong>";
        },
        $html
    );

    // Записываем результат в файл
    file_put_contents('task_11_result.html', $html);
?>