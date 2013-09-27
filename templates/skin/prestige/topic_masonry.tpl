{assign var="oBlog" value=$oTopic->getBlog()}

<div class="topic-masonry">

{if $oTopic->getPreviewImage()}
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
        {if $bTopicBig}
            <a href="{$oTopic->getUrl()}"><img src="{$oTopic->getPreviewImageWebPath(560crop)}" /></a>
        {else}
            <a href="{$oTopic->getUrl()}"><img src="{$oTopic->getPreviewImageWebPath(350crop)}" /></a>
        {/if}
    </div>

    <div class="wraps">
        <a href="{$oBlog->getUrlFull()}" class="topic-blog">{$oBlog->getTitle()|escape:'html'}</a>

        <div class="topic-infos">
            <div class="topic-info-comments">
                <a href="{$oTopic->getUrl()}#comments" title="{$oTopic->getCountComment()} {$oTopic->getCountComment()|declension:$aLang.comment_declension:'russian'}">
                    <i class="icox icon-comment"></i>{$oTopic->getCountComment()}
                </a>
                {if $oTopic->getCountCommentNew()}<span>+{$oTopic->getCountCommentNew()}</span>{/if}
            </div>

            {hook run='topic_show_info' topic=$oTopic}
        </div>

        <h2 class="topic-title">
            <a href="{$oTopic->getUrl()}">{$oTopic->getTitle()|escape:'html'}</a>
        </h2>
    </div>
{else}
    <div class="wraps">
        <a href="{$oBlog->getUrlFull()}" class="topic-blog">{$oBlog->getTitle()|escape:'html'}</a>

        <div class="topic-infos">
            <div class="topic-info-comments">
                <a href="{$oTopic->getUrl()}#comments" title="{$oTopic->getCountComment()} {$oTopic->getCountComment()|declension:$aLang.comment_declension:'russian'}">
                    <i class="icox icon-comment"></i>{$oTopic->getCountComment()}
                </a>
                {if $oTopic->getCountCommentNew()}<span>+{$oTopic->getCountCommentNew()}</span>{/if}
            </div>

            {hook run='topic_show_info' topic=$oTopic}
        </div>

        <h2 class="topic-title word-wrap">
            <a href="{$oTopic->getUrl()}">{$oTopic->getTitle()|escape:'html'}</a>
        </h2>

        <div class="hide-text"></div>

        <div class="text-short">
            {$oTopic->getTextShort()}
        </div>
    </div>
{/if}


</div>
