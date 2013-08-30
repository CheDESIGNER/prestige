{include file='header.tpl'}

<form action="" method="POST">
	<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" />
	{$aLang.plugin.mainpreview.submit_convert_notice}
	<input type="submit" name="submit_convert" value="{$aLang.plugin.mainpreview.submit_convert}">
</form>

{include file='footer.tpl'}