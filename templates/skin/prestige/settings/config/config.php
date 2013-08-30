<?php

$config = array();


/*
 * Заготовка для будущей кастомизации шаблона
 */
$config['view']['theme'] = 'default';


/*
 * !!!ВАЖНО!!! - обе вида лент не могут работать вместе либо masonry-плитка, либо большие привью
 */

/* Подключает лист топиков плиткой masonry
 * on - включено
 * off - выключено
 *
 * Подключаем последний большой топик
 * on - включено
 * off - выключено
 */
$config['view']['masonry']['type'] = 'on';
$config['view']['masonry']['bigtopic'] = 'on';

/* Подключает лист топиков с большой очень большой привью
 * on - включено
 * off - выключено
 */
$config['view']['bigpreview']['type'] = 'off';

/* Подключает Open Graph и Twitter Cards
 * on - включено
 * off - выключено
 */
$config['view']['ogmeta']['type'] = 'on';



/*
 * !!!ВАЖНО!!! - обе плавающие панели не могут работать вместе только по отдельности!
 */

/* Шапка-панель плавающая
 * on - включено
 * off - выключено
 */
$config['view']['header']['fixed'] = 'off';

/* Главная-панель плавающая
 * on - включено
 * off - выключено
 */
$config['view']['panel']['fixed'] = 'on';


$config['head']['default']['js'] = Config::Get('head.default.js');
$config['head']['default']['js'][] = '___path.static.skin___/js/template.js';
$config['head']['default']['js'][] = '___path.static.skin___/js/bootstrap.js';

$config['head']['default']['css'] = array(
	 "___path.static.skin___/css/prestige.css",
    "___path.static.skin___/css/bootstrap.css",
    "___path.static.skin___/css/mobile.css",
    "___path.static.skin___/css/mod.css",
	"___path.static.skin___/css/reset.css",
	"___path.static.skin___/css/base.css",
	"___path.root.engine_lib___/external/jquery/markitup/skins/simple/style.css",
	"___path.root.engine_lib___/external/jquery/markitup/sets/default/style.css",
	"___path.root.engine_lib___/external/jquery/jcrop/jquery.Jcrop.css",
	"___path.root.engine_lib___/external/prettify/prettify.css",
	"___path.static.skin___/css/grid.css",
	"___path.static.skin___/css/common.css",
	"___path.static.skin___/css/text.css",
	"___path.static.skin___/css/forms.css",
	"___path.static.skin___/css/buttons.css",
	"___path.static.skin___/css/navs.css",
	"___path.static.skin___/css/icons.css",
	"___path.static.skin___/css/tables.css",
	"___path.static.skin___/css/topic.css",
	"___path.static.skin___/css/comments.css",
	"___path.static.skin___/css/blocks.css",
	"___path.static.skin___/css/modals.css",
	"___path.static.skin___/css/blog.css",
	"___path.static.skin___/css/profile.css",
	"___path.static.skin___/css/wall.css",
	"___path.static.skin___/css/infobox.css",
	"___path.static.skin___/css/jquery.notifier.css",
	"___path.static.skin___/css/smoothness/jquery-ui.css",
	"___path.static.skin___/themes/___view.theme___/style.css",
	"___path.static.skin___/css/print.css",
);

$config['module']['blog']['avatar_size'] = array(270,150,100,64,48,24,0); // добавлен для шаблона 150на150 и 270на270

$config['block']['blogs']['row']  = 10; // дроп меню список блогов, сколько выводить.

return $config;
?>