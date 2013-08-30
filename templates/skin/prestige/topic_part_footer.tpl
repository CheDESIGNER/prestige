	{assign var="oBlog" value=$oTopic->getBlog()}
	{assign var="oUser" value=$oTopic->getUser()}
	{assign var="oVote" value=$oTopic->getVote()}
	{assign var="oFavourite" value=$oTopic->getFavourite()}


	<footer class="topic-footer">
    {if !$bTopicList}
		<ul class="topic-tags js-favourite-insert-after-form js-favourite-tags-topic-{$oTopic->getId()}">
			<li class="img" title="{$aLang.topic_tags}"><i class="icox icon-tag"></i></li>
			
			{strip}
				{if $oTopic->getTagsArray()}
					{foreach from=$oTopic->getTagsArray() item=sTag name=tags_list}
						<li>{if !$smarty.foreach.tags_list.first}, {/if}<a rel="tag" href="{router page='tag'}{$sTag|escape:'url'}/">{$sTag|escape:'html'}</a></li>
					{/foreach}
				{else}
					<li>{$aLang.topic_tags_empty}</li>
				{/if}
				
				{if $oUserCurrent}
					{if $oFavourite}
						{foreach from=$oFavourite->getTagsArray() item=sTag name=tags_list_user}
							<li class="topic-tags-user js-favourite-tag-user">, <a rel="tag" href="{$oUserCurrent->getUserWebPath()}favourites/topics/tag/{$sTag|escape:'url'}/">{$sTag|escape:'html'}</a></li>
						{/foreach}
					{/if}
					
					<li class="topic-tags-edit js-favourite-tag-edit" {if !$oFavourite}style="display:none;"{/if}>
						<a href="#" onclick="return ls.favourite.showEditTags({$oTopic->getId()},'topic',this);" class="link-dotted">{$aLang.favourite_form_tags_button_show}</a>
					</li>
				{/if}
			{/strip}
		</ul>
    {/if}


		<div class="topic-share" id="topic_share_{$oTopic->getId()}">
			{hookb run="topic_share" topic=$oTopic bTopicList=$bTopicList}
				<div class="yashare-auto-init" data-yashareTitle="{$oTopic->getTitle()|escape:'html'}" data-yashareLink="{$oTopic->getUrl()}" data-yashareL10n="ru" data-yashareType="button" data-yashareQuickServices="yaru,vkontakte,facebook,twitter,odnoklassniki,moimir,lj,gplus"></div>
			{/hookb}
		</div>

		<ul class="topic-info">
        {if $bTopicList}
            <li class="topic-info-author">
                <a rel="author" href="{$oUser->getUserWebPath()}">
                    <img src="{$oUser->getProfileAvatarPath(48)}" class="avatar" />
                    {$oUser->getLogin()}
                </a>
            </li>
            <li class="topic-info-comments">
                <a href="{$oTopic->getUrl()}#comments" title="{$oTopic->getCountComment()} {$oTopic->getCountComment()|declension:$aLang.comment_declension:'russian'}">
                    <i class="icox icon-comment"></i>{$oTopic->getCountComment()}
                </a>
                {if $oTopic->getCountCommentNew()}<span>+{$oTopic->getCountCommentNew()}</span>{/if}
            </li>
        {/if}

        {if !$bTopicList}
            <li class="topic-info-author">
                <a rel="author" href="{$oUser->getUserWebPath()}">
                    <img src="{$oUser->getProfileAvatarPath(48)}" class="avatar" />
                    {$oUser->getLogin()}
                </a>
            </li>
            <li class="topic-info-time">
                <time datetime="{date_format date=$oTopic->getDateAdd() format='c'}" title="{date_format date=$oTopic->getDateAdd() format='j F Y, H:i'}">
                    {date_format date=$oTopic->getDateAdd() format="j F Y, H:i"}
                </time>
            </li>
            <li class="topic-info-favourite">
                <div onclick="return ls.favourite.toggle({$oTopic->getId()},this,'topic');" class="favourite {if $oUserCurrent && $oTopic->getIsFavourite()}active{/if}"><i class="icox icon-bookmark"></i></div>
                <span class="favourite-count" id="fav_count_topic_{$oTopic->getId()}">{$oTopic->getCountFavourite()}</span>
            </li>
            <li class="topic-info-share"><a href="#" class="share" title="{$aLang.topic_share}" onclick="jQuery('#topic_share_{$oTopic->getId()}').slideToggle(); return false;"><i class="icox icon-share"></i></a></li>
        {/if}


			<li id="vote_area_topic_{$oTopic->getId()}" class="vote 
																{if $oVote || ($oUserCurrent && $oTopic->getUserId() == $oUserCurrent->getId()) || strtotime($oTopic->getDateAdd()) < $smarty.now-$oConfig->GetValue('acl.vote.topic.limit_time')}
																	{if $oTopic->getRating() > 0}
																		vote-count-positive
																	{elseif $oTopic->getRating() < 0}
																		vote-count-negative
																	{/if}
																{/if}
																
																{if $oVote} 
																	voted
																	
																	{if $oVote->getDirection() > 0}
																		voted-up
																	{elseif $oVote->getDirection() < 0}
																		voted-down
																	{/if}
																{/if}">
				{if $oVote || ($oUserCurrent && $oTopic->getUserId() == $oUserCurrent->getId()) || strtotime($oTopic->getDateAdd()) < $smarty.now-$oConfig->GetValue('acl.vote.topic.limit_time')}
					{assign var="bVoteInfoShow" value=true}
				{/if}
                <div class="vote-down" onclick="return ls.vote.vote({$oTopic->getId()},this,-1,'topic');"><i class="icox icon-thumbs-down"></i></div>
                <div class="vote-line"></div>
				<div class="vote-up" onclick="return ls.vote.vote({$oTopic->getId()},this,1,'topic');"><i class="icox icon-thumbs-up"></i></div>

				<div class="vote-count {if $bVoteInfoShow}js-infobox-vote-topic{/if}" id="vote_total_topic_{$oTopic->getId()}" title="{$aLang.topic_vote_count}: {$oTopic->getCountVote()}">
                {*if $bVoteInfoShow*}
                    {if $oTopic->getRating() > 0}+{/if}{$oTopic->getRating()}
                {*/if*}
                </div>

                {if $bVoteInfoShow}
					<div id="vote-info-topic-{$oTopic->getId()}" style="display: none;">
						+ {$oTopic->getCountVoteUp()}<br/>
						- {$oTopic->getCountVoteDown()}<br/>
						&nbsp; {$oTopic->getCountVoteAbstain()}<br/>
						{hook run='topic_show_vote_stats' topic=$oTopic}
					</div>
				{/if}

			</li>

		</ul>

		
		{if !$bTopicList}
			{hook run='topic_show_end' topic=$oTopic}
		{/if}
	</footer>
    </div>
</article> <!-- /.topic -->