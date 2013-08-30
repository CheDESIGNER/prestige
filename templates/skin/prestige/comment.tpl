{assign var="oUser" value=$oComment->getUser()}
{assign var="oVote" value=$oComment->getVote()}


<section id="comment_id_{$oComment->getId()}" class="comment
														{if $oComment->isBad()}
															comment-bad
														{/if}

														{if $oComment->getDelete()}
															comment-deleted
														{elseif $oUserCurrent and $oComment->getUserId() == $oUserCurrent->getId()} 
															comment-self
														{elseif $sDateReadLast <= $oComment->getDate()} 
															comment-new
														{/if}
														{if $iAuthorId == $oUser->getId()}
														    comment-author
														{/if}
														">
	{if !$oComment->getDelete() or $bOneComment or ($oUserCurrent and $oUserCurrent->isAdministrator())}
		<a name="comment{$oComment->getId()}"></a>
		
		
		<a href="{$oUser->getUserWebPath()}"><img src="{$oUser->getProfileAvatarPath(64)}" alt="avatar" class="comment-avatar" /></a>

		
		<ul class="comment-info">
			<li class="comment-author">
				{if $iAuthorId == $oUser->getId()}<span class="comment-topic-author" title="{if $sAuthorNotice}{$sAuthorNotice}{/if}">{$aLang.comment_target_author}</span>{/if}
				<a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>
			</li>
            {if $oUserCurrent and !$bNoCommentFavourites}
                <li class="comment-favourite">
                    <div onclick="return ls.favourite.toggle({$oComment->getId()},this,'comment');" class="favourite {if $oComment->getIsFavourite()}active{/if}"><i class="icox icon-bookmark"></i></div>
                    <span class="favourite-count" id="fav_count_comment_{$oComment->getId()}">{if $oComment->getCountFavourite() > 0}{$oComment->getCountFavourite()}{/if}</span>
                </li>
            {/if}

            {if $oComment->getPid()}
                <li class="goto-comment-parent"><a href="#" onclick="ls.comments.goToParentComment({$oComment->getId()},{$oComment->getPid()}); return false;" title="{$aLang.comment_goto_parent}">↑</a></li>
            {/if}
            <li class="goto-comment-child"><a href="#" title="{$aLang.comment_goto_child}">↓</a></li>

			<li class="comment-date">
				<a href="{if $oConfig->GetValue('module.comment.nested_per_page')}{router page='comments'}{else}#comment{/if}{$oComment->getId()}" title="{$aLang.comment_url_notice}">
					<time datetime="{date_format date=$oComment->getDate() format='c'}">{date_format date=$oComment->getDate() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}</time>
				</a>
			</li>
		</ul>
		
		
		<div id="comment_content_id_{$oComment->getId()}" class="comment-content text">
			{$oComment->getText()}
		</div>
			
			
		{if $oUserCurrent}
			<ul class="comment-actions">
				{if !$oComment->getDelete() and !$bAllowNewComment}
					<li><a href="#" onclick="ls.comments.toggleCommentForm({$oComment->getId()}); return false;" class="reply-link link-dotted">{$aLang.comment_answer}</a></li>
				{/if}
					
				{if !$oComment->getDelete() and $oUserCurrent and $oUserCurrent->isAdministrator()}
					<li><a href="#" class="comment-delete link-dotted" onclick="ls.comments.toggle(this,{$oComment->getId()}); return false;">{$aLang.comment_delete}</a></li>
				{/if}
				
				{if $oComment->getDelete() and $oUserCurrent and $oUserCurrent->isAdministrator()}   										
					<li><a href="#" class="comment-repair link-dotted" onclick="ls.comments.toggle(this,{$oComment->getId()}); return false;">{$aLang.comment_repair}</a></li>
				{/if}
				
				{hook run='comment_action' comment=$oComment}
			</ul>
		{/if}

        {if $oComment->getTargetType() != 'talk'}
            <div id="vote_area_comment_{$oComment->getId()}" class="vote
																		{if $oComment->getRating() > 0}
																			vote-count-positive
																		{elseif $oComment->getRating() < 0}
																			vote-count-negative
																		{/if}

																		{if $oVote}
																			voted

																			{if $oVote->getDirection() > 0}
																				voted-up
																			{else}
																				voted-down
																			{/if}
																		{/if}">
                <div class="vote-down" onclick="return ls.vote.vote({$oComment->getId()},this,-1,'comment');"><i class="icox icon-thumbs-down"></i></div>
                <div class="vote-line"></div>
                <div class="vote-up" onclick="return ls.vote.vote({$oComment->getId()},this,1,'comment');"><i class="icox icon-thumbs-up"></i></div>
                <span class="vote-count" id="vote_total_comment_{$oComment->getId()}">{if $oComment->getRating() > 0}+{/if}{$oComment->getRating()}</span>
            </div>
        {/if}
	{else}
        <a href="{$oUser->getUserWebPath()}"><img src="{$oUser->getProfileAvatarPath(64)}" alt="avatar" class="comment-avatar" /></a>

        <div class="comment-content text">
            {$aLang.comment_was_delete}
        </div>
	{/if}	
</section>