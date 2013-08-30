			{hook run='content_end'}
		</div> <!-- /content -->

{if $sAction!='login' && $sAction!='registration'} {*Для страницы авторизации/регистрации/напоминания*}
        {include file='sidebar.tpl'}
	</div> <!-- /wrapper -->

	
	<footer id="footer" class="visible-desktop">
        <div class="copy">
            <h6>{$aLang.name_temp}</h6>
            {$aLang.all_copy_1}<br/>
            <br/>
            {$aLang.all_copy_2}<br/>
            {$aLang.all_copy_4}<br/>
            {hook run='copyright'}<br/>

        </div>

        <div class="colum">

            <a class="chelogo" rel="nofollow" target="_blank" href="http://chedesigner.com"></a>

        </div>

        <div class="colum">
            <h6>{$aLang.prest_txt_1}</h6>
            <ul>
                <li><a href="#">Контакты</a></li>
                <li><a href="#">Написать письмо</a></li>
                <li><a href="#">Карта сайта</a></li>
                <li><a href="http://prestige.lstemplates.com/readme/documentation.html" target="_blank">Документация шаблона</a></li>
            </ul>
        </div>
        <div class="colum">
            <h6>{$aLang.prest_txt_2}</h6>
            <ul>
                <li><a href="http://prestige.lstemplates.com/">Топики</a></li>
                <li><a href="http://prestige.lstemplates.com/blogs/">Блоги</a></li>
                <li><a href="http://prestige.lstemplates.com/people/">Люди</a></li>
                <li><a href="http://prestige.lstemplates.com/stream/">Активность</a></li>
            </ul>
        </div>
        <div class="colum fl-r">
            <ul class="soc">
                <li class="fb"><a rel="nofollow" target="_blank" href="#"></a></li>
                <li class="tw"><a rel="nofollow" target="_blank" href="#"></a></li>
                <li class="gp"><a rel="nofollow" target="_blank" href="#"></a></li>
            </ul>
        </div>
		
		{hook run='footer_end'}
	</footer>

    <footer id="footer-mobile" class="hidden-desktop">
        <div class="copy pull-left hidden-phone">
            <ul>
                <li><b>{$aLang.name_temp}</b></li>
                <li>{$aLang.all_copy_3}</li>
                <li>{$aLang.all_copy_5}</li>
            </ul>
        </div>
        <div class="colum pull-left">
            <ul>
                <li><a href="#">Топики</a></li>
                <li><a href="#">Блоги</a></li>
                <li><a href="#">Карта сайта</a></li>
                <li><a href="#">Люди</a></li>
                <li><a href="#">Активность</a></li>
                <li><a href="#">О проекте</a></li>
            </ul>
        </div>

        <div class="copy pull-right hidden-phone">
            <ul>
                <li>{$aLang.all_copy_1}</li>
            </ul>
        </div>

        <div class="copy-mobile visible-phone">
            <a href="{cfg name='path.root.web'}" class="logo-mini"></a>
            <a href="#" class="up-mini"></a>
            <span class="pull-left">
                {$aLang.all_copy_3}<br/>
                {$aLang.all_copy_5}<br/>
            </span>
            <span class="pull-right">
                {hook run='copyright'}<br/>
                {$aLang.all_copy_6}<br/>
            </span>
        </div>

        {hook run='footer_end'}
    </footer>

</div> <!-- /container -->

{include file='toolbar.tpl'}

{hook run='body_end'}


{/if}

</body>
</html>