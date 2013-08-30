{if {cfg name='view.masonry.type'} == 'on'}


    {if count($aTopics)>0}
        {add_block group='toolbar' name='toolbar_topic.tpl' iCountTopic=count($aTopics)}

        <div id="masonry-box" class="list-topic masonry isotope">
            {foreach from=$aTopics item=oTopic name=masonrylist}
                {if $LS->Topic_IsAllowTopicType($oTopic->getType())}
                    {if $smarty.foreach.masonrylist.first && {cfg name='view.masonry.bigtopic'} == 'on' && $sAction == 'index'}
                        <div class="col1 item isotope-item big-topic width2">
                            {assign var="sTopicTemplateName" value="topic_masonry.tpl"}
                            {include file=$sTopicTemplateName bTopicList=true bTopicBig=true}
                        </div>
                    {else}
                        <div class="col1 item isotope-item">
                            {assign var="sTopicTemplateName" value="topic_masonry.tpl"}
                            {include file=$sTopicTemplateName bTopicList=true}
                        </div>
                    {/if}
                {/if}
            {/foreach}
        </div>

        {include file='paging.tpl' aPaging=$aPaging}
    {else}
        {$aLang.blog_no_topic}
    {/if}

{elseif {cfg name='view.bigpreview.type'} == 'on'}

    {if count($aTopics)>0}
        {add_block group='toolbar' name='toolbar_topic.tpl' iCountTopic=count($aTopics)}

        <div id="bigpreview-box" class="list-topic bigpreview-type">
            {foreach from=$aTopics item=oTopic name=bigpreviewlist}
                {if $LS->Topic_IsAllowTopicType($oTopic->getType())}
                    {assign var="sTopicTemplateName" value="topic_bigpreview.tpl"}
                    {include file=$sTopicTemplateName bTopicList=true}
                {/if}
            {/foreach}
        </div>

        {include file='paging.tpl' aPaging=$aPaging}
    {else}
        {$aLang.blog_no_topic}
    {/if}

{else}


    {if count($aTopics)>0}
        {add_block group='toolbar' name='toolbar_topic.tpl' iCountTopic=count($aTopics)}

        <div class="list-topic">
            {foreach from=$aTopics item=oTopic}
                    {if $LS->Topic_IsAllowTopicType($oTopic->getType())}
                {assign var="sTopicTemplateName" value="topic_`$oTopic->getType()`.tpl"}
            {include file=$sTopicTemplateName bTopicList=true}
            {/if}
                {/foreach}
        </div>

        {include file='paging.tpl' aPaging=$aPaging}
    {else}
        {$aLang.blog_no_topic}
    {/if}


{/if}