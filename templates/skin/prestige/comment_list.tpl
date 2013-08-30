1<div class="comments comment-list">
	{foreach from=$aComments item=oComment}
		{assign var="oUser" value=$oComment->getUser()}
		{assign var="oTopic" value=$oComment->getTarget()}
		{assign var="oBlog" value=$oTopic->getBlog()}
		
		
		
		<div class="comment-path">
			<a href="{$oBlog->getUrlFull()}" class="blog-name">{$oBlog->getTitle()|escape:'html'}</a> &rarr;
			<a href="{$oTopic->getUrl()}">{$oTopic->getTitle()|escape:'html'}</a>
			<a href="{$oTopic->getUrl()}#comments">({$oTopic->getCountComment()})</a>
		</div>
		
		
		<section class="comment">
			<a href="{$oUser->getUserWebPath()}"><img src="{$oUser->getProfileAvatarPath(64)}" alt="avatar" class="comment-avatar" /></a>

            <ul class="comment-info">
                <li class="comment-author">
                    {if $iAuthorId == $oUser->getId()}<span class="comment-topic-author" title="{if $sAuthorNotice}{$sAuthorNotice}{/if}">{$aLang.comment_target_author}</span>{/if}
                    <a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>
                </li>
                <li class="comment-date">
                    <a href="{if $oConfig->GetValue('module.comment.nested_per_page')}{router page='comments'}{else}#comment{/if}{$oComment->getId()}" title="{$aLang.comment_url_notice}">
                        <time datetime="{date_format date=$oComment->getDate() format='c'}">{date_format date=$oComment->getDate() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}</time>
                    </a>
                    -
                </li>

                {if $oUserCurrent and !$bNoCommentFavourites}
                    <li class="comment-favourite">
                        <div onclick="return ls.favourite.toggle({$oComment->getId()},this,'comment');" class="favourite {if $oComment->getIsFavourite()}active{/if}"></div>
                        <span class="favourite-count" id="fav_count_comment_{$oComment->getId()}">{if $oComment->getCountFavourite() > 0}{$oComment->getCountFavourite()}{/if}</span>
                    </li>
                {/if}

            </ul>
					
			<div class="comment-content text">						
				{if $oComment->isBad()}
					{$oComment->getText()}						
				{else}
					{$oComment->getText()}
				{/if}		
			</div>

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
                    <span class="vote-count" id="vote_total_comment_{$oComment->getId()}">{if $oComment->getRating() > 0}+{/if}{$oComment->getRating()}</span>
                </div>
            {/if}

		</section>
	{/foreach}	
</div>


{include file='paging.tpl' aPaging=$aPaging}