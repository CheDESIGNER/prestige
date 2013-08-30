{hook run='profile_sidebar_begin' oUserProfile=$oUserProfile}

<section class="block block-type-profile">
	<div class="profile-photo-wrapper">
		<div class="status {if $oUserProfile->isOnline()}status-online{else}status-offline{/if}">{if $oUserProfile->isOnline()}{$aLang.user_status_online}{else}{$aLang.user_status_offline}{/if}</div>
		<a href="{$oUserProfile->getUserWebPath()}"><img src="{$oUserProfile->getProfileFotoPath()}" alt="photo" class="profile-photo" id="foto-img" /></a>
	</div>
	
	{if $sAction=='settings' and $oUserCurrent and $oUserCurrent->getId() == $oUserProfile->getId()}
		<script type="text/javascript">
			jQuery(function($){
				$('#foto-upload').file({ name:'foto' }).choose(function(e, input) {
					ls.user.uploadFoto(null,input);
				});
			});
		</script>
		
		<p class="upload-photo">
			<a href="#" id="foto-upload" class="link-dotted">{if $oUserCurrent->getProfileFoto()}{$aLang.settings_profile_photo_change}{else}{$aLang.settings_profile_photo_upload}{/if}</a>&nbsp;&nbsp;&nbsp;
			<a href="#" id="foto-remove" class="link-dotted" onclick="return ls.user.removeFoto();" style="{if !$oUserCurrent->getProfileFoto()}display:none;{/if}">{$aLang.settings_profile_foto_delete}</a>
		</p>

		<div class="modal" id="foto-resize">
			<header class="modal-header">
				<h3>{$aLang.uploadimg}</h3>
			</header>
			
			<div class="modal-content">
				<img src="" alt="" id="foto-resize-original-img"><br />
				<button type="submit" class="button button-primary" onclick="return ls.user.resizeFoto();">{$aLang.settings_profile_avatar_resize_apply}</button>
				<button type="submit" class="button" onclick="return ls.user.cancelFoto();">{$aLang.settings_profile_avatar_resize_cancel}</button>
			</div>
		</div>
	{/if}
</section>



{if $oUserCurrent && $oUserCurrent->getId()!=$oUserProfile->getId()}
	<script type="text/javascript">
		jQuery(function($){
			ls.lang.load({lang_load name="profile_user_unfollow,profile_user_follow"});
		});
	</script>

	<section class="block block-type-profile-actions">
		<div class="block-content">
			<ul class="profile-actions" id="profile_actions">
				{include file='actions/ActionProfile/friend_item.tpl' oUserFriend=$oUserProfile->getUserFriend()}
				<li class="link-messeg"><a href="{router page='talk'}add/?talk_users={$oUserProfile->getLogin()}"><i class="icox icon-mail"></i>{$aLang.user_write_prvmsg}</a></li>
				<li class="link-follow">
					<a href="#" onclick="ls.user.followToggle(this, {$oUserProfile->getId()}); return false;" class="{if $oUserProfile->isFollow()}followed{/if}">
                        <i class="icox icon-plus"></i>{if $oUserProfile->isFollow()}{$aLang.profile_user_unfollow}{else}{$aLang.profile_user_follow}{/if}
					</a>
				</li>						
			</ul>
		</div>
	</section>
{/if}	



{if $oUserCurrent && $oUserCurrent->getId() != $oUserProfile->getId()}
	<section class="block block-type-profile-note">
		{if $oUserNote}
			<script type="text/javascript">
				ls.usernote.sText = {json var = $oUserNote->getText()};
			</script>
		{/if}

		<div id="usernote-note" class="profile-note" {if !$oUserNote}style="display: none;"{/if}>
			<p id="usernote-note-text">
				{if $oUserNote}
					{$oUserNote->getText()}
				{/if}
			</p>
			
			<ul class="actions">
				<li><a href="#" onclick="return ls.usernote.showForm();" class="link-dotted">{$aLang.user_note_form_edit}</a></li>
				<li><a href="#" onclick="return ls.usernote.remove({$oUserProfile->getId()});" class="link-dotted">{$aLang.user_note_form_delete}</a></li>
			</ul>
		</div>
		
		<div id="usernote-form" style="display: none;">
			<p><textarea rows="4" cols="20" id="usernote-form-text" class="input-text input-width-full"></textarea></p>
			<button type="submit" onclick="return ls.usernote.save({$oUserProfile->getId()});" class="button button-primary">{$aLang.user_note_form_save}</button>
			<button type="submit" onclick="return ls.usernote.hideForm();" class="button">{$aLang.user_note_form_cancel}</button>
		</div>
		
		<a href="#" onclick="return ls.usernote.showForm();" id="usernote-button-add" class="link-dotted" {if $oUserNote}style="display:none;"{/if}>{$aLang.user_note_add}</a>
	</section>
{/if}

{if $aUsersFriend}
<div class="block block-type-friends">
<h2 class="header-table"><a href="{$oUserProfile->getUserWebPath()}friends/">{$aLang.profile_friends}</a> {$iCountFriendsUser}</h2>

{include file='user_list_avatar.tpl' aUsersList=$aUsersFriend}
</div>
{/if}

{hook run='profile_sidebar_end' oUserProfile=$oUserProfile}
