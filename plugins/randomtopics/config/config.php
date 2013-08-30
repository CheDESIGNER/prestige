<?php
/*
  Random Topics
  s4people - 2013
  http://livestreet.ru/profile/s4people/
  http://wstandart.ru
*/


$config = array ();

// Количество топиков для вывода
$config ['Topics_Count'] = 9;


// Выводим блок

Config::Set ('block.rule_random', array (
    'action'  => array(
        'index','blogs','people','blog','blog' => array('{topics}','{topic}','{blog}'),'my','personal_blog','comments','search'
    ),
    'blocks' => array (
        'right' => array (
            'random' => array (
                'params' => array ('plugin' => 'randomtopics'),
                'priority' => 0,
            ),
        )
    ),
));

// Для мобильной версии

Config::Set ('block.rule_random_mobile', array (
    'action'  => array(
        'index', 'blog' => array('{topics}','{blog}')
    ),
    'blocks'  => array(
        'rightmobile' => array(
            'random' => array (
                'params' => array ('plugin' => 'randomtopics'),
                'priority' => 10,
            ),
        ),
    ),
));

return $config;

?>