{include file='topic_part_header.tpl'}
   
   
<div class="topic-content text">
	{hook run='topic_content_begin' topic=$oTopic bTopicList=$bTopicList}
	
	{if $bTopicList}
        {if {cfg name='view.text.cuttag'} == 'off'}
            {$oTopic->getTextShort()|strip|strip_tags:true}
        {else}
            {$oTopic->getTextShort()}
        {/if}
		{if $oTopic->getTextShort()!=$oTopic->getText()}
			<a href="{$oTopic->getUrl()}#cut" title="{$aLang.topic_read_more}" class="link-more">
				{if $oTopic->getCutText()}
					{$oTopic->getCutText()}
				{else}
					{$aLang.topic_read_more}
				{/if}
			</a>
		{/if}
	{else}
		{$oTopic->getText()}
	{/if}
	
	{hook run='topic_content_end' topic=$oTopic bTopicList=$bTopicList}
</div> 


{include file='topic_part_footer.tpl'}
