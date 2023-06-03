<?php
class SmartDate {
    private $date;

    public function __construct($date) {
        $this->date = new DateTime($date);
    }

    public function isWeekend() {
        $dayOfWeek = $this->date->format('N');
        return ($dayOfWeek == 6 || $dayOfWeek == 7);
    }

    public function getDistance($unit) {
        $today = new DateTime();
        $diff = $today->diff($this->date);

        switch ($unit) {
            case 'days':
                return $diff->days;
            case 'weeks':
                return floor($diff->days / 7);
            case 'months':
                return $diff->y * 12 + $diff->m;
            case 'years':
                return $diff->y;
            default:
                return null;
        }
    }

    public function isLeapYear() {
        $year = $this->date->format('Y');
        return (($year % 4 == 0) && ($year % 100 != 0)) || ($year % 400 == 0);
    }
}

$date = new SmartDate('2022-04-30');
echo json_encode($date->isWeekend()) . "\n";
echo $date->getDistance('days') . "\n"; 
echo $date->getDistance('weeks') . "\n"; 
echo $date->getDistance('months') . "\n"; 
echo $date->getDistance('years') . "\n"; 
echo json_encode($date->isLeapYear()) . "\n"; 

?>