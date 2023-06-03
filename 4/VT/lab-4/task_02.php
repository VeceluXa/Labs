<?php
    require_once('task_01.php');
    class SafeFormBuilder extends FormBuilder {
        private $requestData;
    
        public function __construct($method, $action, $submitText, $requestData) {
            parent::__construct($method, $action, $submitText);
            $this->requestData = $requestData;
        }
    
        public function getForm() {
            $html = '<form method="' . $this->method . '" action="' . $this->action . '">' . "\n";
            foreach ($this->fields as $field) {
                $value = '';
                if (isset($this->requestData[$field['name']])) {
                    $value = $this->requestData[$field['name']];
                } elseif (isset($field['value'])) {
                    $value = $field['value'];
                }
    
                switch ($field['type']) {
                    case 'text':
                        $html .= '	<input type="text" name="' . $field['name'] . '" value="' . $value . '">' . "\n";
                        break;
                    case 'radio':
                        foreach ($field['options'] as $option) {
                            $checked = '';
                            if ($option == $value) {
                                $checked = 'checked';
                            }
                            $html .= '	<input type="radio" name="' . $field['name'] . '" value="' . $option . '" ' . $checked . '>' . "\n";
                        }
                        break;
                }
            }
            $html .= '	<button type="submit">' . $this->submitText . '</button>' . "\n" . '</form>';
            return $html;
        }
    }

    $safeFormBuilder = new SafeFormBuilder(FormBuilder::METHOD_POST, '/destination.php', 'Send!', $_POST);
    $safeFormBuilder->addTextField('someName', 'Default value');
    $safeFormBuilder->addRadioGroup('someRadioName', ['A', 'B']);
    $html = $safeFormBuilder->getForm();
    echo $html;
?>