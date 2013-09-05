<ul class="item-list">
{foreach from=$oTopics item=oTopic name="cmt"}
    {assign var="oUser" value=$oTopic->getUser()}
    {assign var="oBlog" value=$oTopic->getBlog()}

    <li class="js-title-topic" title="{$oTopic->getText()|strip_tags|trim|truncate:150:'...'|escape:'html'}">

        <a href="{$oUser->getUserWebPath()}" class="author">{$oUser->getLogin()}</a>
        <time datetime="{date_format date=$oTopic->getDate() format='c'}">{date_format date=$oTopic->getDateAdd() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}</time>
        <br/>
        <a href="{$oTopic->getUrl()}" class="name-topic">{$oTopic->getTitle()|escape:'html'}</a>
        <i class="icox icon-comment"></i>
        <span class="img-comment" title="{$oTopic->getCountComment()} {$oTopic->getCountComment()|declension:$aLang.comment_declension:'russian'}">{$oTopic->getCountComment()}</span>

    </li>
{/foreach}
</ul>


<footer>
    <a href="{router page='index'}new/">{$aLang.block_stream_topics_all}</a><a class="fl-r" href="{router page='rss'}new/">RSS</a>
</footer>