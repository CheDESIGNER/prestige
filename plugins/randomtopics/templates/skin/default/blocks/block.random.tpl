{if $aRandomTopics}
    <div class="block randomtopics">
        <header class="block-header sep">
            <h3>{$aLang.plugin.randomtopics.block_random_title}</h3>
        </header>
        <ul>
            {foreach from=$aRandomTopics item=oTopic}
                <li>
                    {if $oTopic->getPreviewImage()}
                        <a href="{$oTopic->getUrl()}" title="{$oTopic->getTitle()}" class="image"><img src="{$oTopic->getPreviewImageWebPath(85crop)}" /></a>
                    {else}
                        <a href="{$oTopic->getUrl()}" title="{$oTopic->getTitle()}" class="image"><span class="noimage"></span></a>
                    {/if}
                    {*<a href="{$oTopic->getUrl()}">{$oTopic->getTitle()}</a>*}
                </li>
            {*<span>{$oTopic->getRating()}</span>*}
            {/foreach}
        </ul>

    </div>
{/if}