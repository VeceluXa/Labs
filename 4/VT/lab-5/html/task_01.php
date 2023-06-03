<?php
    class AgeCalculator {
        private $dob;
    
        public function __construct($dob) {
            $this->dob = new DateTime($dob);
        }
    
        public function calculateAge() {
            $now = new DateTime();
            $diff = $this->dob->diff($now);
            return $diff->format('%y лет %m месяцев %d дней');
        }
    }

    $ageCalculator = new AgeCalculator('2004-01-25');
    echo $ageCalculator->calculateAge();
?>