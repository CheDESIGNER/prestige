{include file='header.tpl' menu='people'}

<div class="nav-panel people-search" xmlns="http://www.w3.org/1999/html">
    <div class="nav-filter-wrapper" style="margin-bottom: 30px;">
        <ul class="nav nav-filter">
            <li class="abc hidden-phone">
                <div id="user-prefix-filter" class="search-abc">
                    <div class="active"><span class="link-dotted" onclick="return ls.user.searchUsersByPrefix('',this);">{$aLang.user_search_filter_all}</span></div>
                {foreach from=$aPrefixUser item=sPrefixUser}
                    <div><span class="link-dotted" onclick="return ls.user.searchUsersByPrefix('{$sPrefixUser}',this);">{$sPrefixUser}</span></div>
                {/foreach}
                </div>
            </li>
            <li class="search-box">
                <form action="" method="POST" id="form-users-search" onsubmit="return false;" class="search search-item">
                    <input id="search-user-login" type="text" placeholder="{$aLang.user_search_title_hint}" autocomplete="off" name="user_login" value="" onkeyup="ls.timer.run(ls.user.searchUsers,'users_search',['form-users-search'],1000);">
                </form>
            </li>
        </ul>
    </div>
</div>

<div id="users-list-search" style="display:none;"></div>

<div id="users-list-original">
	{router page='people' assign=sUsersRootPage}
	{include file='user_list.tpl' aUsersList=$aUsersRating bUsersUseOrder=true sUsersRootPage=$sUsersRootPage}
</div>

{include file='footer.tpl'}