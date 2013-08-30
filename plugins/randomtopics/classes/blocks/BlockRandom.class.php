<?php
/*
  Random Topics
  s4people - 2013
  http://livestreet.ru/profile/s4people/
  http://wstandart.ru
*/


class PluginRandomtopics_BlockRandom extends Block {

	public function Exec () {
        // Задаем фильтр топиков
        $aFilter=array(
            'topic_publish' => 1,
            //'blog_id' => $oBlog->getId(),
        );

        // Получаем количество топиков по заданному фильтру
        $cnt=$this->Topic_GetCountTopicsByFilter($aFilter);

        $aTopics=array();

        if ($cnt>0) {
            // Нужное кол-во топиков берем из конфига
            $needed = Config::Get ('plugin.randomtopics.Topics_Count');

            if ($needed>$cnt) {
                $needed=$cnt;
            }

            $selected=0;

            do {
                // получаем случайный топик
                if ($aResult=$this->Topic_GetTopicsByFilter($aFilter,rand(1,$cnt),1)) {

                    // убеждаемся, что мы его еще не включили в свой список
                    $oTopic=array_pop($aResult['collection']);
                    $tid=$oTopic->getId();

                    if (!isset($aTopics[$tid])) {
                        // включаем в список
                        $aTopics[$tid]=$oTopic;
                        $selected++;
                    }
                }
            } while ($selected<$needed);
     }

        // Выводим в шаблоны
        $this -> Viewer_Assign ('aRandomTopics', $aTopics);
        $this -> Viewer_Assign ('sTemplatePluginPath', Plugin::GetTemplatePath (__CLASS__));
	}
	
}

?>