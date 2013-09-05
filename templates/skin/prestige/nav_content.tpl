{if {cfg name='view.header.fixed'} == 'off' && {cfg name='view.panel.fixed'} == 'on'}
    <div id="nav-panel-dubl" class="nav-panel-dubl">&nbsp;</div>
{/if}

<div {if {cfg name='view.header.fixed'} == 'off' && {cfg name='view.panel.fixed'} == 'on'}id="nav-panel"{/if} class="nav-panel hidden-phone">

    <div class="nav-filter-wrapper">
        <ul class="nav nav-filter">

            <li class="creat-nav">
                <a href="#" class="parent js-style" id="creat-nav"><i class="icox icon-pencil"></i><span>{$aLang.prest_txt_8}</span> <i class="caret-pre"></i></a>
                {if $oUserCurrent}
                    <ul id="creat-nav-sub" class="sub-menu">
                        <li class="link-topic"><a href="{router page='topic'}add"><i class="icox icon-doc-new"></i>{$aLang.prest_txt_19}</a></li>
                        <li class="link-poll"><a href="{router page='question'}add"><i class="icox icon-chart-bar"></i>{$aLang.prest_txt_20}</a></li>
                        <li class="link-link"><a href="{router page='link'}add"><i class="icox icon-link"></i>{$aLang.prest_txt_21}</a></li>
                        <li class="link-photo"><a href="{router page='photoset'}add"><i class="icox icon-picture"></i>{$aLang.prest_txt_22}</a></li>
                        <li class="link-blog"><a href="{router page='blog'}add"><i class="icox icon-folder-empty"></i>{$aLang.prest_txt_23}</a></li>
                        <li class="link-blank"><a href="{router page='topic'}saved/"><i class="icox icon-edit"></i>{$aLang.prest_txt_24} {if $iUserCurrentCountTopicDraft}({$iUserCurrentCountTopicDraft}){/if}</a></li>
                    </ul>
                {else}
                    <ul id="creat-nav-sub" class="sub-menu">
                        <li class="link-topic"><a href="#" class="js-login-form-show"><i class="icox icon-doc-new"></i>{$aLang.prest_txt_19}</a></li>
                        <li class="link-poll"><a href="#" class="js-login-form-show"><i class="icox icon-chart-bar"></i>{$aLang.prest_txt_20}</a></li>
                        <li class="link-link"><a href="#" class="js-login-form-show"><i class="icox icon-link"></i>{$aLang.prest_txt_21}</a></li>
                        <li class="link-photo"><a href="#" class="js-login-form-show"><i class="icox icon-picture"></i>{$aLang.prest_txt_22}</a></li>
                        <li class="link-blog"><a href="#" class="js-login-form-show"><i class="icox icon-folder-empty"></i>{$aLang.prest_txt_23}</a></li>
                        <li class="link-blank"><a href="#" class="js-login-form-show"><i class="icox icon-edit"></i>{$aLang.prest_txt_24} {if $iUserCurrentCountTopicDraft}({$iUserCurrentCountTopicDraft}){/if}</a></li>
                    </ul>
                {/if}
            </li>

            {hook run='menu_blog'}

            <li class="blogs-nav">
                <a href="#" class="parent" id="blogs-nav"><span>{$aLang.block_blogs_all}</span> <i class="caret-pre"></i></a>

                {include file='blocks.tpl' group='panel_blogs'}
            </li>

            <li class="popular-nav">
                <a href="#" class="parent js-style" id="popular-nav"><i class="icox icon-heart"></i><span>{$aLang.prest_txt_7}</span> <i class="caret-pre"></i></a>

                {if $sEvent=='new'}
                    <span id="popular-page-new"></span>
                {elseif $sEvent=='discussed'}
                    <span id="popular-page-discussed"></span>
                {elseif $sEvent=='top'}
                    <span id="popular-page-top"></span>
                {/if}

                <ul id="popular-nav-sub" class="sub-menu">
                    <li class="link-good"><a id="link-good-text" href="{cfg name='path.root.web'}/"><i class="icox icon-heart"></i>{$aLang.prest_txt_7}</a></li>
                    <li class="link-new"><a id="link-new-text" href="{router page='index'}new/?period=all"><i class="icox icon-clock"></i>{$aLang.blog_menu_all_new}{if $iCountTopicsNew>0} +{$iCountTopicsNew}{/if}</a></li>
                    <li class="link-discussed"><a id="link-discussed-text" href="{router page='index'}discussed/?period=all"><i class="icox icon-comment"></i>{$aLang.blog_menu_all_discussed}</a></li>
                    <li class="link-top"><a id="link-top-text" href="{router page='index'}top/?period=all"><i class="icox icon-thumbs-up"></i>{$aLang.blog_menu_all_top}</a></li>
                    {hook run='menu_blog_index_item'}
                </ul>
            </li>

            <li class="tag-nav close">
                <a href="#" class="parent js-style" id="tag-nav"><i class="icox icon-tag"></i><span>{$aLang.prest_txt_9}</span> <i class="caret-pre"></i></a>

                {include file='blocks.tpl' group='panel_tags'}
            </li>

            <li class="search-nav">
                <form action="{router page='search'}topics/" class="search">
                    <input id="input-text-nav-panel" type="text" placeholder="{$aLang.search}" maxlength="255" name="q" class="txt">
                    <input type="submit" value="" title="{$aLang.search_submit}" class="link">
                    <i id="input-button-nav-panel" class="icox icon-search"></i>
                </form>
            </li>

        </ul>

    </div>

    {*Скрыли по дизайну но могут быть проблемы с плагинами, которое это используют
    {if $menu}
        {if in_array($menu,$aMenuContainers)}{$aMenuFetch.$menu}{else}{include file="menu.$menu.tpl"}{/if}
    {/if}
    *}
</div>

<div id="mobile-mainmenu" class="collapse">
    {include file='nav.tpl'}
</div>

<div id="mobile-usermenu" class="collapse">
<div class="wraps">
    {if $oUserCurrent}
        <ul class="panel-user-mobile">
            <li class="top">
                <a class="name" href="{$oUserCurrent->getUserWebPath()}">{$oUserCurrent->getLogin()}</a>
                <span class="skill"><i class="icox icon-flash-outline"></i>{$oUserCurrent->getSkill()}</span>
                <span class="rating"><i class="icox icon-chart-bar"></i>{if $oUserCurrent->getRating() > 0}+{/if}{$oUserCurrent->getRating()}</span>
            </li>
            <li class="bottom">
                <ul class="user-panel-mobile">
                    <li class="creat-ico-mobile"><a href="{router page='topic'}add"><i class="icox icon-pencil"></i></a></li>
                    <li class="mess-ico-mobile"><a href="{router page='talk'}"><i class="icox icon-mail"></i></a></li>
                    <li class="favor-ico-mobile"><a href="{$oUserCurrent->getUserWebPath()}favourites/topics/"><i class="icox icon-bookmark"></i></a></li>
                    <li class="profile-ico-mobile"><a href="{$oUserCurrent->getUserWebPath()}"><i class="icox icon-user"></i></a></li>
                    <li class="sett-ico-mobile"><a href="{router page='settings'}profile/"><i class="icox icon-params"></i></a></li>
                    <li class="exit-ico-mobile"><a href="{router page='login'}exit/?security_ls_key={$LIVESTREET_SECURITY_KEY}"><i class="icox icon-logout"></i></a></li>
                </ul>
            </li>
        </ul>
    {else}
        <ul class="nav-logins">
            <li class="login-item-mobile active"><a href="#">{$aLang.user_login_submit}</a></li>
            <li class="reg-item-mobile"><a href="#">{$aLang.prest_txt_10}</a></li>
        </ul>

        {if $sAction!='login'}
            <script type="text/javascript">
                jQuery(document).ready(function($){
                    $('#login-form-mobile').bind('submit',function(){
                        ls.user.login('login-form-mobile');
                        return false;
                    });
                    $('#login-form-submit-mobile').attr('disabled',false);
                });
            </script>
        {/if}

        <form action="{router page='login'}" method="POST" id="login-form-mobile">
            <input placeholder="{$aLang.user_login}" type="text" id="login" name="login" class="input-text input-width-full" />

            <input placeholder="{$aLang.user_password}" type="password" id="password" name="password" class="input-text input-width-full" />
            <small class="validate-error-hide validate-error-login"></small>

            <button type="submit" name="submit_login" class="button button-primary" id="login-form-submit-mobile" disabled="disabled">{$aLang.user_login_submit}</button>

            <a class="rem-item-mobile" href="#">{$aLang.password_reminder}</a>
        </form>

        {if $sAction!='registration'}
            <script type="text/javascript">
                jQuery(document).ready(function($){
                    $('#registration-form-mobile').find('input.js-ajax-validate').blur(function(e){
                        var aParams={ };
                        if ($(e.target).attr('name')=='password_confirm') {
                            aParams['password']=$('#user-password').val();
                        }
                        if ($(e.target).attr('name')=='password') {
                            aParams['password']=$('#user-password').val();
                            if ($('#user-password-confirm').val()) {
                                ls.user.validateRegistrationField('b',$('#user-password-confirm').val(),$('#registration-form-mobile'),{ 'password': $(e.target).val() });
                            }
                        }
                        ls.user.validateRegistrationField($(e.target).attr('name'),$(e.target).val(),$('#registration-form-mobile'),aParams);
                    });
                    $('#registration-form-mobile').bind('submit',function(){
                        ls.user.registration('registration-form-mobile');
                        return false;
                    });
                    $('#registration-form-submit').attr('disabled',false);
                });
            </script>

            <form action="{router page='registration'}" method="post" id="registration-form-mobile">
                <input placeholder="{$aLang.registration_login}" type="text" name="login" id="registration-login" value="{$_aRequest.login}" class="input-text input-width-full js-ajax-validate" />
                <i class="icon-ok-green validate-ok-field-login" style="display: none"></i>
                <small class="validate-error-hide validate-error-field-login"></small>

                <input placeholder="{$aLang.registration_mail}" type="text" name="mail" id="registration-mail" value="{$_aRequest.mail}" class="input-text input-width-full js-ajax-validate" />
                <i class="icon-ok-green validate-ok-field-mail" style="display: none"></i>
                <small class="validate-error-hide validate-error-field-mail"></small>

                <input placeholder="{$aLang.registration_password}" type="password" name="password" id="user-password" value="" class="input-text input-width-full js-ajax-validate" />
                <i class="icon-ok-green validate-ok-field-password" style="display: none"></i>
                <small class="validate-error-hide validate-error-field-password"></small>

                <input placeholder="{$aLang.registration_password_retry}" type="password" value="" id="user-password-confirm" name="password_confirm" class="input-text input-width-full js-ajax-validate" />
                <i class="icon-ok-green validate-ok-field-password_confirm" style="display: none"></i>
                <small class="validate-error-hide validate-error-field-password_confirm"></small>

                {if $sAction!='registration'}
                    {hookb run="registration_captcha"}
                        <img src="{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}"
                             onclick="this.src='{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}&n='+Math.random();"
                             class="captcha-image" />
                        <input type="text" name="captcha" id="captcha" value="" maxlength="3" class="input-text input-width-100 js-ajax-validate" />
                        <small class="validate-error-hide validate-error-field-captcha"></small>
                    {/hookb}
                {/if}

                <div class="clearfix"></div>
                <button type="submit" name="submit_register" class="button button-primary" id="registration-form-submit" disabled="disabled">{$aLang.registration_submit}</button>
            </form>
        {/if}

        {if $sAction!='login'}
            <script type="text/javascript">
                jQuery(document).ready(function($){
                    $('#reminder-form-mobile').bind('submit',function(){
                        ls.user.reminder('reminder-form-mobile');
                        return false;
                    });
                    $('#reminder-form-submit-mobile').attr('disabled',false);
                });
            </script>
        {/if}

        <form action="{router page='login'}reminder/" method="POST" id="reminder-form-mobile">
            <input placeholder="{$aLang.password_reminder_email}" type="text" name="mail" id="reminder-mail" class="input-text input-width-full" />
            <small class="validate-error-hide validate-error-reminder"></small>

            <button type="submit" name="submit_reminder" class="button button-primary" id="reminder-form-submit" disabled="disabled">{$aLang.password_reminder_submit}</button>
        </form>
    {/if}
</div>
</div>

<div id="search-mobile" class="search-mobile collapse">
    <form action="{router page='search'}topics/">
        <input id="input-text-nav-panel" type="text" placeholder="{$aLang.search}" maxlength="255" name="q" class="txt">
        <input type="submit" value="" title="{$aLang.search_submit}" class="link">
        <i id="input-button-nav-panel" class="icox icon-search"></i>
    </form>
</div>

{if $sAction!='profile'}
<div class="drop-mobile-links-popular">
    <a id="links-mobile-popular" href="#" class="links collapse" data-toggle="collapse" data-target=".drop-menu-popular">
        <i class="icox icon-heart"></i>
        <span>{$aLang.prest_txt_7}</span>
        <i class="caret-pre"></i>
    </a>

    {if $sEvent=='new'}
        <span id="popular-page-new-mobile"></span>
    {elseif $sEvent=='discussed'}
        <span id="popular-page-discussed-mobile"></span>
    {elseif $sEvent=='top'}
        <span id="popular-page-top-mobile"></span>
    {/if}

    <ul id="popular-nav-sub-mobile" class="drop-menu-popular collapse">
        <li class="link-good"><a id="link-good-text-mobile" href="{cfg name='path.root.web'}/"><i class="icox icon-heart"></i>{$aLang.prest_txt_7}</a></li>
        <li class="link-new"><a id="link-new-text-mobile" href="{router page='index'}new/?period=all"><i class="icox icon-clock"></i>{$aLang.blog_menu_all_new}{if $iCountTopicsNew>0} +{$iCountTopicsNew}{/if}</a></li>
        <li class="link-discussed"><a id="link-discussed-text-mobile" href="{router page='index'}discussed/?period=all"><i class="icox icon-comment"></i>{$aLang.blog_menu_all_discussed}</a></li>
        <li class="link-top"><a id="link-top-text-mobile" href="{router page='index'}top/?period=all"><i class="icox icon-thumbs-up"></i>{$aLang.blog_menu_all_top}</a></li>
    </ul>
</div>
{/if}