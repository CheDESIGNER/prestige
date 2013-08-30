{assign var="noSidebar" value=true}
{include file='header.tpl'}

<form action="{router page='registration'}invite/" method="POST" id="invite-form" class="hidden-phone">
    <h2 class="page-header">{$aLang.registration_invite}</h2>

    <div class="wraps">
        <ul class="nav nav-pills nav-pills-tabs">
            <li><a href="{router page='login'}">{$aLang.user_login_submit}</a></li>
            <li class="active"><a href="{router page='registration'}">{$aLang.prest_txt_10}</a></li>
            <li><a href="{router page='login'}reminder/">{$aLang.password_reminder}</a></li>
        </ul>

        <p><label>{$aLang.registration_invite_code}:</label>
        <input type="text" name="invite_code" class="input-text input-width-full" /></p>

        <input type="submit" name="submit_invite" value="{$aLang.registration_invite_check}" class="button" />
    </div>
</form>



{include file='footer.tpl'}