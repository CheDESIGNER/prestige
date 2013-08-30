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


/**
 * Добавление новых полей в топик
 * Поля хранятся в специальном поле extra в виде сериализованного массива
 */
class PluginMainpreview_ModuleTopic_EntityTopic extends PluginMainpreview_Inherit_ModuleTopic_EntityTopic {

	public function getPreviewImage() {
		return $this->getExtraValue('preview_image');
	}

	public function getPreviewImageIsAuto() {
		return $this->getExtraValue('preview_image_is_auto');
	}

	public function getPreviewImageOriginalWidth() {
		return $this->getExtraValue('preview_image_original_width');
	}

	public function getPreviewImageOriginalHeight() {
		return $this->getExtraValue('preview_image_original_height');
	}

    public function getPreviewImageWidth() {
        return $this->getExtraValue('preview_image_width');
    }

    public function getPreviewImageHeight() {
        return $this->getExtraValue('preview_image_height');
    }

	public function setPreviewImage($data) {
		$this->setExtraValue('preview_image',$data);
	}

	public function setPreviewImageIsAuto($data) {
		$this->setExtraValue('preview_image_is_auto',$data);
	}

	public function setPreviewImageOriginalWidth($data) {
		$this->setExtraValue('preview_image_original_width',$data);
	}

	public function setPreviewImageOriginalHeight($data) {
		$this->setExtraValue('preview_image_original_height',$data);
	}

	public function getPreviewImageWebPath($sWidth=null) {
		if ($this->getPreviewImage()) {
			if ($sWidth) {
				$aPathInfo=pathinfo($this->getPreviewImage());
				return $aPathInfo['dirname'].'/'.$aPathInfo['filename'].'_'.$sWidth.'.'.$aPathInfo['extension'];
			} else {
				return $this->getPreviewImage();
			}
		} else {
			return null;
		}
	}

	/**
	 * Проверяет возможную доступность превью нужных размеров
	 * Проверка происходит не по наличию изображению, а только по теоретической возможности вырезать из оригинала изображение нужных размеров с учетом пропорции
	 *
	 * @param int $iW	Размер по ширине в пикселях
	 * @param int $iH	Размер по высоте в пикселях
	 * @return bool
	 */
	public function checkPreviewImageProportionSize($iW,$iH) {
		if (!$this->getPreviewImage()) {
			return false;
		}
		if ($this->getPreviewImageOriginalWidth()>=$iW and $this->getPreviewImageOriginalHeight()>=$iH) {
			return true;
		}
		return false;
	}
}
?>