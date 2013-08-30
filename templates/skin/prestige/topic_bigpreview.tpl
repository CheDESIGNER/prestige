{assign var="oBlog" value=$oTopic->getBlog()}
{assign var="oUser" value=$oTopic->getUser()}

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

            <h2 class="topic-title">
                <a href="{$oTopic->getUrl()}">{$oTopic->getTitle()|escape:'html'}</a>
            </h2>

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
