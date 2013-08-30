<header id="header-mobile" class="visible-phone">

    <a href="{cfg name='path.root.web'}" class="logo" title="{cfg name='view.name'}"></a>

</header>

<div id="wrapper" class="visible-phone">

    <div id="mobile-usermenu" class="in collapse">
        <div class="wraps">
            {if !$oUserCurrent}
                <ul class="nav-logins">
                    <li class="login-item-mobile active"><a href="#">{$aLang.user_login_submit}</a></li>
                    {if !$oConfig->GetValue('general.reg.invite')}
                        <li class="reg-item-mobile"><a href="#">{$aLang.prest_txt_10}</a></li>
                    {else}
                        <li class="invite-item-mobile"><a href="#">{$aLang.prest_txt_10}</a></li>
                    {/if}
                </ul>


                <script type="text/javascript">
                    jQuery(document).ready(function($){
                        $('#login-form-mobile').bind('submit',function(){
                            ls.user.login('login-form-mobile');
                            return false;
                        });
                        $('#login-form-submit-mobile').attr('disabled',false);
                    });
                </script>

                <form action="{router page='login'}" method="POST" id="login-form-mobile">
                    <input placeholder="{$aLang.user_login}" type="text" id="login" name="login" class="input-text input-width-full" />

                    <input placeholder="{$aLang.user_password}" type="password" id="password" name="password" class="input-text input-width-full" />
                    <small class="validate-error-hide validate-error-login"></small>

                    <button type="submit" name="submit_login" class="button button-primary" id="login-form-submit-mobile" disabled="disabled">{$aLang.user_login_submit}</button>

                    <a class="rem-item-mobile" href="#">{$aLang.password_reminder}</a>
                </form>

                {if $sAction!='registration' || ($sAction=='registration' && $sEvent=='invite')}
                    <script type="text/javascript">
                        jQuery(document).ready(function($){
                            $('#registration-form-mobile').find('input.js-ajax-validate').blur(function(e){
                                var aParams={ };
                                if ($(e.target).attr('name')=='password_confirm') {
                                    aParams['password']=$('#user-password').val();
                                }
                                if ($(e.target).attr('name')=='password') {
                                    aParams['password']=$('#user-password').val();
                                    if ($('#user-password-confirm').val()) {
                                        ls.user.validateRegistrationField('b',$('#user-password-confirm').val(),$('#registration-form-mobile'),{ 'password': $(e.target).val() });
                                    }
                                }
                                ls.user.validateRegistrationField($(e.target).attr('name'),$(e.target).val(),$('#registration-form-mobile'),aParams);
                            });
                            $('#registration-form-mobile').bind('submit',function(){
                                ls.user.registration('registration-form-mobile');
                                return false;
                            });
                            $('#registration-form-submit').attr('disabled',false);
                        });
                    </script>

                    {if !$oConfig->GetValue('general.reg.invite')}
                        <form action="{router page='registration'}" method="post" id="registration-form-mobile">
                            <input placeholder="{$aLang.registration_login}" type="text" name="login" id="registration-login" value="{$_aRequest.login}" class="input-text input-width-full js-ajax-validate" />
                            <i class="icon-ok-green validate-ok-field-login" style="display: none"></i>
                            <small class="validate-error-hide validate-error-field-login"></small>

                            <input placeholder="{$aLang.registration_mail}" type="text" name="mail" id="registration-mail" value="{$_aRequest.mail}" class="input-text input-width-full js-ajax-validate" />
                            <i class="icon-ok-green validate-ok-field-mail" style="display: none"></i>
                            <small class="validate-error-hide validate-error-field-mail"></small>

                            <input placeholder="{$aLang.registration_password}" type="password" name="password" id="user-password" value="" class="input-text input-width-full js-ajax-validate" />
                            <i class="icon-ok-green validate-ok-field-password" style="display: none"></i>
                            <small class="validate-error-hide validate-error-field-password"></small>

                            <input placeholder="{$aLang.registration_password_retry}" type="password" value="" id="user-password-confirm" name="password_confirm" class="input-text input-width-full js-ajax-validate" />
                            <i class="icon-ok-green validate-ok-field-password_confirm" style="display: none"></i>
                            <small class="validate-error-hide validate-error-field-password_confirm"></small>

                            {if $sAction!='registration'}
                                {hookb run="registration_captcha"}
                                    <img src="{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}"
                                         onclick="this.src='{cfg name='path.root.engine_lib'}/external/kcaptcha/index.php?{$_sPhpSessionName}={$_sPhpSessionId}&n='+Math.random();"
                                         class="captcha-image" />
                                    <input type="text" name="captcha" id="captcha" value="" maxlength="3" class="input-text input-width-100 js-ajax-validate" />
                                    <small class="validate-error-hide validate-error-field-captcha"></small>
                                {/hookb}
                            {/if}

                            <div class="clearfix"></div>
                            <button type="submit" name="submit_register" class="button button-primary" id="registration-form-submit" disabled="disabled">{$aLang.registration_submit}</button>
                        </form>
                    {else}
                        <form action="{router page='registration'}invite/" method="POST" id="invite-form-mobile">
                            <input placeholder="{$aLang.registration_invite_code}" type="text" name="invite_code" class="input-text input-width-full" />
                            <input type="submit" name="submit_invite" value="{$aLang.registration_invite_check}" class="button button-primary" />
                        </form>
                    {/if}
                {/if}

                {if $sAction!='login'}
                    <script type="text/javascript">
                        jQuery(document).ready(function($){
                            $('#reminder-form-mobile').bind('submit',function(){
                                ls.user.reminder('reminder-form-mobile');
                                return false;
                            });
                            $('#reminder-form-submit-mobile').attr('disabled',false);
                        });
                    </script>
                {/if}

                <form action="{router page='login'}reminder/" method="POST" id="reminder-form-mobile">
                    <input placeholder="{$aLang.password_reminder_email}" type="text" name="mail" id="reminder-mail" class="input-text input-width-full" />
                    <small class="validate-error-hide validate-error-reminder"></small>

                    <button type="submit" name="submit_reminder" class="button button-primary" id="reminder-form-submit" disabled="disabled">{$aLang.password_reminder_submit}</button>
                </form>
            {/if}
        </div>
    </div>

</div>