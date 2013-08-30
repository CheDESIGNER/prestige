{assign var="sidebarPosition" value='left'}
{include file='header.tpl'}

{include file='actions/ActionProfile/profile_top.tpl'}
<div class="content-profile">



{include file='user_list.tpl' aUsersList=$aFriends}


</div><!-- /content-profile -->

{include file='footer.tpl'}