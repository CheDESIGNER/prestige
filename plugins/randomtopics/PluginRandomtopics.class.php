<?php
/*
  Random Topics
  s4people - 2013
  http://livestreet.ru/profile/s4people/
  http://wstandart.ru
*/

if (!class_exists ('Plugin')) {
  die ('Hacking attempt!');
}

class PluginRandomtopics extends Plugin {

    /**
     * Активация плагина
     */
    public function Activate() {
        return true;
    }

    /**
     * Инициализация плагина
     */
    public function Init() {
        $this->Viewer_AppendStyle(Plugin::GetTemplatePath('randomtopics')."css/randomtopics.css");
    }

}

?>