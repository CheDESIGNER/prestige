<?php


/**
 * ВНИМАНИЕ! ВНИМАНИЕ! Данный конфиг НЕ является рабочим, из него нужно взять только настройки для блоков,
 * НЕ В КОЕМ СЛУЧАИ!!! не заменяйте свой config.php этим файлом!
 */


/**
 * Настройки вывода блоков
 */
$config['block']['rule_panel'] = array(
    'action'  => array(
        'index','blogs','people','blog','profile','talk','settings','my','personal_blog','topic','comments','search','stream'
    ),
    'blocks'  => array(
        'panel_tags' => array('tags'=>array('priority'=>50)),
        'panel_blogs' => array('blogs'=>array('priority'=>50)),
    ),
    'clear' => false,
);

$config['block']['rule_index_blog'] = array(
	'action'  => array(
			'index', 'blog' => array('{topics}','{topic}','{blog}')
		),
	'blocks'  => array(
			'right' => array('stream'=>array('priority'=>100)),
		),
	'clear' => false,
);

$config['block']['rule_index_blog_mobile'] = array(
    'action'  => array(
        'index', 'blog' => array('{topics}','{blog}')
    ),
    'blocks'  => array(
        'rightmobile' => array('stream'=>array('priority'=>100)),
    ),
    'clear' => false,
);

$config['block']['rule_topic_type'] = array(
	'action'  => array(
		'link'     => array('add','edit'),
		'question' => array('add','edit'),
		'topic'    => array('add','edit'),
		'photoset'    => array('add','edit')
	),
	'blocks'  => array( 'right' => array('blocks/block.blogInfo.tpl') ),
);
$config['block']['rule_people'] = array(
	'action'  => array( 'people' ),
	'blocks'  => array( 'right' => array('actions/ActionPeople/sidebar.tpl') ),
);
$config['block']['rule_personal_blog'] = array(
	'action'  => array( 'personal_blog' ),
	'blocks'  => array( 'right' => array('stream') ),
);
$config['block']['rule_profile'] = array(
	'action'  => array( 'profile', 'talk', 'settings' ),
	'blocks'  => array( 'right' => array('actions/ActionProfile/sidebar.tpl') ),
);
$config['block']['rule_tag'] = array(
	'action'  => array( 'tag' ),
	'blocks'  => array( 'right' => array('stream') ),
);
$config['block']['rule_search'] = array(
    'action'  => array( 'search' ),
    'blocks'  => array( 'right' => array('stream') ),
);
$config['block']['rule_blogs'] = array(
	'action'  => array( 'blogs' ),
	'blocks'  => array( 'right' => array('stream') ),
);

$config['block']['userfeedBlogs'] = array(
	'action'  => array('feed'),
	'blocks'  => array(
                    'right' => array(
                        'userfeedBlogs'=> array()
                    )
                )
);
$config['block']['userfeedUsers'] = array(
	'action'  => array('feed'),
	'blocks'  => array(
                    'right' => array(
                        'userfeedUsers'=> array()
                    )
                )
);
$config['block']['rule_blog_info'] = array(
	'action'  => array(
			'blog' => array('{topic}')
		),
	'blocks'  => array(
			'right' => array('blocks/block.blog.tpl'=>array('priority'=>300))
		),
	'clear' => false,
);




return $config;
?>