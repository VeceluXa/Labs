<?php
// http://localhost:8000/task_01.php?cities=Minsk,Gomel,New%20York,Braslaw,Kiyv

// проверяем, был ли передан параметр cities в GET-запросе
if (!isset($_GET['cities'])) {
  echo "Параметр 'cities' не найден в GET-запросе";
  exit;
}

// получаем список городов из параметра cities
$cities = explode(',', $_GET['cities']);

// проходим по всему списку городов и проверяем каждый элемент
foreach ($cities as $city) {
  // удаляем лишние пробелы в начале и конце строки
  $city = trim($city);

  // проверяем, что значение является не пустой строкой и состоит только из букв и пробелов
  if (!preg_match('/^[a-zA-Z\s]+$/', $city)) {
    echo "Неверный формат города: $city";
    exit;
  }
}

// удаляем дубликаты из списка городов
$cities = array_unique($cities);

// сортируем список городов по алфавиту
sort($cities);

// выводим итоговый список городов
echo implode(', ', $cities);
?>
