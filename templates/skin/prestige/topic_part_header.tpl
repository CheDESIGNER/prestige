{assign var="oBlog" value=$oTopic->getBlog()}
{assign var="oUser" value=$oTopic->getUser()}
{assign var="oVote" value=$oTopic->getVote()}

<article class="topic topic-type-{$oTopic->getType()} js-topic {if $bTopicList}out-topic{else}in-topic{/if}">

    {if $oTopic->getPreviewImage() && $bTopicList}
        <div class="preview">
            <span class="mark
                        {if $oTopic->getType()=="topic"}
                        topic
                        {elseif $oTopic->getType()=="photoset"}
                        photoset
                        {elseif $oTopic->getType()=="link"}
                        link
                        {elseif $oTopic->getType()=="question"}
                        question
                        {/if}
                        "></span>
            <a href="{$oTopic->getUrl()}"><img src="{$oTopic->getPreviewImageWebPath(285crop)}" /></a>
        </div>
    {/if}

    {if {cfg name='view.bigpreview.type'} == 'off'}
        {*скрыл пока думаем
        {if $oTopic->getPreviewImage()}
            <div class="preview-in">
                <img src="{$oTopic->getPreviewImageWebPath(285crop)}" />
            </div>
        {/if}
        *}
    {else}
        <div class="bigpreview-type">
            <div class="topic-bigpreview">
                <div class="preview">
                    {if $oTopic->getPreviewImage()}
                        <img src="{$oTopic->getPreviewImageWebPath(865crop)}" />
                    {else}
                        <span class="noimage"></span>
                    {/if}
                </div>
                <div class="wraps-topic">
                    <div class="box">
                        <span class="mark
                                    {if $oTopic->getType()=="topic"}
                                    topic
                                    {elseif $oTopic->getType()=="photoset"}
                                    photoset
                                    {elseif $oTopic->getType()=="link"}
                                    link
                                    {elseif $oTopic->getType()=="question"}
                                    question
                                    {/if}
                                    "></span>

                        <div class="topic-time">
                            <time datetime="{date_format date=$oTopic->getDateAdd() format='c'}" title="{date_format date=$oTopic->getDateAdd() format='j F Y, H:i'}">
                                {date_format date=$oTopic->getDateAdd() format="j F Y"}
                            </time>
                        </div>

                        <h1 class="topic-title">
                            {$oTopic->getTitle()|escape:'html'}
                        </h1>

                        <ul class="topic-info">
                            <li class="topic-info-author">
                                <a rel="author" href="{$oUser->getUserWebPath()}">
                                    <img src="{$oUser->getProfileAvatarPath(48)}" class="avatar" />
                                    {$oUser->getLogin()}
                                </a>
                            </li>
                            <li class="dash">-</li>
                            <li class="topic-info-blog"><a href="{$oBlog->getUrlFull()}">{$oBlog->getTitle()|escape:'html'}</a></li>
                            <li class="dash">-</li>
                            <li class="topic-info-com-vie">
                                {hook run='topic_show_info' topic=$oTopic}
                                <div class="topic-info-comments">
                                    <a href="{$oTopic->getUrl()}#comments" title="{$oTopic->getCountComment()} {$oTopic->getCountComment()|declension:$aLang.comment_declension:'russian'}">
                                        <i class="icox icon-comment"></i>{$oTopic->getCountComment()}
                                    </a>
                                    {if $oTopic->getCountCommentNew()}<span>+{$oTopic->getCountCommentNew()}</span>{/if}
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    {/if}

    <div class="wraps {if $bTopicList}out-topic{/if}">

	<header class="topic-header">
        {if {cfg name='view.bigpreview.type'} == 'off'}
            <a href="{$oBlog->getUrlFull()}" class="topic-blog">{$oBlog->getTitle()|escape:'html'}</a>

            {if $bTopicList}
                <time datetime="{date_format date=$oTopic->getDateAdd() format='c'}" title="{date_format date=$oTopic->getDateAdd() format='j F Y, H:i'}">
                    {date_format date=$oTopic->getDateAdd() format="j F Y, H:i"}
                </time>
            {/if}

            {if !$bTopicList}
                <div class="topic-info-comments">
                    <a href="{$oTopic->getUrl()}#comments" title="{$oTopic->getCountComment()} {$oTopic->getCountComment()|declension:$aLang.comment_declension:'russian'}">
                        <i class="icox icon-comment"></i>{$oTopic->getCountComment()}
                    </a>
                    {if $oTopic->getCountCommentNew()}<span>+{$oTopic->getCountCommentNew()}</span>{/if}
                </div>
                {hook run='topic_show_info' topic=$oTopic}
            {/if}

            {if $bTopicList}
                <h2 class="topic-title word-wrap">
                    <a href="{$oTopic->getUrl()}">{$oTopic->getTitle()|escape:'html'}</a>
                </h2>
            {else}
                <h1 class="topic-title word-wrap">
                    {$oTopic->getTitle()|escape:'html'}
                </h1>
            {/if}
        {/if}

		
		<div class="topic-info">
			<ul class="actions">								   
				{if $oUserCurrent and ($oUserCurrent->getId()==$oTopic->getUserId() or $oUserCurrent->isAdministrator() or $oBlog->getUserIsAdministrator() or $oBlog->getUserIsModerator() or $oBlog->getOwnerId()==$oUserCurrent->getId())}
					<li><a href="{cfg name='path.root.web'}/{$oTopic->getType()}/edit/{$oTopic->getId()}/" title="{$aLang.topic_edit}" class="actions-edit"></a></li>
				{/if}
				
				{if $oUserCurrent and ($oUserCurrent->isAdministrator() or $oBlog->getUserIsAdministrator() or $oBlog->getOwnerId()==$oUserCurrent->getId())}
					<li><a href="{router page='topic'}delete/{$oTopic->getId()}/?security_ls_key={$LIVESTREET_SECURITY_KEY}" title="{$aLang.topic_delete}" onclick="return confirm('{$aLang.topic_delete_confirm}');" class="actions-delete"></a></li>
				{/if}
			</ul>
		</div>
	</header>