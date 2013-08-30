<?php

/**
 * Регистрация хука для вывода кол-ва просмотров топика
 */
class PluginViewcount_HookViewCount extends Hook {
	/**
	 * Регистрируем хуки
	 */
	public function RegisterHook() {
		$this->AddHook('init_action', 'InitAction', __CLASS__);
		$this->AddHook('topic_show','TopicShow');
		$this->AddHook('template_topic_show_info','topic_show_info');
	}
	
	public function InitAction() {
		$this ->Viewer_AppendStyle (Plugin::GetTemplateWebPath (__CLASS__) . 'css/viewcount.css');
	}	 

	public function TopicShow($aParams) {
		$oTopic=$aParams['oTopic'];
		$oUser=$this->User_GetUserCurrent();
		
		if (Config::Get("plugin.viewcount.NoRefreshTopic") == true) {
			if (isset($_COOKIE['viewcount_cur_topic']) && $oTopic->getId() == $_COOKIE['viewcount_cur_topic']) {
				setcookie('viewcount_cur_topic', $oTopic->getId());
				return false;	
			}
			else{
				setcookie('viewcount_cur_topic', $oTopic->getId());
			}
		}

        // Проверяем авторизован ли юзер
		$is_auth = $this->User_IsAuthorization();
		if ($is_auth) $no_cur = $oUser->getId()!=$oTopic->getUserId(); 
		else $no_cur = true;
		
		// Проверяем авторизован ли юзер и является ли автором топика
		if (Config::Get("plugin.viewcount.OnlyAuthUser") && $is_auth && $no_cur) {}
		else if (!Config::Get("plugin.viewcount.OnlyAuthUser") && $no_cur) {}
		else return;
		
        // обновляем статистику
        $this->Topic_increaseTopicCountRead($oTopic->getId());
        // учесть в текущей выдаче
        $oTopic->setCountRead($oTopic->getCountRead()+1);
    }
	
	function topic_show_info($aParams)
	{
		$oTopic=$aParams['topic'];
		$this->Viewer_Assign('oTopic',$oTopic);	
		return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject_topic_show_info.tpl');		
	}
}
?>