<?php
/*
  ViewCount plugin
  (P) NS, 2012
  http://nfg.kz/
  http://realpeople.kz/
*/

if (!class_exists('Plugin')) {
	die('Hacking attemp!');
}

class PluginViewcount extends Plugin {

    protected $aInherits = array(
        'module' => array('ModuleTopic'),
        'mapper' => array('ModuleTopic_MapperTopic'),
    );

    public function Activate() {
        return true;
    }

    public function Init() {

    }
}

?>