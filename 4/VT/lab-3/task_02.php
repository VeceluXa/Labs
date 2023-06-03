<?php
$year = $_POST['year'];
if (!isset($year)) 
    return;

$months = array('September', 'October', 'November', 'December', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August');
$dayInMonths = array(30, 31, 30, 31, 31, 28, 31, 30, 31, 30, 31, 31);
$day_of_week = jddayofweek(cal_to_jd(CAL_GREGORIAN, '09', '01', $year), 0);
if ($year % 4 == 0)
    $dayInMonths[5]++;

$currWeek = 1;
$currDay = 1;
$buf = 1;
$i = 0;
$fd = fopen("calendar.html", 'w');
fwrite($fd, "<html>\n");
fwrite($fd, "<head>\n");
fwrite($fd, "<title>Календарь учебного года</title>\n");
fwrite($fd, "</head>\n");
fwrite($fd, "<body>\n");
fwrite($fd, "<h1>Календарь учебного $year года</h1>\n");
for ($i = 0; $i < 12; $i++) {
    echo "$months[$i]";
    $fd = fopen("calendar.html", 'a');
    fwrite($fd, "<p>{$months[$i]}</p>");
    fwrite($fd, "\n");
    fclose($fd);
    printMonth($i);
    // printFirstWeek($i, $fd);
}
$fd = fopen("calendar.html", 'a');
fwrite($fd, "</body>\n");
fwrite($fd, "</html>\n");
fclose($fd);



function printMonth($mon)
// function printFirstWeek($mon, $fd)
{
    global $currWeek, $day_of_week, $currDay, $dayInMonths;
    $fd = fopen("calendar.html", 'a');
    echo "<table border='3'>";
    fwrite($fd, "<table border='3'>");
    fwrite($fd, "\n");
    echo "<tr>";
    fwrite($fd, "<tr>");
    fwrite($fd, "\n");
    echo "<td>" . "Week", $currWeek, ":" . "</td>";
    fwrite($fd, "<td>  Week {$currWeek} :  </td>");
    fwrite($fd, "\n");
    //$currDay=33-$day_of_week;
    for ($i = 1; $i < $day_of_week; $i++) {
        echo "<td>" . "</td>";
        fwrite($fd, "<td></td>");
        fwrite($fd, "\n");
    }

    $currDay = 1;

    for ($i = $day_of_week; $i < 8; $i++) {
        if ((($mon == 3 && $currDay > 28) || ($mon == 4 && $currDay < 26)) || ($mon == 9 && $currDay < 29)) {
            echo '<td style="color:red">' . "<b>" . $currDay . "</b>" . '</td>';
            fwrite($fd, "<td style='color:red'> <b>  {$currDay}  </b>  </td>");
            fwrite($fd, "\n");
        } else if ((($mon == 4 && $currDay > 25) || ($mon == 5 && $currDay < 9)) || ($mon == 9 && $currDay > 28) || ($mon > 9)) {
            echo '<td style="color:green">' . "<b>" . $currDay . "</b>" . '</td>';
            fwrite($fd, "<td style='color:green'> <b>  {$currDay}  </b>  </td>");
            fwrite($fd, "\n");
        } else {
            echo "<td>" . $currDay . "</td>";
            fwrite($fd, "<td>  {$currDay} </td>");
            fwrite($fd, "\n");
        }
        $currDay++;
        $day_of_week = ($day_of_week + 1) % 7;

    }
    echo "</tr>";
    fwrite($fd, "</tr>");
    fwrite($fd, "\n");

    #echo $dayInMonths[$i];
    while (true) {
        $i++;
        $currWeek = ($currWeek % 4) + 1;
        echo "<tr>";
        fwrite($fd, "<tr>");
        fwrite($fd, "\n");
        echo "<td>" . "Week", $currWeek, ":" . "</td>";
        fwrite($fd, "<td>  Week {$currWeek} :  </td>");
        fwrite($fd, "\n");
        for ($j = 0; $j < 7; $j++) {
            if ((($mon == 3 && $currDay > 28) || ($mon == 4 && $currDay < 26)) || ($mon == 9 && $currDay < 29)) {
                echo '<td style="color:red">' . "<b>" . $currDay . "</b>" . '</td>';
                fwrite($fd, "<td style='color:red'> <b>  {$currDay}  </b>  </td>");
                fwrite($fd, "\n");
            } else if ((($mon == 4 && $currDay > 25) || ($mon == 5 && $currDay < 9)) || ($mon == 9 && $currDay > 28) || ($mon > 9)) {
                echo '<td style="color:green">' . "<b>" . $currDay . "</b>" . '</td>';
                fwrite($fd, "<td style='color:green'> <b>  {$currDay}  </b>  </td>");
                fwrite($fd, "\n");
            } else {
                echo "<td>" . $currDay . "</td>";
                fwrite($fd, "<td>  {$currDay} </td>");
                fwrite($fd, "\n");
            }
            $currDay++;
            $day_of_week = ($day_of_week % 7) + 1;
            if ($currDay > $dayInMonths[$mon])
                break;
        }
        $buf = $day_of_week;
        if ($currDay > $dayInMonths[$mon]) {
            while ($buf < 8 && $buf != 1) {
                echo "<td>" . "</td>";
                fwrite($fd, "<td></td>");
                fwrite($fd, "\n");
                $buf++;
            }
            break;
        }
        echo "</tr>";
        fwrite($fd, "</tr>");
        fwrite($fd, "\n");
    }
    echo "</table>";
    fwrite($fd, "</table>");
    fwrite($fd, "\n");
    fclose($fd);

}

?>