{include file='header.tpl' menu='blog'}

<div class="blog-topic">
    {include file='topic.tpl'}
    {include
        file='comment_tree.tpl'
        iTargetId=$oTopic->getId()
        iAuthorId=$oTopic->getUserId()
        sAuthorNotice=$aLang.topic_author
        sTargetType='topic'
        iCountComment=$oTopic->getCountComment()
        sDateReadLast=$oTopic->getDateRead()
        bAllowNewComment=$oTopic->getForbidComment()
        sNoticeNotAllow=$aLang.topic_comment_notallow
        sNoticeCommentAdd=$aLang.topic_comment_add
        bAllowSubscribe=true
        oSubscribeComment=$oTopic->getSubscribeNewComment()
        aPagingCmt=$aPagingCmt}
</div>

{include file='footer.tpl'}