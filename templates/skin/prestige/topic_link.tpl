{include file='topic_part_header.tpl'}


<div class="topic-content text">
	{hook run='topic_content_begin' topic=$oTopic bTopicList=$bTopicList}
	
	{$oTopic->getText()}
    {if $oTopic->getType() == 'link'}
        <a class="link-more" href="{router page='link'}go/{$oTopic->getId()}/" title="{$aLang.topic_link_count_jump}: {$oTopic->getLinkCountJump()}">{$aLang.prest_txt_12}</a>
    {/if}
	{hook run='topic_content_end' topic=$oTopic bTopicList=$bTopicList}
</div> 


{include file='topic_part_footer.tpl'}