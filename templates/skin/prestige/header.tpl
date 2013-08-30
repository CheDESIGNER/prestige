<!doctype html>

<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="ru"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="ru"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="ru"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="ru"> <!--<![endif]-->

<head>
	{hook run='html_head_begin'}
	
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	
	<title>{$sHtmlTitle}</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<meta name="description" content="{$sHtmlDescription}">
	<meta name="keywords" content="{$sHtmlKeywords}">

    {if {cfg name='view.ogmeta.type'} == 'on'}
        {if !$bTopicList && $sAction == 'blog' && $oTopic}
            {assign var="oBlog" value=$oTopic->getBlog()}
            {assign var="oUser" value=$oTopic->getUser()}

            <meta property="og:type" content="article">
            <meta property="og:url" content="{$oTopic->getUrl()}">
            <meta property="og:site_name" content="{cfg name='view.name'}">
            {if $oTopic->getPreviewImage()}
                <meta property="og:image" content="{$oTopic->getPreviewImageWebPath(200crop)}">
            {/if}
            <meta property="og:title" content="{$oTopic->getTitle()|escape:'html'}">
            <meta property="og:description" content="{$oTopic->getTextShort()|strip|strip_tags:true|truncate:160:'...'}">
            <meta property="article:author" content="{$oUser->getUserWebPath()}">
            <meta property="article:section" content="{$oBlog->getTitle()|escape:'html'}">
            {strip}
                {if $oTopic->getTagsArray()}
                    <meta property="article:tag" content="
                    {foreach from=$oTopic->getTagsArray() item=sTag name=tags_list}
                        {if !$smarty.foreach.tags_list.first}, {/if}{$sTag|escape:'html'}
                    {/foreach}
                    ">
                {/if}
            {/strip}

            <meta name="twitter:card" content="summary">
            {*<meta name="twitter:site" content="@themeprestige" />*}
            <meta name="twitter:url" content="{$oTopic->getUrl()}">
            <meta name="twitter:title" content="{$oTopic->getTitle()|escape:'html'}">
            <meta name="twitter:description" content="{$oTopic->getTextShort()|strip|strip_tags:true|truncate:160:'...'}">
            {if $oTopic->getPreviewImage()}
                <meta name="twitter:image" content="{$oTopic->getPreviewImageWebPath(200crop)}">
            {/if}
        {/if}
    {/if}

	{$aHtmlHeadFiles.css}

    <link href="http://fonts.googleapis.com/css?family=PT+Sans:400,700&subset=latin,cyrillic" rel="stylesheet" type="text/css">
    <link href='http://fonts.googleapis.com/css?family=PT+Sans+Narrow:400,700&subset=latin,cyrillic' rel='stylesheet' type='text/css'>

	<link href="{cfg name='path.static.skin'}/images/favicon.ico?v1" rel="shortcut icon" />
	<link rel="search" type="application/opensearchdescription+xml" href="{router page='search'}opensearch/" title="{cfg name='view.name'}" />

	{if $aHtmlRssAlternate}
		<link rel="alternate" type="application/rss+xml" href="{$aHtmlRssAlternate.url}" title="{$aHtmlRssAlternate.title}">
	{/if}

	{if $sHtmlCanonical}
		<link rel="canonical" href="{$sHtmlCanonical}" />
	{/if}
	
	{if $bRefreshToHome}
		<meta  HTTP-EQUIV="Refresh" CONTENT="3; URL={cfg name='path.root.web'}/">
	{/if}
	
	
	<script type="text/javascript">
		var DIR_WEB_ROOT 			= '{cfg name="path.root.web"}';
		var DIR_STATIC_SKIN 		= '{cfg name="path.static.skin"}';
		var DIR_ROOT_ENGINE_LIB 	= '{cfg name="path.root.engine_lib"}';
		var LIVESTREET_SECURITY_KEY = '{$LIVESTREET_SECURITY_KEY}';
		var SESSION_ID				= '{$_sPhpSessionId}';
		var BLOG_USE_TINYMCE		= '{cfg name="view.tinymce"}';
		
		var TINYMCE_LANG = 'en';
		{if $oConfig->GetValue('lang.current') == 'russian'}
			TINYMCE_LANG = 'ru';
		{/if}

		var aRouter = new Array();
		{foreach from=$aRouter key=sPage item=sPath}
			aRouter['{$sPage}'] = '{$sPath}';
		{/foreach}
	</script>
	
	
	{$aHtmlHeadFiles.js}

    {if {cfg name='view.masonry.type'} == 'on'}
        <script type="text/javascript" src="{cfg name="path.static.skin"}/js/jquery.isotope.min.js"></script>
        <script type="text/javascript" src="{cfg name="path.static.skin"}/js/jquery.imagesloaded.min.js"></script>
        <script type="text/javascript">
            jQuery(document).ready(function() {
                var $container = $('#masonry-box');

                /*  Isotope utility GetUnitWidth
                 ========================================================================== */
                function getUnitWidth() {
                    var width;
                    if ($container.width() <= 320) {
                        console.log("320");
                        width = Math.floor($container.width() / 1);
                    } else if ($container.width() >= 321 && $container.width() <= 480) {
                        console.log("321 - 480");
                        width = Math.floor($container.width() / 1);
                    } else if ($container.width() >= 481 && $container.width() <= 768) {
                        console.log("481 - 768");
                        width = Math.floor($container.width() / 2);
                    } else if ($container.width() >= 769 && $container.width() <= 979) {
                        console.log("769 - 979");
                        width = Math.floor($container.width() / 3);
                    } else if ($container.width() >= 980 && $container.width() <= 1200) {
                        console.log("980 - 1200");
                        width = Math.floor($container.width() / 4);
                    } else if ($container.width() >= 1201 && $container.width() <= 1600) {
                        console.log("1201 - 1600");
                        width = Math.floor($container.width() / 4);
                    } else if ($container.width() >= 1601 && $container.width() <= 1824) {
                        console.log("1601 - 1824");
                        width = Math.floor($container.width() / 5);
                    } else if ($container.width() >= 1825) {
                        console.log("1825");
                        width = Math.floor($container.width() / 5);
                    }
                    return width;
                }

                /*  Isotope utility SetWidths
                 ========================================================================== */
                function setWidths() {
                    var unitWidth = getUnitWidth() - 0;
                    $container.children(":not(.width2)").css({
                        width: unitWidth
                    });

                    if ($container.width() >= 321 && $container.width() <= 480) {
                        console.log("eccoci 321");
                        $container.children(".width2").css({
                            width: unitWidth * 1
                        });
                        $container.children(".width4").css({
                            width: unitWidth * 2
                        });
                        $container.children(".width6").css({
                            width: unitWidth * 2
                        });
                    }
                    if ($container.width() >= 481) {
                        console.log("480");
                        $container.children(".width6").css({
                            width: unitWidth * 6
                        });
                        $container.children(".width4").css({
                            width: unitWidth * 4
                        });
                        $container.children(".width2").css({
                            width: unitWidth * 2
                        });
                    } else {
                        $container.children(".width2").css({
                            width: unitWidth
                        });
                    }
                }

                // update columnWidth on window resize
                jQuery(window).smartresize(function() {
                    //setGMapHeight();
                    //getUnitW();
                    // set the widths on resize
                    setWidths();
                    // reinit isotop
                    $container.isotope({
                        //animationEngine : 'jquery',
                        //transformsEnabled: false,
                        // update columnWidth to a percentage of container width
                        masonry: {
                            columnWidth: getUnitWidth()
                        }
                    });

                }).resize();

                $container.imagesLoaded( function(){
                    $container.isotope({
                        itemSelector : '.item',
                        //resizable : false,
                        animationEngine : 'css',
                        masonry: {
                            columnWidth: getUnitWidth()
                        }
                    });
                });

            });
        </script>
    {/if}

	<script type="text/javascript">
		var tinyMCE = false;
		ls.lang.load({json var = $aLangJs});
		ls.registry.set('comment_max_tree',{json var=$oConfig->Get('module.comment.max_tree')});
		ls.registry.set('block_stream_show_tip',{json var=$oConfig->Get('block.stream.show_tip')});
	</script>

    {if $sAction=='login' && $sEvent=='exit'}
        <style>
            html, body {
                height: 100%;
                padding: 0;
                margin: 0;
            }
        </style>
    {/if}
	
	{hook run='html_head_end'}
</head>



{if $oUserCurrent}
	{assign var=body_classes value=$body_classes|cat:' ls-user-role-user'}
	
	{if $oUserCurrent->isAdministrator()}
		{assign var=body_classes value=$body_classes|cat:' ls-user-role-admin'}
	{/if}
{else}
	{assign var=body_classes value=$body_classes|cat:' ls-user-role-guest'}
{/if}

{if !$oUserCurrent or ($oUserCurrent and !$oUserCurrent->isAdministrator())}
	{assign var=body_classes value=$body_classes|cat:' ls-user-role-not-admin'}
{/if}

{add_block group='toolbar' name='toolbar_admin.tpl' priority=100}
{add_block group='toolbar' name='toolbar_scrollup.tpl' priority=-100}




<body class="{$body_classes} width-{cfg name='view.grid.type'}">

{if $sAction!='login' && $sAction!='registration'} {*Для страницы авторизации/регистрации/напоминания*}
	{hook run='body_begin'}
	
	
	{if $oUserCurrent}
		{include file='window_write.tpl'}
		{include file='window_favourite_form_tags.tpl'}
	{else}
		{include file='window_login.tpl'}
	{/if}

    {include file='header_top.tpl'}

	<div id="container" class="{hook run='container_class'}">
		<div id="wrapper" class="{hook run='wrapper_class'}">
        {if $sEvent!='add'}
            {include file='nav_content.tpl'}
        {/if}
{elseif ($sAction=='login' && $sEvent!='exit') || ($sAction=='registration' && $sEvent=='invite')}
    {include file='header_top_mobile.tpl'}
{/if}
			<div id="content" role="main" 
				class="{if $noSidebar}content-full-width{/if}
					   {if $sAction=='profile' || $sAction=='talk' || $sAction=='settings' || $sAction=='blogs'}profile-page{/if}
					   {if $sAction=='people'}people-page{/if}
					   {if $sAction=='login' && $sEvent=='exit'}exit-page{/if}
					   {if $sMenuHeadItemSelect=='blog' && $sAction!='index'}blog-page{/if}
					   {if {cfg name='view.masonry.type'} == 'on'}masonry-on
					   {elseif {cfg name='view.bigpreview.type'} == 'on'}bigpreview-on{/if}
					   "
				{if $sMenuItemSelect=='profile'}itemscope itemtype="http://data-vocabulary.org/Person"{/if}>

				{include file='system_message.tpl'}
				
				{hook run='content_begin'}