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

class PluginMainpreview_HookMain extends Hook {

	public function RegisterHook() {
		$this->AddHook('template_admin_action_item','InjectAdmin');

		$this->AddHook('template_form_add_topic_topic_end', 'AddTopicPreviewForm', __CLASS__);
		$this->AddHook('template_form_add_topic_link_end', 'AddTopicPreviewForm', __CLASS__);
		$this->AddHook('template_form_add_topic_question_end', 'AddTopicPreviewForm', __CLASS__);
		$this->AddHook('template_form_add_topic_photoset_end', 'AddTopicPreviewForm', __CLASS__);

		$this->AddHook('topic_add_after','SaveTopic');
		$this->AddHook('topic_edit_after','SaveTopic');
		$this->AddHook('topic_edit_show', 'TopicEdit', __CLASS__);
	}

	/**
	 * Обработка превью после сохранения топика
	 */
	public function SaveTopic($aParams) {
		$oTopic=$aParams['oTopic'];
		/**
		 * Получаем топик, чтоб подцепить связанные данные
		 */
		$oTopic=$this->Topic_GetTopicById($oTopic->getId());
		$aParams['oTopic']=$oTopic;

		$this->PluginMainpreview_Main_SaveTopic($oTopic);
	}

	/**
	 * Добавляем в стандартную админку ссылку на конвертер фото-сетов
	 */
	public function InjectAdmin() {
		return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject.admin.menu.tpl');
	}

	/**
	 * Добавляем форму загружки/удаления превью на страницу редактирования топика
	 */
	public function AddTopicPreviewForm() {
		/**
		 * Определяем размер для отображения в форме редактирования - берем первый из списка
		 */
		$aSize=Config::Get('plugin.mainpreview.size_images_preview');
		if (isset($aSize[0])) {
			$sPreviewDefaultName=$aSize[0]['w'].($aSize[0]['crop'] ? 'crop' : '');
			$this->Viewer_Assign('sPreviewDefaultName',$sPreviewDefaultName);
		}
		return $this->Viewer_Fetch(Plugin::GetTemplatePath(__CLASS__).'inject.topic.form.tpl');
	}

	/**
	 * Прогружаем редактируемый топик в шаблон
	 */
	public function TopicEdit($aVars) {
		$oTopic=$aVars['oTopic'];
		$this->Viewer_Assign('oTopicEdit',$oTopic);
	}
}
?>