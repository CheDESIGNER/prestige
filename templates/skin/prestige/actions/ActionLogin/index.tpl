{assign var="noSidebar" value=true}
{include file='header.tpl'}

<script type="text/javascript">
	jQuery(document).ready(function($){
		$('#login-form').bind('submit',function(){
			ls.user.login('login-form');
			return false;
		});
		$('#login-form-submit').attr('disabled',false);
	});
</script>

{hook run='login_begin'}

<form action="{router page='login'}" method="POST" id="login-form" class="hidden-phone">
    <h2 class="page-header">{$aLang.user_authorization}</h2>

	{hook run='form_login_begin'}
    <div class="wraps">
        <ul class="nav nav-pills nav-pills-tabs">
            <li class="active"><a href="{router page='login'}">{$aLang.user_login_submit}</a></li>
            <li><a href="{router page='registration'}">{$aLang.prest_txt_10}</a></li>
            <li><a href="{router page='login'}reminder/">{$aLang.password_reminder}</a></li>
        </ul>

        {if !$oConfig->GetValue('general.reg.invite')}
            <ul class="soc-links">
                <li class="link-fb"><a href="#"></a></li>
                <li class="link-tw"><a href="#"></a></li>
                <li class="link-vk"><a href="#"></a></li>
            </ul>
        {/if}

        <p><label for="login">{$aLang.user_login}</label>
        <input type="text" id="login" name="login" class="input-text style-1 input-width-full" /></p>

        <p><label for="password">{$aLang.user_password}</label>
        <input type="password" id="password" name="password" class="input-text style-1 input-width-full" />
        <small class="validate-error-hide validate-error-login"></small></p>

        <p><label><input type="checkbox" name="remember" checked class="input-checkbox" /> {$aLang.user_login_remember}</label></p>

        {hook run='form_login_end'}

        <button type="submit" name="submit_login" class="button button-primary" id="login-form-submit" disabled="disabled">{$aLang.user_login_submit}</button>
    </div>
</form>


{*Скрыли тут это не надо
{if $oConfig->GetValue('general.reg.invite')}
	<br /><br />
	<form action="{router page='registration'}invite/" method="POST">
		<h2>{$aLang.registration_invite}</h2>

		<p><label>{$aLang.registration_invite_code}<br />
		<input type="text" name="invite_code" /></label></p>
		<input type="submit" name="submit_invite" value="{$aLang.registration_invite_check}" />
	</form>
{/if}
*}


{hook run='login_end'}

{include file='footer.tpl'}