<p>
	{if $oTopicEdit and $oTopicEdit->getPreviewImage()}
		<img src="{$oTopicEdit->getPreviewImageWebPath($sPreviewDefaultName)}" /><br/>
		<br />
		<label for="topic_preview_image_delete"><input type="checkbox" id="topic_preview_image_delete" name="topic_preview_image_delete" value="on"> &mdash; {$aLang.plugin.mainpreview.form_preview_image_delete} {if $oTopicEdit->getPreviewImageIsAuto()}({$aLang.plugin.mainpreview.form_preview_image_delete_auto}){/if}</label>
	{/if}<br />
	<label for="topic_preview_image">{$aLang.plugin.mainpreview.form_preview_image}:</label>
	<input class="input-200" type="file" name="topic_preview_image" id="topic_preview_image"><br />
	<span class="note">{$aLang.plugin.mainpreview.form_preview_image_notice}</span>
</p>