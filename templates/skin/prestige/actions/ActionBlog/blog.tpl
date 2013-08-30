{include file='header.tpl'}
{assign var="oUserOwner" value=$oBlog->getOwner()}
{assign var="oVote" value=$oBlog->getVote()}


<script type="text/javascript">
	jQuery(function($){
		ls.lang.load({lang_load name="blog_fold_info,blog_expand_info"});
	});
</script>


{if $oUserCurrent and $oUserCurrent->isAdministrator()}
	<div id="blog_delete_form" class="modal">
		<header class="modal-header">
			<h3>{$aLang.blog_admin_delete_title}</h3>
			<a href="#" class="close jqmClose"></a>
		</header>
		
		
		<form action="{router page='blog'}delete/{$oBlog->getId()}/" method="POST" class="modal-content">
			<p><label for="topic_move_to">{$aLang.blog_admin_delete_move}:</label>
			<select name="topic_move_to" id="topic_move_to" class="input-width-full">
				<option value="-1">{$aLang.blog_delete_clear}</option>
				{if $aBlogs}
					<optgroup label="{$aLang.blogs}">
						{foreach from=$aBlogs item=oBlogDelete}
							<option value="{$oBlogDelete->getId()}">{$oBlogDelete->getTitle()|escape:'html'}</option>
						{/foreach}
					</optgroup>
				{/if}
			</select></p>
			
			<input type="hidden" value="{$LIVESTREET_SECURITY_KEY}" name="security_ls_key" />
			<button type="submit" class="button button-primary">{$aLang.blog_delete}</button>
		</form>
	</div>
{/if}


<div class="blogs-lists">
    <ul class="lists">
        <li class="one-blog blog-open">
            <div id="vote_area_blog_{$oBlog->getId()}" class="vote {if $oBlog->getRating() > 0}vote-count-positive{elseif $oBlog->getRating() < 0}vote-count-negative{/if} {if $oVote} voted {if $oVote->getDirection()>0}voted-up{elseif $oVote->getDirection()<0}voted-down{/if}{/if}">
                <div id="vote_total_blog_{$oBlog->getId()}" class="vote-count count" title="{$aLang.blog_vote_count}: {$oBlog->getCountVote()}">{if $oBlog->getRating() > 0}+{/if}{$oBlog->getRating()}</div>
                <a href="#" class="vote-down" onclick="return ls.vote.vote({$oBlog->getId()},this,-1,'blog');"><i class="icox icon-thumbs-down"></i></a>
                <div class="vote-line"></div>
                <a href="#" class="vote-up" onclick="return ls.vote.vote({$oBlog->getId()},this,1,'blog');"><i class="icox icon-thumbs-up"></i></a>
            </div>

            <div class="name-blog">
                <a href="{$oBlog->getUrlFull()}" class="avatar">
                    <img src="{$oBlog->getAvatarPath(150)}" />
                </a>

                {if $oUserCurrent and ($oUserCurrent->getId()==$oBlog->getOwnerId() or $oUserCurrent->isAdministrator() or $oBlog->getUserIsAdministrator() )}
                    <ul class="actions">
                        <li>
                            <a href="{router page='blog'}edit/{$oBlog->getId()}/" title="{$aLang.blog_edit}" class="edit">{$aLang.blog_edit}</a>
                        </li>
                        {if $oUserCurrent->isAdministrator()}
                        <li>
                            <a href="#" title="{$aLang.blog_delete}" id="blog_delete_show" class="delete">{$aLang.blog_delete}</a>
                        {else}
                            <a href="{router page='blog'}delete/{$oBlog->getId()}/?security_ls_key={$LIVESTREET_SECURITY_KEY}" title="{$aLang.blog_delete}" onclick="return confirm('{$aLang.blog_admin_delete_confirm}');" >{$aLang.blog_delete}</a>
                        {/if}
                        </li>
                    </ul>
                {/if}

                {if $oBlog->getType() == 'close'}
                    <i title="{$aLang.blog_closed}" class="icon-lock"></i>
                {/if}

                <a href="{$oBlog->getUrlFull()}" class="title" id="page-blog-title">{$oBlog->getTitle()|escape:'html'}</a>

                {if $oUserCurrent}
                    {if $oUserCurrent->getId() != $oBlog->getOwnerId() and $oBlog->getType() == 'open'}
                        <a href="#" onclick="ls.blog.toggleJoin(this, {$oBlog->getId()}); return false;" class="join-link button button-primary ">
                            {if $oBlog->getUserIsJoin()}
                                {$aLang.blog_leave}
                            {else}
                                {$aLang.blog_join}
                            {/if}
                        </a>
                    {/if}
                {/if}
            </div>

            <ul class="nav nav-pills nav-profile nav-info-blog">
                <li class="link-desc active"><a>{$aLang.prest_txt_13}</a></li>
                <li class="link-admin"><a>{$aLang.prest_txt_14} <span>{$iCountBlogAdministrators}</span></a></li>
                <li class="link-moder"><a>{$aLang.prest_txt_15} <span>{$iCountBlogModerators}</span></a></li>
                <li class="link-read"><a>{$aLang.prest_txt_16} <span>{$iCountBlogUsers}</span></a></li>
            </ul>

            <div class="txt-info desc-info-blog">
                {$oBlog->getDescription()}
            </div>

            <div class="avatar-info admin-blog">
                <ul class="user-list-avatar">
                    <li>
                        <a href="{$oUserOwner->getUserWebPath()}" title="{$oUserOwner->getLogin()}"><img src="{$oUserOwner->getProfileAvatarPath(48)}" class="avatar" /></a>
                    </li>
                    {if $aBlogAdministrators}
                        {foreach from=$aBlogAdministrators item=oBlogUser}
                            {assign var="oUser" value=$oBlogUser->getUser()}
                            <li>
                                <a href="{$oUser->getUserWebPath()}" title="{$oUser->getLogin()}"><img src="{$oUser->getProfileAvatarPath(48)}" class="avatar" /></a>
                            </li>
                        {/foreach}
                    {/if}
                </ul>
            </div>

            <div class="avatar-info moder-blog">
                {if $aBlogModerators}
                    <ul class="user-list-avatar">
                        {foreach from=$aBlogModerators item=oBlogUser}
                            {assign var="oUser" value=$oBlogUser->getUser()}
                            <li>
                                <a href="{$oUser->getUserWebPath()}" title="{$oUser->getLogin()}"><img src="{$oUser->getProfileAvatarPath(48)}" class="avatar" /></a>
                            </li>
                        {/foreach}
                    </ul>
                {else}
                    {$aLang.blog_user_moderators_empty}
                {/if}
            </div>

            <div class="avatar-info user-blog">
                {if $aBlogUsers}
                    <ul class="user-list-avatar">
                        {foreach from=$aBlogUsers item=oBlogUser}
                            {assign var="oUser" value=$oBlogUser->getUser()}
                            <li>
                                <a href="{$oUser->getUserWebPath()}" title="{$oUser->getLogin()}"><img src="{$oUser->getProfileAvatarPath(48)}" class="avatar" /></a>
                            </li>
                        {/foreach}
                    </ul>

                    {if count($aBlogUsers) < $iCountBlogUsers}
                        <br /><a href="{$oBlog->getUrlFull()}users/">{$aLang.blog_user_readers_all}</a>
                    {/if}
                {else}
                    {$aLang.blog_user_readers_empty}
                {/if}
            </div>
        </li>
    </ul>
</div>

{*
<div class="nav-filter-wrapper">
	<ul class="nav nav-filter">
		<li {if $sMenuSubItemSelect=='good'}class="active"{/if}><a href="{$sMenuSubBlogUrl}">{$aLang.blog_menu_collective_good}</a></li>
		<li {if $sMenuSubItemSelect=='new'}class="active"{/if}><a href="{$sMenuSubBlogUrl}newall/">{$aLang.blog_menu_collective_new}</a>{if $iCountTopicsBlogNew>0} <a href="{$sMenuSubBlogUrl}new/">+{$iCountTopicsBlogNew}</a>{/if}</li>
		<li {if $sMenuSubItemSelect=='discussed'}class="active"{/if}><a href="{$sMenuSubBlogUrl}discussed/">{$aLang.blog_menu_collective_discussed}</a></li>
		<li {if $sMenuSubItemSelect=='top'}class="active"{/if}><a href="{$sMenuSubBlogUrl}top/">{$aLang.blog_menu_collective_top}</a></li>
		{hook run='menu_blog_blog_item'}
	</ul>

	{if $sPeriodSelectCurrent}
		<ul class="nav nav-filter nav-filter-sub">
			<li {if $sPeriodSelectCurrent=='1'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=1">{$aLang.blog_menu_top_period_24h}</a></li>
			<li {if $sPeriodSelectCurrent=='7'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=7">{$aLang.blog_menu_top_period_7d}</a></li>
			<li {if $sPeriodSelectCurrent=='30'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=30">{$aLang.blog_menu_top_period_30d}</a></li>
			<li {if $sPeriodSelectCurrent=='all'}class="active"{/if}><a href="{$sPeriodSelectRoot}?period=all">{$aLang.blog_menu_top_period_all}</a></li>
		</ul>
	{/if}
</div>
*}


<div class="blog-topics {if {cfg name='view.masonry.type'} == 'on'}masonry-on{/if}">
    {if $bCloseBlog}
        {$aLang.blog_close_show}
    {else}
        {include file='topic_list.tpl'}
    {/if}
</div>


{include file='footer.tpl'}