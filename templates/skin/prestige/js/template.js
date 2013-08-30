jQuery(document).ready(function($){
	// Хук начала инициализации javascript-составляющих шаблона
	ls.hook.run('ls_template_init_start',[],window);
	
	$('html').removeClass('no-js');
	
	// Определение браузера
	if ($.browser.opera) {
		$('body').addClass('opera opera' + parseInt($.browser.version));
	}
	if ($.browser.mozilla) {
		$('body').addClass('mozilla mozilla' + parseInt($.browser.version));
	}
	if ($.browser.webkit) {
		$('body').addClass('webkit webkit' + parseInt($.browser.version));
	}
	if ($.browser.msie) {
		$('body').addClass('ie');
		if (parseInt($.browser.version) > 8) {
			$('body').addClass('ie' + parseInt($.browser.version));
		}
	}
	 
	// Всплывающие окна
	$('#window_login_form').jqm();
	$('#blog_delete_form').jqm({trigger: '#blog_delete_show'});
	$('#add_friend_form').jqm({trigger: '#add_friend_show'});
	$('#window_upload_img').jqm();
	$('#userfield_form').jqm();
	$('#favourite-form-tags').jqm();
	$('#modal_write').jqm({trigger: '#modal_write_show'});
	$('#foto-resize').jqm({modal: true});
	$('#avatar-resize').jqm({modal: true});
	$('#userfield_form').jqm({toTop: true}); 
	$('#photoset-upload-form').jqm({trigger: '#photoset-start-upload'});

	$('.js-registration-form-show').click(function(){
		if (ls.blocks.switchTab('registration','popup-login')) {
			$('#window_login_form').jqmShow();
		} else {
			window.location=aRouter.registration;
		}
		return false;
	});

	$('.js-login-form-show').click(function(){
		if (ls.blocks.switchTab('login','popup-login')) {
			$('#window_login_form').jqmShow();
		} else {
			window.location=aRouter.login;
		}
		return false;
	});
	
	// Datepicker
	 /**
	  * TODO: навесить языки на datepicker
	  */
	$('.date-picker').datepicker({ 
		dateFormat: 'dd.mm.yy',
		dayNamesMin: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
		monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
		firstDay: 1
	});
	
	
	// Поиск по тегам
	$('.js-tag-search-form').submit(function(){
		window.location = aRouter['tag']+encodeURIComponent($(this).find('.js-tag-search').val())+'/';
		return false;
	});
	
	
	// Автокомплит
	ls.autocomplete.add($(".autocomplete-tags-sep"), aRouter['ajax']+'autocompleter/tag/', true);
	ls.autocomplete.add($(".autocomplete-tags"), aRouter['ajax']+'autocompleter/tag/', false);
	ls.autocomplete.add($(".autocomplete-users-sep"), aRouter['ajax']+'autocompleter/user/', true);
	ls.autocomplete.add($(".autocomplete-users"), aRouter['ajax']+'autocompleter/user/', false);

	
	// Скролл
	$(window)._scrollable();

	
	// Тул-бар топиков
	ls.toolbar.topic.init();
	// Кнопка "UP"
	ls.toolbar.up.init();

	
	// Всплывающие сообщения
	if (ls.registry.get('block_stream_show_tip')) {
		$('.js-title-comment, .js-title-topic').poshytip({
			className: 'infobox-yellow',
			alignTo: 'target',
			alignX: 'left',
			alignY: 'center',
			offsetX: 10,
			liveEvents: true,
			showTimeout: 1000
		});
	}

	$('.js-title-talk').poshytip({
		className: 'infobox-yellow',
		alignTo: 'target',
		alignX: 'left',
		alignY: 'center',
		offsetX: 10,
		liveEvents: true,
		showTimeout: 500
	});

	$('.js-infobox-vote-topic').poshytip({
		content: function() {
			var id = $(this).attr('id').replace('vote_total_topic_','vote-info-topic-');
			return $('#'+id).html();
		},
		className: 'infobox-standart',
		alignTo: 'target',
		alignX: 'center',
		alignY: 'top',
		offsetX: 2,
		liveEvents: true,
		showTimeout: 100
	});
	
	$('.js-tip-help').poshytip({
		className: 'infobox-standart',
		alignTo: 'target',
		alignX: 'right',
		alignY: 'center',
		offsetX: 5,
		liveEvents: true,
		showTimeout: 500
	});

	$('.js-infobox').poshytip({
		className: 'infobox-standart',
		liveEvents: true,
		showTimeout: 300
	});

	// подсветка кода
	prettyPrint();
	
	// эмуляция border-sizing в IE
	var inputs = $('input.input-text, textarea');
	ls.ie.bordersizing(inputs);
	
	// эмуляция placeholder'ов в IE
	inputs.placeholder();

	// инизиализация блоков
	ls.blocks.init('stream',{group_items: true, group_min: 3});
	ls.blocks.init('blogs');
	ls.blocks.initSwitch('tags');
	ls.blocks.initSwitch('upload-img');
	ls.blocks.initSwitch('favourite-topic-tags');
	ls.blocks.initSwitch('popup-login');

	// комментарии
	ls.comments.options.folding = false;
	ls.comments.init();

	// избранное
	ls.hook.add('ls_favourite_toggle_after',function(idTarget,objFavourite,type,params,result){
		$('#fav_count_'+type+'_'+idTarget).text((result.iCount>0) ? result.iCount : '');
	});

	/****************
	 * TALK
	 */

	// Добавляем или удаляем друга из списка получателей
	$('#friends input:checkbox').change(function(){
		ls.talk.toggleRecipient($('#'+$(this).attr('id')+'_label').text(), $(this).attr('checked'));
	});

	// Добавляем всех друзей в список получателей
	$('#friend_check_all').click(function(){
		$('#friends input:checkbox').each(function(index, item){
			ls.talk.toggleRecipient($('#'+$(item).attr('id')+'_label').text(), true);
			$(item).attr('checked', true);
		});
		return false;
	});

	// Удаляем всех друзей из списка получателей
	$('#friend_uncheck_all').click(function(){
		$('#friends input:checkbox').each(function(index, item){
			ls.talk.toggleRecipient($('#'+$(item).attr('id')+'_label').text(), false);
			$(item).attr('checked', false);
		});
		return false;
	});

	// Удаляем пользователя из черного списка
	$("#black_list_block").delegate("a.delete", "click", function(){
		ls.talk.removeFromBlackList(this);
		return false;
	});

	// Удаляем пользователя из переписки
	$("#speaker_list_block").delegate("a.delete", "click", function(){
		ls.talk.removeFromTalk(this, $('#talk_id').val());
		return false;
	});


	// Help-tags link
	$('.js-tags-help-link').click(function(){
		var target=ls.registry.get('tags-help-target-id');
		if (!target || !$('#'+target).length) {
			return false;
		}
		target=$('#'+target);
		if ($(this).data('insert')) {
			var s=$(this).data('insert');
		} else {
			var s=$(this).text();
		}
		$.markItUp({target: target, replaceWith: s});
		return false;
	});
	
	
	// Фикс бага с z-index у встроенных видео
	$("iframe").each(function(){
		var ifr_source = $(this).attr('src');

		if(ifr_source) {
			var wmode = "wmode=opaque";
				
			if (ifr_source.indexOf('?') != -1) 
				$(this).attr('src',ifr_source+'&'+wmode);
			else 
				$(this).attr('src',ifr_source+'?'+wmode);
		}
	});

	
	// Хук конца инициализации javascript-составляющих шаблона
	ls.hook.run('ls_template_init_end',[],window);

    // Скрывает все дропы
    $('html').click(function() {
        $('#creat-nav-sub').hide();
        $('#creat-nav').parent().removeClass('active');

        $('#popular-nav-sub').hide();
        $('#popular-nav').parent().removeClass('active');

        if ($("#tag-nav-sub").hasClass("focus") == false) {
            $('#tag-nav-sub').hide();
            $('#tag-nav').parent().removeClass('active');
        }

        $('#blogs-nav-sub').hide();
        $('#blogs-nav').parent().removeClass('active');

        $('#drop-user-menu').hide();
        $('#drop-user-menu-caret').removeClass('active');
    });

    // Для инпута поиска тегов
    $('.js-tag-search').focusin(function () {
        $('#tag-nav-sub').addClass('focus');
    });
    $('.js-tag-search').focusout(function () {
        $('#tag-nav-sub').removeClass('focus');
    });

    // Дроп меню юзера
    $('#drop-user-menu-link').click(function(event) {
        event.stopPropagation();
        if ($("#drop-user-menu-caret").hasClass("active") == true) {
            $('#drop-user-menu').hide();
            $('#drop-user-menu-caret').removeClass('active');
        } else {
            $('#drop-user-menu').show();
            $('#drop-user-menu-caret').addClass('active');
        }
    });

    // Дроп меню юзера мобильный
    $('#drop-user-menu-link-mobile').click(function(event) {
        event.stopPropagation();
        if ($("#drop-user-menu-caret-mobile").hasClass("active") == true) {
            $('#drop-user-menu-mobile').hide();
            $('#drop-user-menu-caret-mobile').removeClass('active');
        } else {
            $('#drop-user-menu-mobile').show();
            $('#drop-user-menu-caret-mobile').addClass('active');
        }
    });

    // Дроп меню создать
    $('#creat-nav').click(function(event) {
        event.stopPropagation();
        if ($("li.creat-nav").hasClass("active") == true) {
            $('#creat-nav-sub').hide();
            $('#creat-nav').parent().removeClass('active');
        } else {
            $('#creat-nav-sub').show();
            $('#creat-nav').parent().addClass('active');

            $('#popular-nav-sub').hide();
            $('#popular-nav').parent().removeClass('active');

            $('#tag-nav-sub').hide();
            $('#tag-nav').parent().removeClass('active');

            $('#blogs-nav-sub').hide();
            $('#blogs-nav').parent().removeClass('active');
        }
    });

    // Дроп меню блоги
    $('#blogs-nav').click(function(event) {
        event.stopPropagation();
        if ($("li.blogs-nav").hasClass("active") == true) {
            $('#blogs-nav-sub').hide();
            $('#blogs-nav').parent().removeClass('active');
        } else {
            $('#blogs-nav-sub').show();
            $('#blogs-nav').parent().addClass('active');

            $('#popular-nav-sub').hide();
            $('#popular-nav').parent().removeClass('active');

            $('#tag-nav-sub').hide();
            $('#tag-nav').parent().removeClass('active');

            $('#creat-nav-sub').hide();
            $('#creat-nav').parent().removeClass('active');
        }
    });

    // Дроп меню популярное
    $('#popular-nav').click(function(event) {
        event.stopPropagation();
        if ($("li.popular-nav").hasClass("active") == true) {
            $('#popular-nav-sub').hide();
            $('#popular-nav').parent().removeClass('active');
        } else {
            $('#popular-nav-sub').show();
            $('#popular-nav').parent().addClass('active');

            $('#creat-nav-sub').hide();
            $('#creat-nav').parent().removeClass('active');

            $('#tag-nav-sub').hide();
            $('#tag-nav').parent().removeClass('active');

            $('#blogs-nav-sub').hide();
            $('#blogs-nav').parent().removeClass('active');
        }
    });

    // Дроп меню теги
    $('#tag-nav').click(function(event) {
        event.stopPropagation();
        if ($("li.tag-nav").hasClass("active") == true) {
            $('#tag-nav-sub').hide();
            $('#tag-nav').parent().removeClass('active');
        } else {
            $('#tag-nav-sub').show();
            $('#tag-nav').parent().addClass('active');

            $('#creat-nav-sub').hide();
            $('#creat-nav').parent().removeClass('active');

            $('#popular-nav-sub').hide();
            $('#popular-nav').parent().removeClass('active');

            $('#blogs-nav-sub').hide();
            $('#blogs-nav').parent().removeClass('active');
        }
    });

    // Меню переключение в списке блогов
    $('.link-desc').each(function(){
        $(this).on('click',function(){
            $(this).parent().parent('li.one-blog').find('div.admin-blog').each(function(){
                $(this).hide();
            });
            $(this).parent().parent('li.one-blog').find('div.moder-blog').each(function(){
                $(this).hide();
            });
            $(this).parent().parent('li.one-blog').find('div.user-blog').each(function(){
                $(this).hide();
            });

            $(this).parent().parent('li.one-blog').find('div.desc-info-blog').show();

            $(this).addClass('active');
            $('.link-admin').removeClass('active');
            $('.link-moder').removeClass('active');
            $('.link-read').removeClass('active');
        })
    });
    $('.link-admin').each(function(){
        $(this).on('click',function(){
            $(this).parent().parent('li.one-blog').find('div.desc-info-blog').each(function(){
                $(this).hide();
            });
            $(this).parent().parent('li.one-blog').find('div.moder-blog').each(function(){
                $(this).hide();
            });
            $(this).parent().parent('li.one-blog').find('div.user-blog').each(function(){
                $(this).hide();
            });

            $(this).parent().parent('li.one-blog').find('div.admin-blog').show();

            $(this).addClass('active');
            $('.link-desc').removeClass('active');
            $('.link-moder').removeClass('active');
            $('.link-read').removeClass('active');
        })
    });
    $('.link-moder').each(function(){
        $(this).on('click',function(){
            $(this).parent().parent('li.one-blog').find('div.desc-info-blog').each(function(){
                $(this).hide();
            });
            $(this).parent().parent('li.one-blog').find('div.admin-blog').each(function(){
                $(this).hide();
            });
            $(this).parent().parent('li.one-blog').find('div.user-blog').each(function(){
                $(this).hide();
            });

            $(this).parent().parent('li.one-blog').find('div.moder-blog').show();

            $(this).addClass('active');
            $('.link-desc').removeClass('active');
            $('.link-admin').removeClass('active');
            $('.link-read').removeClass('active');
        })
    });
    $('.link-read').each(function(){
        $(this).on('click',function(){
            $(this).parent().parent('li.one-blog').find('div.desc-info-blog').each(function(){
                $(this).hide();
            });
            $(this).parent().parent('li.one-blog').find('div.admin-blog').each(function(){
                $(this).hide();
            });
            $(this).parent().parent('li.one-blog').find('div.moder-blog').each(function(){
                $(this).hide();
            });

            $(this).parent().parent('li.one-blog').find('div.user-blog').show();

            $(this).addClass('active');
            $('.link-desc').removeClass('active');
            $('.link-admin').removeClass('active');
            $('.link-moder').removeClass('active');
        })
    });

    //красивая строка поиска
    var input_text_nav_panel = $('#input-text-nav-panel');
    var input_button_nav_panel = $('#input-button-nav-panel');

    $(input_text_nav_panel).focus(function(){
        input_button_nav_panel.addClass('active');
    });
    $(input_text_nav_panel).focusout(function(){
        input_button_nav_panel.removeClass('active');
    });

    //определение страницы блога
    var page_blog_title = $('#page-blog-title');
    var blogs_nav = $('#blogs-nav span');

    if (page_blog_title.length > 0) {
        blogs_nav.text(page_blog_title.text());
    }

    //определене страницы популярное
    var popular_page_new = $('#popular-page-new');
    var popular_page_discussed = $('#popular-page-discussed');
    var popular_page_top = $('#popular-page-top');

    var link_new_text = $('#link-new-text');
    var link_discussed_text = $('#link-discussed-text');
    var link_top_text = $('#link-top-text');

    var popular_nav_ico = $('#popular-nav .icox');
    var popular_nav = $('#popular-nav span');

    if (popular_page_new.length > 0) {
        popular_nav.text(link_new_text.text());
        popular_nav_ico.addClass('icon-clock');
        popular_nav_ico.removeClass('icon-heart');
        popular_nav_ico.removeClass('icon-comment');
        popular_nav_ico.removeClass('icon-thumbs-up');
    }
    if (popular_page_discussed.length > 0) {
        popular_nav.text(link_discussed_text.text());
        popular_nav_ico.addClass('icon-comment');
        popular_nav_ico.removeClass('icon-heart');
        popular_nav_ico.removeClass('icon-clock');
        popular_nav_ico.removeClass('icon-thumbs-up');
    }
    if (popular_page_top.length > 0) {
        popular_nav.text(link_top_text.text());
        popular_nav_ico.addClass('icon-thumbs-up');
        popular_nav_ico.removeClass('icon-heart');
        popular_nav_ico.removeClass('icon-clock');
        popular_nav_ico.removeClass('icon-comment');
    }

    //определене страницы популярное для мобильной версии
    var popular_page_new_mobile = $('#popular-page-new-mobile');
    var popular_page_discussed_mobile = $('#popular-page-discussed-mobile');
    var popular_page_top_mobile = $('#popular-page-top-mobile');

    var link_new_text_mobile = $('#link-new-text-mobile');
    var link_discussed_text_mobile = $('#link-discussed-text-mobile');
    var link_top_text_mobile = $('#link-top-text-mobile');

    var link_main_mobile = $('#links-mobile-popular .icox');
    var link_main_mobile_txt = $('#links-mobile-popular span');

    if (popular_page_new_mobile.length > 0) {
        link_main_mobile_txt.text(link_new_text_mobile.text());
        link_main_mobile.addClass('icon-clock');
        link_main_mobile.removeClass('icon-heart');
        link_main_mobile.removeClass('icon-comment');
        link_main_mobile.removeClass('icon-thumbs-up');
    }
    if (popular_page_discussed_mobile.length > 0) {
        link_main_mobile_txt.text(link_discussed_text_mobile.text());
        link_main_mobile.addClass('icon-comment');
        link_main_mobile.removeClass('icon-heart');
        link_main_mobile.removeClass('icon-clock');
        link_main_mobile.removeClass('icon-thumbs-up');
    }
    if (popular_page_top_mobile.length > 0) {
        link_main_mobile_txt.text(link_top_text_mobile.text());
        link_main_mobile.addClass('icon-thumbs-up');
        link_main_mobile.removeClass('icon-heart');
        link_main_mobile.removeClass('icon-clock');
        link_main_mobile.removeClass('icon-comment');
    }

    //шузер для формы логинизации для мобильной версии
    var link_login_mobile = $('.login-item-mobile');
    var link_reg_mobile = $('.reg-item-mobile');
    var link_invite_mobile = $('.invite-item-mobile');
    var link_rem_mobile = $('.rem-item-mobile');

    var login_form_mobile = $('#login-form-mobile');
    var registration_form_mobile = $('#registration-form-mobile');
    var invite_form_mobile = $('#invite-form-mobile');
    var reminder_form_mobile = $('#reminder-form-mobile');

    link_login_mobile.click(function () {
        login_form_mobile.show();
        registration_form_mobile.hide();
        reminder_form_mobile.hide();
        invite_form_mobile.hide();
        $(this).addClass('active');
        link_reg_mobile.removeClass('active');
        link_invite_mobile.removeClass('active');
        link_rem_mobile.removeClass('active');
    });
    link_reg_mobile.click(function () {
        login_form_mobile.hide();
        registration_form_mobile.show();
        reminder_form_mobile.hide();
        invite_form_mobile.hide();
        $(this).addClass('active');
        link_login_mobile.removeClass('active');
        link_invite_mobile.removeClass('active');
        link_rem_mobile.removeClass('active');
    });
    link_invite_mobile.click(function () {
        invite_form_mobile.show();
        login_form_mobile.hide();
        registration_form_mobile.hide();
        reminder_form_mobile.hide();
        $(this).addClass('active');
        link_login_mobile.removeClass('active');
        link_reg_mobile.removeClass('active');
        link_rem_mobile.removeClass('active');
    });
    link_rem_mobile.click(function () {
        login_form_mobile.hide();
        registration_form_mobile.hide();
        reminder_form_mobile.show();
        invite_form_mobile.hide();
        $(this).addClass('active');
        link_login_mobile.removeClass('active');
        link_reg_mobile.removeClass('active');
        link_invite_mobile.removeClass('active');
    });


    var info_block = $('.blog-info-list');
    var shadow_s = $('.shadow');
    var $image_s = $('.one-blog img.avatar');

    $image_s.load(function(){
        // получаем заветные цифры
        var height_s  = $(this).width();
        var width_s = $(this).height();

        info_block.width(width_s);
        info_block.height(height_s);

        shadow_s.height(height_s);

        info_block.css('margin-top', height_s - height_s * 2);
        info_block.css('vertical-align', 13);
    });

});

jQuery(document).scroll(function(){

    var scroll_win = $(this).scrollTop();
    var nav_panel_dubl = $('#nav-panel-dubl');
    var nav_panel = $('#nav-panel');
    var content_w = $('#content').width();
    var window = $(document).width();

    if(scroll_win >= 140) {
        nav_panel.addClass('fixed');
        nav_panel_dubl.show();
        nav_panel.width(1138);
        if (window <= 979){
            nav_panel.width(content_w);
        }
    } else {
        nav_panel_dubl.hide();
        nav_panel.removeClass('fixed');
        nav_panel.css('width', 'auto');
    }

});

jQuery(document).resize(function(){

    var scroll_win = $(this).scrollTop();
    var nav_panel = $('#nav-panel');
    var content_w = $('#content').width();
    var window = $(document).width();

    if(scroll_win >= 140) {
        nav_panel.width(1138);
        if (window <= 979){
            nav_panel.width(content_w);
        }
    } else {
        nav_panel.css('width', 'auto');
    }

});