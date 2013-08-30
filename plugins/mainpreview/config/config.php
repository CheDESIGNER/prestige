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
 * Адрес конвертера превью
 */
Config::Set('router.page.mainpreview', 'PluginMainpreview_ActionMain');

/**
 * Настройки
 */
$config['make_preview_video']   = true;  // Создавать или нет автоматические превью топика на основе вставленного в текст видео
$config['make_preview_image']   = true;  // Создавать или нет автоматические превью топика на основе вставленного в текст изображения
$config['preview_minimal_size_width']   = 300;  // Минимальная ширина превью, если изображение меньше, то на его основе превью создаваться не будет. Актуально только для автоматических превью
$config['preview_minimal_size_height']  = 150;  // Минимальная высота превью, если изображение меньше, то на его основе превью создаваться не будет. Актуально только для автоматических превью

/**
 * Список размеров превью топика
 * Обычно задается другим плагином или шаблоном
 */
$config['size_images_preview']=array(
	array(
		'w' => 285,
		'h' => 305,
		'crop' => true,
	),

    array(
        'w' => 200,
        'h' => 200,
        'crop' => true,
    ),

    array(
        'w' => 350,
        'h' => 370,
        'crop' => true,
    ),
    array(
        'w' => 560,
        'h' => 300,
        'crop' => true,
    ),
    array(
        'w' => 865,
        'h' => 450,
        'crop' => true,
    ),
    array(
        'w' => 85,
        'h' => 85,
        'crop' => true,
    ),
);

/**
 * Системный параметр, его НЕ нужно изменять
 */
$config['load']   = true;

return $config;
?>