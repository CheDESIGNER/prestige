<?php
/*-------------------------------------------------------
 *
 *   Copyright © 2011 kpoxas
 *
 *--------------------------------------------------------
 *
 *   Official site: www.tetra-studio.com.ua
 *   Contact e-mail: tetra@tetra-studio.com.ua
 *
 *   GNU General Public License, version 2:
 *   http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *
 ---------------------------------------------------------
 */

/**
 * Модуль топиков
 *
 */
class PluginViewcount_ModuleTopic extends PluginViewcount_Inherit_ModuleTopic {
	/**
	 * Увеличивает у топика число просмотров
	 *
	 * @param unknown_type $sTopicId
	 * @return unknown
	 */
	public function increaseTopicCountRead($sTopicId) {			
		return $this->oMapperTopic->increaseTopicCountRead($sTopicId);
	}
	
	public function GetTopicsAdditionalData($aTopicId,$aAllowData=null) {
		$args =  func_get_args();
		if (!$aTopics = call_user_func_array(array('parent',__FUNCTION__),$args)) {
			return;
		}
		/*
		 * Список id топиков
		 */
		$aTopicId = (array)$args[0];
		/*
		 * Получаем количество просмотров без кеширования
		 */
		$aCountRead = $this->oMapperTopic->GetTopicsCountReadByArrayId($aTopicId);
		/*
		 * Добавляем данные к результату - списку топиков
		 */
		foreach ($aTopics as &$oTopic) {
			if (isset($aCountRead[$oTopic->getId()])) {
				$oTopic->setCountRead($aCountRead[$oTopic->getId()]);
			}
		}
		return $aTopics;	
	}
	
	
}
?>