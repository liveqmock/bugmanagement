<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <title>Ask a Question - Stack Overflow</title>
    <script src="Ask a Question - Stack Overflow_files/ga.js" async="" type="text/javascript"></script><script src="Ask a Question - Stack Overflow_files/quant.js" async="" type="text/javascript"></script><script type="text/javascript" src="Ask a Question - Stack Overflow_files/jquery.js"></script>
    <script src="Ask a Question - Stack Overflow_files/stub.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="Ask a Question - Stack Overflow_files/all.css">
    
    <script type="text/javascript">
        StackExchange.ready(
            function () {
                StackExchange.using("postValidation", function () {
                    StackExchange.postValidation.initOnBlurAndSubmit($('#post-form'), 1, 'question');
                });

                StackExchange.question.initTitleSearch($('#title'), $("#question-suggestions"), 'Stack Overflow');

            }
        );
    </script>

        <script type="text/javascript">
            StackExchange.gps.track("question_ask.visit", { 'inbox_subscription': 1 });
            StackExchange.using("gps", function () {
                var pending = [];
                var send = StackExchange.helpers.DelayedReaction(function () {
                    StackExchange.gps.sendPending();
                }, 3000);
                var alreadySent = { "title_focus": 1 };
                $("#title,#wmd-input,#tagnames").on("focus blur", function (evt) {
                    var what = { title: "title", "wmd-input": "body", "tagnames": "tags" }[this.id] + "_" + evt.type;
                    if (alreadySent[what])
                        return;
                    StackExchange.gps.track("question.action", { action_type: what }, true);
                    alreadySent[what] = 1;
                    send.trigger();
                });
            });
        </script>


    <script type="text/javascript">
        StackExchange.init({"locale":"en","stackAuthUrl":"https://stackauth.com","serverTime":1384000350,"styleCode":true,"enableUserHovercards":true,"site":{"name":"Stack Overflow","description":"Q&A for professional and enthusiast programmers","isNoticesTabEnabled":true,"recaptchaPublicKey":"6LdchgIAAAAAAJwGpIzRQSOFaO0pU6s44Xt8aTwc","enableSocialMediaInSharePopup":true},"user":{"fkey":"f98b248672c65144d6a7de8da48f3efa","isRegistered":true,"userType":3,"userId":2968292,"accountId":3554165,"gravatar":"<div><img src=\"https://www.gravatar.com/avatar/473032678dd6c0afd90b5e2b93d87894?s=32&d=identicon&r=PG&f=1\" alt=\"\" width=\"32\" height=\"32\"></div>","profileUrl":"http://stackoverflow.com/users/2968292/user2968292","notificationsUnviewedCount":1,"inboxUnviewedCount":0}});
        StackExchange.using.setCacheBreakers({"js/prettify-full.en.js":"e0bbd4760e83","js/moderator.en.js":"1a411fd265fe","js/full-anon.en.js":"e469ccee4650","js/full.en.js":"2ce5baed34eb","js/wmd.en.js":"993120c4c16d","js/third-party/jquery.autocomplete.min.js":"e5f01e97f7c3","js/third-party/jquery.autocomplete.min.en.js":"","js/mobile.en.js":"d1d834ef85d2","js/help.en.js":"d3cc74d8a93a","js/tageditor.en.js":"6d51a5f8d7f3","js/tageditornew.en.js":"111b781cf314","js/inline-tag-editing.en.js":"f951bd09dc69","js/revisions.en.js":"33fd38144303","js/review.en.js":"7cf8f6099119","js/tagsuggestions.en.js":"e4e7b952fcc7","js/post-validation.en.js":"c275fe37d674","js/explore-qlist.en.js":"73825bd006fc","js/events.en.js":"130d4e07b47b"});
    </script>
    <script type="text/javascript">
        StackExchange.using("gps", function() {
             StackExchange.gps.init(true);
        });
    </script>
    
<script src="Ask a Question - Stack Overflow_files/full.js" type="text/javascript" async=""></script><script src="Ask a Question - Stack Overflow_files/tageditornew.js" type="text/javascript" async=""></script><script src="Ask a Question - Stack Overflow_files/tagsuggestions.js" type="text/javascript" async=""></script><script src="Ask a Question - Stack Overflow_files/wmd.js" type="text/javascript" async=""></script><script src="Ask a Question - Stack Overflow_files/post-validation.js" type="text/javascript" async=""></script></head>
<body class="ask-page">
    <noscript><div id="noscript-padding"></div></noscript>
    <div id="notify-container"></div>
    <div id="overlay-header"></div>
    <div id="custom-header"></div>
    <div class="container">
        <div id="header">
            <div id="portalLink">
                <a class="genu" onclick="StackExchange.ready(function(){genuwine.click();});return false;">Stack Exchange</a>
                    <a class="unreadCount newNotices" title="you have unread notices">1</a>
            </div>
            <div id="topbar">
                <div id="hlinks">
                    
<span id="hlinks-user">        <span class="profile-triangle">▼</span><a href="" class="profile-link">user2968292</a>&nbsp;<a href=""><span class="reputation-score" title="your reputation; view reputation changes" dir="ltr">1</span></a>
 <span class="lsep">|</span>

</span>
<span id="hlinks-nav"></span>
<span id="hlinks-custom">            <a href="">chat</a>

 <span class="lsep">|</span>
                <a href="">meta</a>

 <span class="lsep">|</span>
            <a href="">about</a>

 <span class="lsep">|</span>
            <a href="">help</a>
</span>
                </div>
                <div id="hsearch">
                    <form id="search" action="/search" method="get" autocomplete="off">
                        <div>
                            <input autocomplete="off" name="q" class="textbox" placeholder="search" tabindex="1" maxlength="240" size="28" type="text">
                        </div>
                    </form>
                </div>
            </div>
            <br class="cbt">
            <div id="hlogo">
                <a href="">
                    Stack Overflow
                </a>
            </div>
            <div id="hmenus">
                <div class="nav mainnavs ">
                    <ul>
                            <li><a id="nav-questions" href="">Questions</a></li>
                            <li><a id="nav-tags" href="">Tags</a></li>
                            <li><a id="nav-users" href="">Users</a></li>
                            <li><a id="nav-badges" href="s">Badges</a></li>
                            <li><a id="nav-unanswered" href="">Unanswered</a></li>
                    </ul>
                </div>
                <div class="nav askquestion">
                    <ul>
                        <li class="youarehere">
                            <a id="nav-askquestion" style="cursor:default">Ask Question</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        



        <div id="content">
            


<div id="mainbar" class="ask-mainbar">

    <form id="post-form" class="post-form" action="/questions/ask/submit" method="post">
        <div id="question-form">
            <div style="position: relative;"> 
                <div class="form-item ask-title">
                    <table class="ask-title-table">
                        <tbody><tr>
                            <td class="ask-title-cell-key">
                                <label for="title">Title</label>
                            </td>
                            <td class="ask-title-cell-value">
                                <input value="What's your programming question? Be specific." disabled="disabled" style="opacity: 1; position: absolute; background-color: white; color: black; width: 610px; height: 16px; line-height: 16px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12.8px; text-align: start; border-left: 1px solid rgb(153, 153, 153); border-right: 1px solid rgb(153, 153, 153); border-style: solid; border-color: rgb(153, 153, 153); border-width: 1px;" autocomplete="off" maxlength="300" tabindex="100" class="actual-edit-overlay" data-min-length="15" data-max-length="150" type="text"><input style="opacity: 0.4; z-index: 1; position: relative;" autocomplete="off" id="title" name="title" maxlength="300" tabindex="100" class="ask-title-field edit-field-overlayed" data-min-length="15" data-max-length="150" type="text">                        
                                <span class="edit-field-overlay">What's your programming question? Be specific.</span>
                            </td>
                        </tr>
                    </tbody></table>
                    <div id="question-suggestions">
                    </div>
                </div>
            </div>



            


    

<script type="text/javascript">
    StackExchange.ready(function() {
        StackExchange.using("tagEditor", function () { StackExchange.tagEditor.ready.done(initFadingHelpText); });
        initTagRenderer("".split(" "), "".split(" "));
         
        prepareEditor({
            heartbeatType: 'ask',
            bindNavPrevention: true,
            postfix: "",
            onDemand: false,
            discardSelector: ".discard-question"
            ,immediatelyShowMarkdownHelp:true
        });
        

    });  
</script>


<div id="post-editor" class="post-editor">

    <div style="position: relative;">     
        <div class="wmd-container">
            <div id="wmd-button-bar" class="wmd-button-bar"><ul class="wmd-button-row" id="wmd-button-row"><li title="Strong &lt;strong&gt; Ctrl+B" id="wmd-bold-button" style="left: 0px;" class="wmd-button"><span style="background-position: 0px 0px;"></span></li><li title="Emphasis &lt;em&gt; Ctrl+I" id="wmd-italic-button" style="left: 25px;" class="wmd-button"><span style="background-position: -20px 0px;"></span></li><li id="wmd-spacer1" class="wmd-spacer wmd-spacer1"></li><li title="Hyperlink &lt;a&gt; Ctrl+L" id="wmd-link-button" style="left: 75px;" class="wmd-button"><span style="background-position: -40px 0px;"></span></li><li title="Blockquote &lt;blockquote&gt; Ctrl+Q" id="wmd-quote-button" style="left: 100px;" class="wmd-button"><span style="background-position: -60px 0px;"></span></li><li title="Code Sample &lt;pre&gt;&lt;code&gt; Ctrl+K" id="wmd-code-button" style="left: 125px;" class="wmd-button"><span style="background-position: -80px 0px;"></span></li><li title="Image &lt;img&gt; Ctrl+G" id="wmd-image-button" style="left: 150px;" class="wmd-button"><span style="background-position: -100px 0px;"></span></li><li id="wmd-spacer2" class="wmd-spacer wmd-spacer2"></li><li title="Numbered List &lt;ol&gt; Ctrl+O" id="wmd-olist-button" style="left: 200px;" class="wmd-button"><span style="background-position: -120px 0px;"></span></li><li title="Bulleted List &lt;ul&gt; Ctrl+U" id="wmd-ulist-button" style="left: 225px;" class="wmd-button"><span style="background-position: -140px 0px;"></span></li><li title="Heading &lt;h1&gt;/&lt;h2&gt; Ctrl+H" id="wmd-heading-button" style="left: 250px;" class="wmd-button"><span style="background-position: -160px 0px;"></span></li><li title="Horizontal Rule &lt;hr&gt; Ctrl+R" id="wmd-hr-button" style="left: 275px;" class="wmd-button"><span style="background-position: -180px 0px;"></span></li><li id="wmd-spacer3" class="wmd-spacer wmd-spacer3"></li><li title="Undo - Ctrl+Z" id="wmd-undo-button" style="left: 325px;" class="wmd-button"><span style="background-position: -200px 0px;"></span></li><li title="Redo - Ctrl+Y" id="wmd-redo-button" style="left: 350px;" class="wmd-button"><span style="background-position: -220px -20px;"></span></li><li title="Markdown Editing Help" style="right: 0px;" id="wmd-help-button" class="wmd-button wmd-help-button active-help"><span style="background-position: -240px 0px;"></span></li><div style="right: -8px; width: 668px; top: 25px;" id="mdhelp" class="mdhelp">
    <ul id="mdhelp-tabs" class="mdhelp-tabs">
        <li data-tab="mdhelp-links" data-buttons="link">Links</li>
        <li data-tab="mdhelp-images" data-buttons="image">Images</li>
        <li data-tab="mdhelp-styles" data-buttons="bold,italic,heading">Styling/Headers</li>
        <li data-tab="mdhelp-lists" data-buttons="olist,ulist">Lists</li>
        <li data-tab="mdhelp-blockquotes" data-buttons="quote">Blockquotes</li>
        <li data-tab="mdhelp-code" data-buttons="code">Code</li>
        <li data-tab="mdhelp-html"> HTML </li>
        <li style="float:right"><a href="http://stackoverflow.com/editing-help" target="_blank">advanced help »</a></li>
    </ul>
    
    <div class="mdhelp-tab" id="mdhelp-links">
            <p>
                In most cases, a plain URL will be recognized as such and automatically linked:
            </p>
            <pre>Visit http://area51.stackexchange.com/ regularly!
Use angle brackets to force linking: Have you seen &lt;http://superuser.com&gt;?
</pre>
            <p>
                To create fancier links, use Markdown:
            </p>
                <pre>Here's [a link](http://www.example.com/)! And a reference-style link to [a panda][1].
References don't have to be [numbers][question].

 [1]: http://notfound.stackexchange.com/
 [question]: http://english.stackexchange.com/questions/11481\</pre>
                <p>You can add tooltips to links:</p>
<pre>Click [here](http://diy.stackexchange.com<span class="spaces">&nbsp;</span>"this text appears when you mouse over")!
This works with [reference links][blog] as well.

 [blog]: http://blog.stackoverflow.com/<span class="spaces">&nbsp;</span>"click here for updates"\</pre>
    </div>

    <div class="mdhelp-tab" id="mdhelp-images">
        <p>Images are exactly like links, but they have an exclamation point in front of them:</p>
        <pre>![a busy cat](http://sstatic.net/stackoverflow/img/error-lolcat-problemz.jpg)
![two muppets][1]

 [1]: http://i.imgur.com/I5DFV.jpg "tooltip"\</pre>
        <p>
            The word in square brackets is the alt text, which gets displayed if the browser
 can't show the image. Be sure to include meaningful alt text for screen-reading
 software.
        </p>
   
    </div>
    <div class="mdhelp-tab" id="mdhelp-styles">
        <div class="col1">
            <p>Be sure to use text styling sparingly; only where it helps readability.</p>
                <pre>*This is italicized*, and so
is _this_.

**This is bold**, just like __this__.

You can ***combine*** them
if you ___really have to___.\</pre>
        
        </div>
        <div class="col2">
            <p>
                To break your text into sections, you can use headers:
            </p>
                <pre>A Large Header
==============

Smaller Subheader
-----------------\</pre>
            <p>
                Use hash marks if you need several levels of headers:</p>
    <pre># Header 1 #
## Header 2 ##
### Header 3 ###\</pre>

            
        </div>

    </div>
    <div class="mdhelp-tab" id="mdhelp-lists">
        <p>Both bulleted and numbered lists are possible:</p>
        <div class="col1">
<pre>-<span class="spaces">&nbsp;</span>Use a minus sign for a bullet
+<span class="spaces">&nbsp;</span>Or plus sign
*<span class="spaces">&nbsp;</span>Or an asterisk

1.<span class="spaces">&nbsp;</span>Numbered lists are easy
2.<span class="spaces">&nbsp;</span>Markdown keeps track of
 the numbers for you
7.<span class="spaces">&nbsp;</span>So this will be item 3.\</pre>
        </div>
        <div class="col2">
<pre>1.<span class="spaces">&nbsp;</span>Lists in a list item:
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;</span>-<span class="spaces">&nbsp;</span>Indented four spaces.
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>*<span class="spaces">&nbsp;</span>indented eight spaces.
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;</span>-<span class="spaces">&nbsp;</span>Four spaces again.
2.<span class="spaces">&nbsp;&nbsp;</span>You can have multiple
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;</span>paragraphs in a list items.
<span class="spaces">&nbsp;</span>
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;</span>Just be sure to indent.\</pre>        
        </div>
    </div>

    <div class="mdhelp-tab" id="mdhelp-blockquotes">
        <div class="col1">
            <pre>&gt; Create a blockquote by
&gt; prepending “&gt;” to each line.
&gt;
&gt; Other formatting also works here, e.g.
&gt;
&gt; 1. Lists or
&gt; 2. Headings:
&gt;
&gt; ## Quoted Heading ##\</pre>
        </div>
        <div class="col2">
                <p>
                    You can even put blockquotes in blockquotes:
                </p>
                <pre>&gt; A standard blockquote is indented
&gt; &gt; A nested blockquote is indented more
&gt; &gt; &gt; &gt; You can nest to any depth.\</pre>
        </div>
    </div>

    <div class="mdhelp-tab" id="mdhelp-code">
        <p>
            To create code blocks or other preformatted text, indent by four spaces:
        </p>
        <pre><span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;</span>This will be displayed in a monospaced font. The first four spaces
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;</span>will be stripped off, but all other whitespace will be preserved.
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;</span>
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;</span>Markdown and HTML are turned off in code blocks:
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;</span>&lt;i&gt;This is not italic&lt;/i&gt;, and [this is not a link](http://example.com)\</pre>
        <p>
            To create not a block, but an inline code span, use backticks:
        </p>
        <pre>The `$` character is just a shortcut for `window.jQuery`.
</pre>
        <p>
            If you want to have a preformatted block within a list, indent by eight spaces:
        </p>
        <pre>1. This is normal text.
2. So is this, but now follows a code block:
<span class="spaces">&nbsp;</span>
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Skip a line and indent eight spaces.
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>That's four spaces for the list
<span class="spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>and four to trigger the code block.\</pre>
    </div>

    <div class="mdhelp-tab" id="mdhelp-html">
        <p>
            If you need to do something that Markdown can't handle, use HTML. Note that <a href="http://meta.stackoverflow.com/questions/1777/what-html-tags-are-allowed" target="_blank">we only support a very strict subset of HTML!</a>
        </p>
        <pre>Strikethrough humor is &lt;strike&gt;funny&lt;/strike&gt;.
</pre>
        <p>
            Markdown is smart enough not to mangle your span-level HTML:
        </p>
        <pre>&lt;b&gt;Markdown works *fine* in here.&lt;/b&gt;
</pre>
        <p>
            Block-level HTML elements have a few restrictions:
        </p>
        <ol>
            <li>They must be separated from surrounding text by blank lines.</li>
            <li>The begin and end tags of the outermost block element must not be indented.</li>
            <li>Markdown can't be used within HTML blocks.</li>
        </ol>
        <br>
        <pre>&lt;pre&gt;
 You can &lt;em&gt;not&lt;/em&gt; use Markdown in here.
&lt;/pre&gt;\</pre>
    </div>

    <div class="cbt"></div>
</div></ul></div>
            <div style="clear: both; height: 23px;"></div><textarea id="wmd-input" class="wmd-input processed" name="post-text" cols="92" rows="15" tabindex="101" data-min-length=""></textarea>
        <div style="margin-right: 0px;" class="grippie"></div></div>
    </div>

    <div class="fl" style="margin-top: 8px; height:24px;">&nbsp;</div>
    <div id="draft-saved" class="draft-saved community-option fl" style="margin-top: 8px; height:24px; display:none;">draft saved</div>

    <div id="draft-discarded" class="draft-discarded community-option fl" style="margin-top: 8px; height:24px; display:none;">draft discarded</div>



    <div id="wmd-preview" class="wmd-preview"></div>
    <div></div>
    <div class="edit-block">
        <input id="fkey" name="fkey" value="f98b248672c65144d6a7de8da48f3efa" type="hidden">
        <input id="author" name="author" type="text">
    <input name="i1l" value="OmC5rV2znSshwEfyKi/NK1vBC8GbrrMcEcu7W7FAYK0=" type="hidden"></div>
</div>
        
            <div style="position: relative;"> 

                <script type="text/javascript">
    StackExchange.using("tagEditor", function () {
        initTagRenderer("".split(" "), "".split(" "));
        StackExchange.tagEditor($("#tagnames"));
    });
</script>	

<div style="position: relative;"> 
<div class="form-item">
    <label>Tags</label>
    <input style="display: none;" id="tagnames" name="tagnames" size="60" tabindex="103" type="text"><div disabled="disabled" style="width: 666px; height: 27px; opacity: 1; position: absolute; background-color: white; color: black; line-height: 27px; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; font-size: 12.8px; text-align: start; border-left: 1px solid rgb(153, 153, 153); border-right: 1px solid rgb(153, 153, 153); border-style: solid; border-color: rgb(153, 153, 153); border-width: 1px;" class="actual-edit-overlay">&nbsp;at least one tag such as (ajax django asp.net-mvc), max 5 tags</div><div style="width: 666px; height: 27px; opacity: 0.4; z-index: 1; position: relative;" class="tag-editor edit-field-overlayed"><span style=""></span><input style="width: 658px;" tabindex="103" type="text"><span></span></div>
    <span class="edit-field-overlay">
at least one tag such as (ajax django asp.net-mvc), max 5 tags    </span>
</div>
</div>

                    <div id="tag-suggestions"></div>
                    <script>
                        StackExchange.using("tagSuggestions", function () {
                            StackExchange.tagSuggestions.init();
                        });
                    </script>


            </div>
        
            <div id="question-only-section">

<div>
    <h2 class="bottom-notice">
        Would you like to have responses to your questions <a id="inbox-notify-c44cebac7178492ca00cfb31e0cea0a3" href="#">sent to you via email</a>?
    </h2>
    <div id="inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-container" style="display: none; ">
        <div>
            <input id="inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-enable" type="checkbox">
            <label for="inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-enable">
                Email me my unread inbox messages
            </label>
            <select id="inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-freq">
                <option selected="selected" value="3">every 3 hours</option>
                <option value="24">daily</option>
                <option value="168">weekly</option>
            </select>
        </div>
        <div>
            Send emails to
            <input id="inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-address" style="width: 300px;" value="liuyanlong0205@163.com">
        </div>
        <div>
            <input class="email-save" value="Save email settings" disabled="disabled" type="button">
        </div>
        <div class="email-confirmation"></div>
        <hr>
    </div>
</div>
<script type="text/javascript">
    StackExchange.ready(function () {
        var inboxSettingsShown = false;
        $("#inbox-notify-c44cebac7178492ca00cfb31e0cea0a3").click(function () {
            var ec = $('#inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-container');
            var btn = ec.find(".email-save");
            var result = ec.find(".email-confirmation");
            
            var enableSave = function () {
                btn.removeAttr("disabled");
                result.html('');
            };

            var disableSave = function () {
                btn.attr("disabled", "disabled");
            };
            disableSave();

            if (ec.is(':visible')) {
                ec.slideUp('fast');
            } else {
                if (!inboxSettingsShown) {
                    StackExchange.gps.track('inbox_settings.show', { location: 2 });
                    inboxSettingsShown = true;
                }
                ec.slideDown('fast');
            }
            
            $("#inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-freq").val(24).on("click focus", function () { $("#inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-enable").prop("checked", true); });
            $("#inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-address").focus().keyup(enableSave);
            $("#inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-enable, #inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-freq").change(enableSave);

            btn.click(function () {
                var req =
                {
                    email: $('#inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-address').val(),
                    fkey: StackExchange.options.user.fkey,
                    optin: $('#inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-enable').is(':checked'),
                    freq: $('#inbox-notify-c44cebac7178492ca00cfb31e0cea0a3-freq').val(),
                    location: 2
                };
                ec.addSpinner();
                $.post(
                    '/accounts/verified-email-set',
                    req,
                    function (data) {
                        ec.removeSpinner();
                        result.html(data.message).fadeIn();

                        if (data.success) disableSave();
                    },
                    'json');
            });

            return false;
        });
    });
</script>

                <div class="form-submit cbt">
                    <input id="submit-button" value="Post Your Question" tabindex="120" type="submit">
                    <a href="#" class="discard-question dno">discard</a>
                    
                </div>
            </div>
        </div>

    </form>
</div>
<div id="sidebar" class="ask-sidebar">
    <div id="scroller-anchor"></div>
    <div style="position: relative; width: 270px;" id="scroller">
        <div style="display: none;" class="module newuser sidebar-help" id="how-to-title">
            <h4>How to Ask</h4>
            <p><b>Is your question about programming?</b></p><p>We prefer questions that can be <i>answered</i>, not just discussed.</p><p>Provide details. Share your research.</p><p>If your question is about this website, <b><a href="http://meta.stackoverflow.com/">ask it on meta</a></b> instead.</p><p class="ar"><a href="http://stackoverflow.com/help">visit the help center »</a><br><a href="http://stackoverflow.com/questions/how-to-ask">asking help »</a></p>
        </div>
        <div class="module newuser sidebar-help" id="how-to-format" style="display: block;">
    <h4>How to Format</h4>    
    <p><span class="dingus">►</span> put returns between paragraphs</p>
    <p><span class="dingus">►</span> for linebreak add 2 spaces at end</p>
    <p><span class="dingus">►</span> <i>_italic_</i> or <b>**bold**</b></p>
    <p><span class="dingus">►</span> indent code by 4 spaces</p>
    <p><span class="dingus">►</span> backtick escapes <code>`like _so_`</code></p>
    <p><span class="dingus">►</span> quote by placing &gt; at start of line</p>
    <p><span class="dingus">►</span> to make links</p>
    <p>&lt;http://foo.com&gt;<br>[foo](http://foo.com)<br>&lt;a href="http://foo.com"&gt;foo&lt;/a&gt;</p>
    <p><span class="dingus">►</span> <a href="http://meta.stackoverflow.com/questions/1777/what-html-tags-are-allowed" target="_blank">basic HTML</a> also allowed</p>
    <p class="ar">
    <a href="http://stackoverflow.com/editing-help" target="_edithelp">formatting help »</a><br>
    <a href="http://stackoverflow.com/questions/how-to-ask">asking help »</a>
    </p>
</div>
        <div class="module newuser sidebar-help" id="how-to-tag" style="display:none">
    <h4>How to Tag</h4>
    <p>A tag is a keyword or label that categorizes your question with other, similar questions.</p>
    <p><span class="dingus">►</span> favor existing popular tags; avoid creating new tags</p>
    <p><span class="dingus">►</span> use common abbreviations</p>
    <p><span class="dingus">►</span> don't include synonyms</p>
    <p><span class="dingus">►</span> combine multiple words into single-words with dashes</p>
    <p><span class="dingus">►</span> maximum of 5 tags, 25 chars per tag</p>
    <p><span class="dingus">►</span> tag characters: [a-z 0-9 + # - .]</p>
    <p><span class="dingus">►</span> delimit tags by space, semicolon, or comma</p>
    <p class="ar"><a href="http://stackoverflow.com/tags">popular tags »</a></p>
</div>    
    </div>
    <script type="text/javascript">
        StackExchange.ready(function () { moveScroller(); });
        StackExchange.using("editor", function () {
                        
            var lengthCheckInterval = setInterval(function () {
                if ($("#wmd-input").val().length >= 220) {
                    clearInterval(lengthCheckInterval);
                    StackExchange.cardiologist.beatASAP();
                }
            }, 3000);
        });
        

    </script>
        
</div>

<br class="cbt">
<div style="display:none" id="prettify-lang"></div>

        </div>
    </div>
    <div id="footer" class="categories">
        <div class="footerwrap">
            <div id="footer-menu">
                <div class="top-footer-links">
                        <a href="http://stackoverflow.com/about">about</a>
                    <a href="http://stackoverflow.com/help">help</a>
                    <a href="http://blog.stackexchange.com/?blb=1">blog</a>
                        <a href="http://chat.stackoverflow.com/">chat</a>
                    <a href="http://data.stackexchange.com/">data</a>
                    <a href="http://stackexchange.com/legal">legal</a>
                    <a href="http://stackexchange.com/legal/privacy-policy">privacy policy</a>
                    <a href="http://stackexchange.com/about/hiring">jobs</a>
                    <a href="http://engine.adzerk.net/r?e=eyJhdiI6NDE0LCJhdCI6MjAsImNtIjo5NTQsImNoIjoxMTc4LCJjciI6Mjc3NiwiZG0iOjQsImZjIjoyODYyLCJmbCI6Mjc1MSwibnciOjIyLCJydiI6MCwicHIiOjExNSwic3QiOjAsInVyIjoiaHR0cDovL3N0YWNrb3ZlcmZsb3cuY29tL2Fib3V0L2NvbnRhY3QiLCJyZSI6MX0&amp;s=hRods5B22XvRBwWIwtIMekcyNF8">advertising info</a>

                    <a onclick='StackExchange.switchMobile("on", "/questions/ask")'>mobile</a>
                    <b><a href="http://stackoverflow.com/contact">contact us</a></b>
                        <b><a href="http://meta.stackoverflow.com/">feedback</a></b>
                    
                </div>
                <div id="footer-sites">
                    <table>
    <tbody><tr>
            <th colspan="3">
                Technology
            </th>
            <th>
                Life / Arts
            </th>
            <th>
                Culture / Recreation
            </th>
            <th>
                Science
            </th>
            <th>
                Other
            </th>
    </tr>
    <tr>
            <td>
                <ol>
                        <li><a href="http://stackoverflow.com/" title="professional and enthusiast programmers">Stack Overflow</a></li>
                        <li><a href="http://serverfault.com/" title="professional system and network administrators">Server Fault</a></li>
                        <li><a href="http://superuser.com/" title="computer enthusiasts and power users">Super User</a></li>
                        <li><a href="http://webapps.stackexchange.com/" title="power users of web applications">Web Applications</a></li>
                        <li><a href="http://askubuntu.com/" title="Ubuntu users and developers">Ask Ubuntu</a></li>
                        <li><a href="http://webmasters.stackexchange.com/" title="pro webmasters">Webmasters</a></li>
                        <li><a href="http://gamedev.stackexchange.com/" title="professional and independent game developers">Game Development</a></li>
                        <li><a href="http://tex.stackexchange.com/" title="users of TeX, LaTeX, ConTeXt, and related typesetting systems">TeX - LaTeX</a></li>
                            </ol></td><td><ol>
                        <li><a href="http://programmers.stackexchange.com/" title="professional programmers interested in conceptual questions about software development">Programmers</a></li>
                        <li><a href="http://unix.stackexchange.com/" title="users of Linux, FreeBSD and other Un*x-like operating systems.">Unix &amp; Linux</a></li>
                        <li><a href="http://apple.stackexchange.com/" title="power users of Apple hardware and software">Ask Different (Apple)</a></li>
                        <li><a href="http://wordpress.stackexchange.com/" title="WordPress developers and administrators">WordPress Answers</a></li>
                        <li><a href="http://gis.stackexchange.com/" title="cartographers, geographers and GIS professionals">Geographic Information Systems</a></li>
                        <li><a href="http://electronics.stackexchange.com/" title="electronics and electrical engineering professionals, students, and enthusiasts">Electrical Engineering</a></li>
                        <li><a href="http://android.stackexchange.com/" title="enthusiasts and power users of the Android operating system">Android Enthusiasts</a></li>
                        <li><a href="http://security.stackexchange.com/" title="Information security professionals">Information Security</a></li>
                            </ol></td><td><ol>
                        <li><a href="http://dba.stackexchange.com/" title="database professionals who wish to improve their database skills and learn from others in the community">Database Administrators</a></li>
                        <li><a href="http://drupal.stackexchange.com/" title="Drupal developers and administrators">Drupal Answers</a></li>
                        <li><a href="http://sharepoint.stackexchange.com/" title="SharePoint enthusiasts">SharePoint</a></li>
                        <li><a href="http://ux.stackexchange.com/" title="user experience researchers and experts">User Experience</a></li>
                        <li><a href="http://mathematica.stackexchange.com/" title="users of Mathematica">Mathematica</a></li>
                    
                        <li>
                            <a href="http://stackexchange.com/sites#technology" class="more">
                                more (14)
                            </a>
                        </li>
                </ol>
            </td>
            <td>
                <ol>
                        <li><a href="http://photo.stackexchange.com/" title="professional, enthusiast and amateur photographers">Photography</a></li>
                        <li><a href="http://scifi.stackexchange.com/" title="science fiction and fantasy enthusiasts">Science Fiction &amp; Fantasy</a></li>
                        <li><a href="http://cooking.stackexchange.com/" title="professional and amateur chefs">Seasoned Advice (cooking)</a></li>
                        <li><a href="http://diy.stackexchange.com/" title="contractors and serious DIYers">Home Improvement</a></li>
                    
                        <li>
                            <a href="http://stackexchange.com/sites#lifearts" class="more">
                                more (13)
                            </a>
                        </li>
                </ol>
            </td>
            <td>
                <ol>
                        <li><a href="http://english.stackexchange.com/" title="linguists, etymologists, and serious English language enthusiasts">English Language &amp; Usage</a></li>
                        <li><a href="http://skeptics.stackexchange.com/" title="scientific skepticism">Skeptics</a></li>
                        <li><a href="http://judaism.stackexchange.com/" title="those who base their lives on Jewish law and tradition and anyone interested in learning more">Mi Yodeya (Judaism)</a></li>
                        <li><a href="http://travel.stackexchange.com/" title="road warriors and seasoned travelers">Travel</a></li>
                        <li><a href="http://christianity.stackexchange.com/" title="committed Christians, experts in Christianity and those interested in learning more">Christianity</a></li>
                        <li><a href="http://gaming.stackexchange.com/" title="passionate videogamers on all platforms">Arqade (gaming)</a></li>
                        <li><a href="http://bicycles.stackexchange.com/" title="people who build and repair bicycles, people who train cycling, or commute on bicycles">Bicycles</a></li>
                        <li><a href="http://rpg.stackexchange.com/" title="gamemasters and players of tabletop, paper-and-pencil role-playing games">Role-playing Games</a></li>
                    
                        <li>
                            <a href="http://stackexchange.com/sites#culturerecreation" class="more">
                                more (21)
                            </a>
                        </li>
                </ol>
            </td>
            <td>
                <ol>
                        <li><a href="http://math.stackexchange.com/" title="people studying math at any level and professionals in related fields">Mathematics</a></li>
                        <li><a href="http://stats.stackexchange.com/" title="statisticians, data analysts, data miners and data visualization experts">Cross Validated (stats)</a></li>
                        <li><a href="http://cstheory.stackexchange.com/" title="theoretical computer scientists and researchers in related fields">Theoretical Computer Science</a></li>
                        <li><a href="http://physics.stackexchange.com/" title="active researchers, academics and students of physics">Physics</a></li>
                        <li><a href="http://mathoverflow.net/" title="professional mathematicians">MathOverflow</a></li>
                    
                        <li>
                            <a href="http://stackexchange.com/sites#science" class="more">
                                more (7)
                            </a>
                        </li>
                </ol>
            </td>
            <td>
                <ol>
                        <li><a href="http://stackapps.com/" title="apps, scripts, and development with the Stack Exchange API">Stack Apps</a></li>
                        <li><a href="http://meta.stackoverflow.com/" title="meta-discussion of the Stack Exchange family of Q&amp;A websites">Meta Stack Overflow</a></li>
                        <li><a href="http://area51.stackexchange.com/" title="proposing new sites in the Stack Exchange network">Area 51</a></li>
                        <li><a href="http://careers.stackoverflow.com/">Stack Overflow Careers</a></li>
                    
                </ol>
            </td>
    </tr>
</tbody></table>
                </div>
            </div>

            <div id="copyright">
                site design / logo © 2013 stack exchange inc; user contributions licensed under <a href="http://creativecommons.org/licenses/by-sa/3.0/" rel="license">cc-wiki</a> 
 with <a href="http://blog.stackoverflow.com/2009/06/attribution-required/" rel="license">attribution required</a>
            </div>
            <div id="footer-flair">
                <a href="http://creativecommons.org/licenses/by-sa/3.0/" class="cc-wiki-link"></a>
            </div>
            <div id="svnrev">
                rev 2013.11.8.1141
            </div>
            
        </div>
    </div>
    <noscript>
        <div id="noscript-warning">Stack Overflow works best with JavaScript enabled<img src="http://pixel.quantserve.com/pixel/p-c1rF4kxgLUzNc.gif" alt="" class="dno"></div>
    </noscript>

    <script type="text/javascript">var _gaq=_gaq||[];_gaq.push(['_setAccount','UA-5620270-1']);
        _gaq.push(['_setCustomVar', 2, 'accountid', '3554165',2]); 
_gaq.push(['_trackPageview']);
    var _qevents = _qevents || [];
    var _comscore = _comscore || [];
    (function () {
        var ssl='https:'==document.location.protocol,
            s=document.getElementsByTagName('script')[0],
            ga=document.createElement('script');
        ga.type='text/javascript';
        ga.async=true;
        ga.src=(ssl?'https://ssl':'http://www')+'.google-analytics.com/ga.js';
        s.parentNode.insertBefore(ga,s);
        var sc=document.createElement('script');
        sc.type='text/javascript';
        sc.async=true;
        sc.src=(ssl?'https://secure':'http://edge')+'.quantserve.com/quant.js';
        s.parentNode.insertBefore(sc, s);
    })();
    _comscore.push({ c1: "2", c2: "17440561" });
    _qevents.push({ qacct: "p-c1rF4kxgLUzNc" });
    </script>        
    

</body></html>