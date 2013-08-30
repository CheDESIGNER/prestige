{assign var="noSidebar" value=true}
{include file='header.tpl' noShowSystemMessage=true}

<style>
    .nav-panel {
        display: none;
    }
</style>

<div class="page-error">
    {if $aMsgError[0].title}
        <span class="name-error">{$aMsgError[0].title}</span>
    {/if}

    <p class="oops-error">Oops!</p>
    <p class="text-error">{$aMsgError[0].msg}</p>
    <p class="link-error"><a href="javascript:history.go(-1);">{$aLang.prest_txt_33}</a></p>
</div>

{include file='footer.tpl'}