<?php
/*-------------------------------------------------------
*
*   LiveStreet Engine Social Networking
*   Copyright © 2008 Mzhelskiy Maxim
*
*--------------------------------------------------------
*
*   Official site: www.livestreet.ru
*   Contact e-mail: rus.engine@gmail.com
*
*   GNU General Public License, version 2:
*   http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*
---------------------------------------------------------
*/


class PluginMainpreview_ActionMain extends ActionPlugin {
	/**
	 * Инициализация
	 *
	 * @return null
	 */
	public function Init() {
		/**
		 * Если пользователь не авторизован и не админ, то выкидываем его
		 */
		$this->oUserCurrent=$this->User_GetUserCurrent();
		if (!$this->oUserCurrent or !$this->oUserCurrent->isAdministrator()) {
			return $this->EventNotFound();
		}
	}

	protected function RegisterEvent() {
		$this->AddEvent('convert','EventConvert');
		$this->AddEvent('reconvert','EventReConvert');
	}


	/**********************************************************************************
	 ************************ РЕАЛИЗАЦИЯ ЭКШЕНА ***************************************
	 **********************************************************************************
	 */

	/**
	 * Автоматическое создание превью для топиков
	 */
	protected function EventConvert() {
		if (isPost('submit_convert')) {
			$this->Security_ValidateSendForm();
			set_time_limit(0);

			$iPage=1;
			$iCount=0;
			while ($aTopics=$this->PluginMainpreview_Main_GetTopics($iPage,20)) {
				$iPage++;
				foreach($aTopics as $oTopic) {
					$this->PluginMainpreview_Main_SaveTopic($oTopic);
					$iCount++;
				}
			}
			$this->Message_AddNotice($this->Lang_Get('plugin.mainpreview.convert_end',array('count_topic'=>$iCount)));
		}
	}

	/**
	 * Переконвертация превью к новым размерам
	 */
	protected function EventReConvert() {
		if (isPost('submit_reconvert')) {
			$this->Security_ValidateSendForm();
			set_time_limit(0);

			$iPage=1;
			$iCount=0;
			while ($aTopics=$this->PluginMainpreview_Main_GetTopics($iPage,30,array())) {
				$iPage++;
				foreach($aTopics as $oTopic) {
					$this->PluginMainpreview_Main_ReMakePreview($oTopic);
					$iCount++;
				}
			}
			$this->Message_AddNotice($this->Lang_Get('plugin.mainpreview.reconvert_end',array('count_topic'=>$iCount)));
		}
	}
}
?>