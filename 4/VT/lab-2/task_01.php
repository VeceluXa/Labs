<?php
    if (isset($argc)) {
        for ($i = 1; $i < $argc; $i++) {
            if (filter_var($argv[$i], FILTER_VALIDATE_INT)!== false) {
                echo "Integer: " . $argv[$i] . "\n";
            } elseif (filter_var($argv[$i], FILTER_VALIDATE_FLOAT)!== false) {
                echo "Float: " . $argv[$i] . "\n";
            } else {
                echo "String: " . $argv[$i] . "\n";
            }
        }
    } else {
        echo "argc and argv disabled\n";
    }
?>
