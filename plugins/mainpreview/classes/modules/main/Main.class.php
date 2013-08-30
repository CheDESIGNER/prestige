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

class PluginMainpreview_ModuleMain extends Module {
	protected $oMapper;

	public function Init() {
		$this->oMapper=Engine::GetMapper(__CLASS__);
	}


	/**
	 * Возвращает список топиков
	 *
	 * @param int $iCurrPage
	 * @param int $iPerPage
	 *
	 * @return array
	 */
	public function GetTopics($iCurrPage,$iPerPage,$aAllowData=null) {
		return $this->Topic_GetTopicsAdditionalData($this->oMapper->GetTopics($iCount,$iCurrPage,$iPerPage),$aAllowData);
	}

	/**
	 * Анализирует текст топика на наличие источников превью
	 *
	 * @param $oTopic
	 */
	public function AnalysisTopic($oTopic) {
		$aImages=array();
		/**
		 * Анализируем текст на наличие видео
		 */
		if (Config::Get('plugin.mainpreview.make_preview_video')) {
			$sImage=$this->AnalysisTopicYoutube($oTopic);
			if (!$sImage) {
				$sImage=$this->AnalysisTopicVimeo($oTopic);
			}
			if (!$sImage) {
				$sImage=$this->AnalysisTopicRutube($oTopic);
			}
			if ($sImage) {
				$aImages[]=$sImage;
			}
		}
		/**
		 * Анализ текста на наличие изображений
		 * Анализируем только если не нашли превью до этого в видео
		 */
		if (Config::Get('plugin.mainpreview.make_preview_image') and !count($aImages)) {
			$aImages=$this->AnalysisTopicImages($oTopic);
		}

		if (count($aImages)) {
			foreach($aImages as $sImage) {
				if (!is_null($sImage)) {
					/**
					 * Удаляем старую превьюшку на основе анализа текста топика
					 */
					if ($oTopic->getPreviewImage()) {
						$this->DeleteTopic($oTopic);
					}
					/**
					 * Проверяем размер изображения, если он меньше минимальных, то пропускаем это изображение
					 */
					if (@$aSize=getimagesize($sImage)) {
						if ($aSize[0]<Config::Get('plugin.mainpreview.preview_minimal_size_width') or $aSize[1]<Config::Get('plugin.mainpreview.preview_minimal_size_height')) {
							break;
						}
					}
					/**
					 * Загружаем превью
					 */
					if ($sImagePath=$this->UploadImageByUrl($oTopic,$sImage)) {
						$oTopic->setPreviewImage($sImagePath);
						$oTopic->setPreviewImageIsAuto(true);
						/**
						 * Завершаем перебор изображений
						 */
						break;
					}
				}
			}
		}
	}

	/**
	 * Чтение данных из XML файла
	 *
	 * @param $sFile
	 * @param $sPath
	 * @return null|string
	 */
	public function GetDataFromXml($sFile,$sPath) {
		if($oXml = @simplexml_load_file($sFile)) {
			$data=$oXml->xpath($sPath);
			return trim((string)array_shift($data));
		}
		return null;
	}

	/**
	 * Поиск видео с YouTube
	 *
	 * @param $oTopic
	 * @return null|string
	 */
	public function AnalysisTopicYoutube($oTopic) {
		$sImage=null;
		if (preg_match('#<\s*param[^>]+value\s*=\s*"https?://(?:www\.|)youtube\.com/v/([a-zA-Z0-9_\-]+)[^"]*"#i',$oTopic->getText(),$aMatch)) {
			$sImage="http://i3.ytimg.com/vi/{$aMatch[1]}/hqdefault.jpg";
		} elseif (preg_match('#<\s*iframe[^>]+src\s*=\s*"https?://(?:www\.|)youtube\.com/embed/([a-zA-Z0-9_\-]+)[^"]*"#i',$oTopic->getText(),$aMatch)) {
			$sImage="http://i3.ytimg.com/vi/{$aMatch[1]}/hqdefault.jpg";
		}
		return $sImage;
	}

	/**
	 * Поиск видео с Vimeo
	 *
	 * @param $oTopic
	 * @return null|string
	 */
	public function AnalysisTopicVimeo($oTopic) {
		$sImage=null;
		if (preg_match('#<\s*iframe[^>]+src\s*=\s*"https?://player\.vimeo\.com/video/([0-9]+)[^"]*"#i',$oTopic->getText(),$aMatch)) {
			$sXmlFile="http://vimeo.com/api/v2/video/{$aMatch[1]}.xml";
			if ($sImage=$this->GetDataFromXml($sXmlFile,"video/thumbnail_large")) {
				return $sImage;
			}
		}
		return $sImage;
	}

	/**
	 * Поиск видео с RuTube
	 *
	 * @param $oTopic
	 * @return null|string
	 */
	public function AnalysisTopicRutube($oTopic) {
		$sImage=null;
		if (preg_match('#<\s*param[^>]+value\s*=\s*"https?://video\.rutube\.ru/([a-zA-Z0-9_\-]+)[^"]*"#i',$oTopic->getText(),$aMatch)) {
			$sImage="http://tub.rutube.ru/thumbs/".preg_replace("#((.{2})(.{2}))#U","\\2/\\3/\\1",$aMatch[1],1)."-1.jpg";
		} elseif (preg_match('#<\s*embed[^>]+src\s*=\s*"https?://video\.rutube\.ru/([a-zA-Z0-9_\-]+)[^"]*"#i',$oTopic->getText(),$aMatch)) {
			$sImage="http://tub.rutube.ru/thumbs/".preg_replace("#((.{2})(.{2}))#U","\\2/\\3/\\1",$aMatch[1],1)."-1.jpg";
		}
		return $sImage;
	}

	/**
	 * Поиск изображений в тексте топика
	 *
	 * @param $oTopic
	 * @return array
	 */
	public function AnalysisTopicImages($oTopic) {
		$aImages=array();
		if (preg_match_all('#<\s*img[^>]+src\s*=\s*"(https?://[^"]*)"#i',$oTopic->getText(),$aMatch)) {
			$aImages=$aMatch[1];
		}
		return $aImages;
	}

	/**
	 * Обработка загружки превью через форму (с компьютера)
	 *
	 * @param $oTopic
	 * @param $aFile
	 *
	 * @return string | bool
	 */
	public function UploadImageBySubmit($oTopic,$aFile) {
		if(!is_array($aFile) || !isset($aFile['tmp_name'])) {
			return false;
		}

		/**
		 * Сохраняем во временный файл
		 */
		$sFileTmp=Config::Get('sys.cache.dir').func_generator();
		if (!move_uploaded_file($aFile['tmp_name'],$sFileTmp)) {
			return false;
		}

		return $this->UploadImage($oTopic,$sFileTmp);
	}

	/**
	 * Обработка загрузки превью по внешнему URL (с интернета)
	 *
	 * @param $oTopic
	 * @param $sUrl
	 *
	 * @return string | bool
	 */
	public function UploadImageByUrl($oTopic,$sUrl) {
		/**
		 * Проверяем, является ли файл изображением
		 */
		if(!@getimagesize($sUrl)) {
			return false;
		}
		/**
		 * Открываем файловый поток и считываем файл поблочно,
		 * контролируя максимальный размер изображения
		 */
		$oFile=@fopen($sUrl,'r');
		if(!$oFile) {
			return false;
		}

		$iMaxSizeKb=500;
		$iSizeKb=0;
		$sContent='';
		while (!feof($oFile) and $iSizeKb<$iMaxSizeKb) {
			$sContent.=fread($oFile ,1024*1);
			$iSizeKb++;
		}

		/**
		 * Если конец файла не достигнут,
		 * значит файл имеет недопустимый размер
		 */
		if(!feof($oFile)) {
			return false;
		}
		fclose($oFile);

		/**
		 * Сохраняем во временный файл
		 */
		$sFileTmp=Config::Get('sys.cache.dir').func_generator();
		$fp=fopen($sFileTmp,'w');
		fwrite($fp,$sContent);
		fclose($fp);

		return $this->UploadImage($oTopic,$sFileTmp);
	}

	/**
	 * Обработка загрузки превью
	 *
	 * @param $oTopic
	 * @param $sFileTmp
	 *
	 * @return string | bool
	 */
	public function UploadImage($oTopic,$sFileTmp) {
		/**
		 * Новые размеры
		 */
		$aSizes=Config::Get('plugin.mainpreview.size_images_preview');
		/**
		 * Если в конфиге нет размеров для генерации, то завершаем работу
		 */
		if (!count($aSizes)) {
			@unlink($sFileTmp);
			return false;
		}
		$oImage = $this->Image_CreateImageObject($sFileTmp);
		$aImageSize=$oImage->get_image_params();
		$aParams=$this->Image_BuildParams('topic');
		/**
		 * Если объект изображения не создан,
		 * возвращаем ошибку
		 */
		if($sError=$oImage->get_last_error()) {
			@unlink($sFileTmp);
			return false;
		}

		/**
		 * Генерируем имя файла и каталога для превью
		 */
		$sFileName=func_generator();
		$sDirSave = Config::Get('path.uploads.root').'/topics/preview/'.preg_replace('~(.{2})~U', "\\1/", str_pad($oTopic->getId(), 8, "0", STR_PAD_LEFT));
		$sDirSave=rtrim($sDirSave,'/');

		$bError=false;
		foreach ($aSizes as $aSize) {
			// Для каждого указанного в конфиге размера генерируем картинку
			$sNewFileName = $sFileName.'_'.$aSize['w'];
			$oImage = $this->Image_CreateImageObject($sFileTmp);
			if ($aSize['crop']) {
				$this->Image_CropProportion($oImage, $aSize['w'], $aSize['h'], true);
				$sNewFileName .= 'crop';
			}

			if (!$this->Image_Resize($sFileTmp,$sDirSave,$sNewFileName,Config::Get('view.img_max_width'),Config::Get('view.img_max_height'),$aSize['w'],$aSize['h'],true,$aParams,$oImage)) {
				$bError=true;
			}
		}
		/**
		 * Сохраняем оригинальный файл
		 */
		if (!($sFile=$this->Image_SaveFile($sFileTmp,$sDirSave,$sFileName.'.'.$oImage->get_image_params('format'),0755,true))) {
			$bError=true;
		}
		if ($bError) {
			@unlink($sFileTmp);
			return false;
		}
		$oTopic->setPreviewImageOriginalWidth($aImageSize['width']);
		$oTopic->setPreviewImageOriginalHeight($aImageSize['height']);
		return $this->Image_GetWebPath($sFile);
	}

	/**
	 * Удаление превью у топика
	 *
	 * @param $oTopic
	 */
	public function DeleteTopic($oTopic) {
		$this->Image_RemoveFile($this->Image_GetServerPath($oTopic->getPreviewImage()));
		$aSizes=Config::Get('plugin.mainpreview.size_images_preview');
		// Удаляем все сгенерированные миниатюры основываясь на данных из конфига.
		foreach ($aSizes as $aSize) {
			$sSize = $aSize['w'];
			if ($aSize['crop']) {
				$sSize .= 'crop';
			}
			$this->Image_RemoveFile($this->Image_GetServerPath($oTopic->getPreviewImageWebPath($sSize)));
		}
		$oTopic->setPreviewImage(null);
		$oTopic->setPreviewImageOriginalWidth(null);
		$oTopic->setPreviewImageOriginalHeight(null);
		$oTopic->setPreviewImageIsAuto(false);
	}

	/**
	 * Сохраняет топик - обработка превью
	 *
	 * @param $oTopic
	 */
	public function SaveTopic($oTopic) {
		/**
		 * По умолчанию анализируем текст топика топик
		 */
		$bAnalysisTopic=true;
		/**
		 * Удаление превью
		 */
		if (isset($_REQUEST['topic_preview_image_delete'])) {
			if ($oTopic->getPreviewImageIsAuto()) {
				// После удаление не нужно создавать автоматически новое превью
				$bAnalysisTopic=false;
			}
			$this->DeleteTopic($oTopic);
		}

		/**
		 * Загрузка пользовательского превью
		 */
		if (isset($_FILES['topic_preview_image']) and is_uploaded_file($_FILES['topic_preview_image']['tmp_name'])) {
			$bAnalysisTopic=false;
			$this->DeleteTopic($oTopic);
			if ($sImagePath=$this->UploadImageBySubmit($oTopic,$_FILES['topic_preview_image'])) {
				$oTopic->setPreviewImage($sImagePath);
				$oTopic->setPreviewImageIsAuto(false);
			}
		}

		if ($bAnalysisTopic) {
			/**
			 * Анализируем текст только если нет превью, либо оно автоматическое
			 */
			if (!$oTopic->getPreviewImage() or $oTopic->getPreviewImageIsAuto()) {
				$bPreviewReady=false;
				/**
				 * Обработка фото-сета
				 */
				if ($oTopic->getType()=='photoset') {
					$oMainPhoto=$oTopic->getPhotosetMainPhoto();
					$sPath=$this->Image_GetServerPath($oMainPhoto->getWebPath(1000));
					$sFileTmp=Config::Get('sys.cache.dir').func_generator();
					if ($this->Image_CopyFileToLocal($sPath,$sFileTmp)) {
						if ($oTopic->getPreviewImage()) {
							$this->DeleteTopic($oTopic);
						}
						if ($sImagePath=$this->UploadImage($oTopic,$sFileTmp)) {
							$oTopic->setPreviewImage($sImagePath);
							$oTopic->setPreviewImageIsAuto(true);
							$bPreviewReady=true;
						}
					}

				}

				/**
				 * Анализ текста топика
				 */
				if (!$bPreviewReady) {
					$this->AnalysisTopic($oTopic);
				}
			}
		}

		// из-за бага в движке необходимо изменить поле в основной таблице топика, чтобы произошел апдейт таблицы контента
		$oTopic->setTextHash(md5($oTopic->getTextSource().'extra'.$oTopic->getExtra()));
		// Сохраняем данные
		$this->Topic_UpdateTopic($oTopic);
	}

	/**
	 * Переконвертация превью топика из оригинала к новым размерам
	 *
	 * @param $oTopic
	 */
	public function ReMakePreview($oTopic) {
		if (!($sOriginal=$oTopic->getPreviewImage())) {
			return false;
		}
		$sOriginal=$this->Image_GetServerPath($sOriginal);
		$aPath=pathinfo($sOriginal);
		$aFiles = glob($aPath['dirname']."/*_*.".$aPath['extension']);
		/**
		 * Удаляем старые превью
		 */
		if($aFiles) {
			foreach($aFiles as $sFile){
				$this->Image_RemoveFile($sFile);
			}
		}
		/**
		 * Создаем новые превью
		 */
		if (file_exists($sOriginal) and $sImagePath=$this->UploadImage($oTopic,$sOriginal)) {
			$oTopic->setPreviewImage($sImagePath);
		} else {
			$oTopic->setPreviewImage(null);
			$oTopic->setPreviewImageOriginalWidth(null);
			$oTopic->setPreviewImageOriginalHeight(null);
			$oTopic->setPreviewImageIsAuto(false);
		}

		// из-за бага в движке необходимо изменить поле в основной таблице топика, чтобы произошел апдейт таблицы контента
		$oTopic->setTextHash(md5($oTopic->getTextSource().'extra'.$oTopic->getExtra()));
		// Сохраняем данные
		$this->Topic_UpdateTopic($oTopic);
	}
}
?>