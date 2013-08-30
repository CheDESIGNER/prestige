{if {cfg name='view.header.fixed'} == 'on' && {cfg name='view.panel.fixed'} == 'off'}
    <header id="header-dubl" class="visible-desktop"></header>
{/if}
<header id="header" role="banner" class="visible-desktop {if {cfg name='view.header.fixed'} == 'on' && {cfg name='view.panel.fixed'} == 'off'}fixed{/if}">
    {hook run='header_banner_begin'}
        <a href="{cfg name='path.root.web'}" class="logo" title="{cfg name='view.name'}"></a>

        {include file='nav.tpl'}

        {hook run='userbar_nav'}

        <ul class="nav-userbar">
            {if $oUserCurrent}
                <li class="nav-userbar-username">
                    <a href="#" class="username" id="drop-user-menu-link">
                        {if $iUserCurrentCountTalkNew}
                            <span class="ico-new-mess">
                                {$iUserCurrentCountTalkNew}
                            </span>
                        {/if}
                        <img src="{$oUserCurrent->getProfileAvatarPath(48)}" alt="avatar" class="avatar" />
                        {$oUserCurrent->getLogin()}

                        <span class="caret-pre" id="drop-user-menu-caret"></span>
                    </a>
                    <ul id="drop-user-menu">
                        <li class="item-stat">
                            <span class="strength"><i class="icox icon-flash-outline"></i>{$oUserCurrent->getSkill()}</span>
                            <span class="rating"><i class="icox icon-chart-bar"></i>{if $oUserCurrent->getRating() > 0}+{/if}{$oUserCurrent->getRating()}</span>
                        </li>
                        <li class="item-messages">
                            <a href="{router page='talk'}" {if $iUserCurrentCountTalkNew}class="new-messages"{/if} id="new_messages" title="{if $iUserCurrentCountTalkNew}{$aLang.user_privat_messages_new}{/if}">
                                <i class="icox icon-mail"></i>{$aLang.user_privat_messages}{if $iUserCurrentCountTalkNew} + {$iUserCurrentCountTalkNew}{/if}
                            </a>
                        </li>
                        <li class="item-favourite"><a href="{$oUserCurrent->getUserWebPath()}favourites/topics/"><i class="icox icon-bookmark"></i>{$aLang.user_menu_profile_favourites}</a></li>
                        <li class="item-profile"><a href="{$oUserCurrent->getUserWebPath()}"><i class="icox icon-user"></i>{$aLang.prest_txt_11}</a></li>
                        <li class="item-settings"><a href="{router page='settings'}profile/"><i class="icox icon-params"></i>{$aLang.user_settings}</a></li>
                        <li class="item-create"><a href="{router page='topic'}add/" class="write" id="modal_write_show"><i class="icox icon-pencil"></i>{$aLang.block_create}</a></li>
                        {hook run='userbar_item'}
                        <li class="item-signout"><a href="{router page='login'}exit/?security_ls_key={$LIVESTREET_SECURITY_KEY}"><i class="icox icon-logout"></i>{$aLang.exit}</a></li>
                    </ul>
                </li>

            {else}
                {hook run='userbar_item'}
                <li><a href="{router page='login'}" class="js-login-form-show">{$aLang.user_login_submit}</a></li>
                <li>{$aLang.or_text}</li>
                <li><a href="{router page='registration'}" class="js-registration-form-show">{$aLang.registration_submit}</a></li>
            {/if}
        </ul>

    {hook run='header_banner_end'}
</header>

<header id="header-mobile" class="hidden-desktop">

    <a href="#" class="drop-mobile-mainmenu collapse" data-toggle="collapse" data-target="#mobile-mainmenu"><i class="icox icon-menu"></i></a>

    <a href="{cfg name='path.root.web'}" class="logo" title="{cfg name='view.name'}"></a>

    <div class="icons-top-mobile">
        <a href="#" class="drop-mobile-usermenu collapse" data-toggle="collapse" data-target="#mobile-usermenu"><i class="icox icon-user"></i></a>

        <a href="#" class="drop-mobile-search collapse" data-toggle="collapse" data-target="#search-mobile"><i class="icox icon-search"></i></a>
    </div>

    {include file='nav.tpl'}

    <ul class="nav-userbar">
        {if $oUserCurrent}
            <li class="nav-userbar-username">
                <a href="#" class="username" id="drop-user-menu-link-mobile">
                    {if $iUserCurrentCountTalkNew}
                        <span class="ico-new-mess">
                            {$iUserCurrentCountTalkNew}
                        </span>
                    {/if}
                    <img src="{$oUserCurrent->getProfileAvatarPath(48)}" alt="avatar" class="avatar" />
                    {$oUserCurrent->getLogin()}

                    <span class="caret-pre" id="drop-user-menu-caret-mobile"></span>
                </a>

                <ul id="drop-user-menu-mobile">
                    <li class="item-stat">
                        <span class="strength"><i class="icox icon-flash-outline"></i>{$oUserCurrent->getSkill()}</span>
                        <span class="rating"><i class="icox icon-chart-bar"></i>{if $oUserCurrent->getRating() > 0}+{/if}{$oUserCurrent->getRating()}</span>
                    </li>
                    <li class="item-messages">
                        <a href="{router page='talk'}" {if $iUserCurrentCountTalkNew}class="new-messages"{/if} id="new_messages" title="{if $iUserCurrentCountTalkNew}{$aLang.user_privat_messages_new}{/if}">
                            <i class="icox icon-mail"></i>{$aLang.user_privat_messages}{if $iUserCurrentCountTalkNew} + {$iUserCurrentCountTalkNew}{/if}
                        </a>
                    </li>
                    <li class="item-favourite"><a href="{$oUserCurrent->getUserWebPath()}favourites/topics/"><i class="icox icon-bookmark"></i>{$aLang.user_menu_profile_favourites}</a></li>
                    <li class="item-profile"><a href="{$oUserCurrent->getUserWebPath()}"><i class="icox icon-user"></i>{$aLang.prest_txt_11}</a></li>
                    <li class="item-settings"><a href="{router page='settings'}profile/"><i class="icox icon-params"></i>{$aLang.user_settings}</a></li>
                    <li class="item-create"><a href="{router page='topic'}add/" class="write" id="modal_write_show"><i class="icox icon-pencil"></i>{$aLang.block_create}</a></li>
                    {hook run='userbar_item'}
                    <li class="item-signout"><a href="{router page='login'}exit/?security_ls_key={$LIVESTREET_SECURITY_KEY}"><i class="icox icon-logout"></i>{$aLang.exit}</a></li>
                </ul>
            </li>

        {else}
            {hook run='userbar_item'}
            <li><a href="{router page='login'}" class="js-login-form-show">{$aLang.user_login_submit}</a></li>
            <li>{$aLang.or_text}</li>
            <li><a href="{router page='registration'}" class="js-registration-form-show">{$aLang.registration_submit}</a></li>
        {/if}
    </ul>

</header>