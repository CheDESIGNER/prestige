<div class="main-list-users">
	{if $bUsersUseOrder}
		<ul class="title-header hidden-phone">
            <li class="cell-number"><span>№</span></li>
            <li class="cell-name"><a href="{$sUsersRootPage}?order=user_login&order_way={if $sUsersOrder=='user_login'}{$sUsersOrderWayNext}{else}{$sUsersOrderWay}{/if}" {if $sUsersOrder=='user_login'}class="{$sUsersOrderWay}"{/if}>{$aLang.user}</a></li>
            <li class="cell-rating"><a href="{$sUsersRootPage}?order=user_rating&order_way={if $sUsersOrder=='user_rating'}{$sUsersOrderWayNext}{else}{$sUsersOrderWay}{/if}" {if $sUsersOrder=='user_rating'}class="{$sUsersOrderWay}"{/if}>{$aLang.user_rating}</a></li>
            {*<li>{$aLang.user_date_last}</li>*}
            <li class="cell-reg"><a href="{$sUsersRootPage}?order=user_date_register&order_way={if $sUsersOrder=='user_date_register'}{$sUsersOrderWayNext}{else}{$sUsersOrderWay}{/if}" {if $sUsersOrder=='user_date_register'}class="{$sUsersOrderWay}"{/if}>{$aLang.user_date_registration}</a></li>
            {*<li class="cell-skill"><a href="{$sUsersRootPage}?order=user_skill&order_way={if $sUsersOrder=='user_skill'}{$sUsersOrderWayNext}{else}{$sUsersOrderWay}{/if}" {if $sUsersOrder=='user_skill'}class="{$sUsersOrderWay}"{/if}>{$aLang.user_skill}</a></li>*}
		</ul>
	{else}
        <ul class="title-header hidden-phone">
            <li class="cell-number"><span>№</span></li>
            <li class="cell-name"><span>{$aLang.user}</span></li>
            <li class="cell-rating"><span>{$aLang.user_rating}</span></li>
            {*<li class="cell-date">{$aLang.user_date_last}</li>*}
            <li class="cell-reg"><span>{$aLang.user_date_registration}</span></li>
            {*<li class="cell-skill">{$aLang.user_skill}</li>*}
		</ul>
	{/if}

    <ul class="list-usr">
		{if $aUsersList}
			{foreach from=$aUsersList item=oUserList}
				{assign var="oSession" value=$oUserList->getSession()}
				{assign var="oUserNote" value=$oUserList->getUserNote()}
            <li class="one-user">
                <ul>
                    <li class="cell-number hidden-phone"><span>{$oUserList->getId()}</span></li>
                    <li class="cell-name">
                        <a href="{$oUserList->getUserWebPath()}"><img src="{$oUserList->getProfileAvatarPath(48)}" class="avatar" /></a>
                        <a href="{$oUserList->getUserWebPath()}">{$oUserList->getLogin()}</a>
                        {if $oUserNote}
                            <i class="icon-comment js-infobox" title="{$oUserNote->getText()|escape:'html'}"></i>
                        {/if}
                    </li>
                    <li class="cell-rating {if $oUserList->getRating() < 0}negative{else}positiv{/if}">{if $oUserList->getRating() > 0}+{/if}{$oUserList->getRating()}</li>
                    {*<li class="cell-date">{if $oSession}{date_format date=$oSession->getDateLast() format="d.m.y, H:i"}{/if}</li>*}
                    <li class="cell-reg hidden-phone">{date_format date=$oUserList->getDateRegister() format="d F Y"}</li>
                    {*<li class="cell-skill">{$oUserList->getSkill()}</li>*}
                </ul>
            </li>
			{/foreach}
		{else}
            <li class="one-user">
                {if $sUserListEmpty}
                    {$sUserListEmpty}
                {else}
                    {$aLang.user_empty}
                {/if}
            </li>
		{/if}
	</ul>
</div>


{include file='paging.tpl' aPaging=$aPaging}