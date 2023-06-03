<?php

class FormBuilder {
	const METHOD_POST = 'POST';
	const METHOD_GET = 'GET';
  
	protected $method;
	protected $action;
	protected $submitText;
	protected $fields;
  
	public function __construct($method, $action, $submitText) {
	  	$this->method = $method;
	  	$this->action = $action;
	  	$this->submitText = $submitText;
	  	$this->fields = array();
	}
  
	public function addTextField($name, $value = '') {
	  	$this->fields[] = array(
			'type' => 'text',
			'name' => $name,
			'value' => $value
	  	);
	}
  
	public function addRadioGroup($name, $options = array()) {
	  	$this->fields[] = array(
			'type' => 'radio',
			'name' => $name,
			'options' => $options
	  	);
	}
  
	public function getForm() {
	  	$html = '<form method="' . $this->method . '" action="' . $this->action . '">' . "\n";
	  	foreach ($this->fields as $field) {
			switch ($field['type']) {
			  case 'text':
				$html .= '	<input type="text" name="' . $field['name'] . '" value="' . $field['value'] . '">' . "\n";
				break;
			  case 'radio':
				foreach ($field['options'] as $option) {
				  $html .= '	<input type="radio" name="' . $field['name'] . '" value="' . $option . '">' . "\n";
				}
				break;
			}
	  	}
	  	$html .= '	<button type="submit">' . $this->submitText . '</button>' . "\n" . '</form>';
	  	return $html;
	}
}

$formBuilder = new FormBuilder(FormBuilder::METHOD_POST, '/task_02.php', 'Send!');
$formBuilder->addTextField('someName', 'Default value');
$formBuilder->addRadioGroup('someRadioName', ['A', 'B']);
$html = $formBuilder->getForm();

file_put_contents('task_01.html', $html);
?>