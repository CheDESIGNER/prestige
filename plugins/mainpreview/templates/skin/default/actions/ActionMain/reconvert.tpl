{include file='header.tpl'}

<form action="" method="POST">
	<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" />
	{$aLang.plugin.mainpreview.submit_reconvert_notice}
	<input type="submit" name="submit_reconvert" value="{$aLang.plugin.mainpreview.submit_reconvert}">
</form>

{include file='footer.tpl'}