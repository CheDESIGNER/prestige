{assign var="noSidebar" value=true}
{include file='header.tpl'}

<script type="text/javascript">
	jQuery(document).ready(function($){
		$('#reminder-form').bind('submit',function(){
			ls.user.reminder('reminder-form');
			return false;
		});
		$('#reminder-form-submit').attr('disabled',false);
	});
</script>

<form action="{router page='login'}reminder/" method="POST" id="reminder-form" class="hidden-phone">
    <h2 class="page-header">{$aLang.password_reminder}</h2>

    <div class="wraps">
        <ul class="nav nav-pills nav-pills-tabs">
            <li><a href="{router page='login'}">{$aLang.user_login_submit}</a></li>
            <li><a href="{router page='registration'}">{$aLang.prest_txt_10}</a></li>
            <li class="active"><a href="{router page='login'}reminder/">{$aLang.password_reminder}</a></li>
        </ul>

        <p><label for="reminder-mail">{$aLang.password_reminder_email}</label>
        <input type="text" name="mail" id="reminder-mail" class="input-text input-width-full" />
        <small class="validate-error-hide validate-error-reminder"></small></p>

        <button type="submit" name="submit_reminder" class="button button-primary" id="reminder-form-submit" disabled="disabled">{$aLang.password_reminder_submit}</button>
    </div>
</form>



{include file='footer.tpl'}