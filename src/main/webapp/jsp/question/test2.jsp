<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <title>hhh</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="css/stackoverflow.css"/>">
     <link rel="stylesheet" type="text/css" href="<c:url value="css/company.min.css"/>">
</head>
<body class="question-page">
    <div class="container">
        <div id="content">
          <div itemscope="" itemtype="">
			<div id="question-header">
		       	<h1 itemprop="name"><a href="" class="question-hyperlink">Determine if Journey::Path::Pattern matches current page</a></h1>
		    </div>
			<div id="mainbar">
              <div class="question" data-questionid="19456321" id="question">
                  <table>
                      <tbody>
                        <tr>
                          <td class="votecell">
                

                            <div class="vote">
                                <input name="_id_" value="19456321" type="hidden">
                                <a class="vote-up-off" title="This question shows research effort; it is useful and clear">up vote</a>
                                <span class="vote-count-post ">5</span>
                                <a class="vote-down-off" title="This question does not show any research effort; it is unclear or not useful">down vote</a>
    
                                <a class="star-off" href="#" title="This is a favorite question (click again to undo)">favorite</a>
                                <div class="favoritecount"><b>1</b></div>   

                            </div>

                          </td>
            
                            <td class="postcell">
                            <div>
                                <div class="post-text" itemprop="description">

                                    <p>I'm trying to use the method outlined <a href="http://stackoverflow.com/questions/7579625/what-path-is-a-mountable-engine-mounted-on">this post</a> in conjunction with <code>url_for</code> to determine if the current path is in a mounted engine, but I'm having a hard time figuring out how exactly to use <code>Journey::Path::Pattern</code> (which is what is returned by the <code>mounted_path</code> method outlined in the other post).</p>

                                          <pre style="" class="lang-rb prettyprint prettyprinted"><code>
                                          <span class="kwd">class</span>
                                          <span class="pln"> </span><span class="typ">Rails</span>
                                          <span class="pun">::</span>
                                          <span class="typ">Engine</span>
                                          <span class="pln"></span>
                                          <span class="kwd">def</span>
                                          <span class="pln"> </span>
                                          <span class="kwd">self</span><span class="pun">.</span>
                                          <span class="pln">mounted_path
    route </span><span class="pun">=</span><span class="pln"> </span><span class="typ">Rails</span>
    <span class="pun">.</span><span class="pln">application</span><span class="pun">.</span><span class="pln">routes</span><span class="pun">.</span><span class="pln">routes</span><span class="pun">.</span><span class="pln">detect </span><span class="kwd">do</span><span class="pln"> </span><span class="pun">|</span><span class="pln">route</span><span class="pun">|</span><span class="pln">
      route</span><span class="pun">.</span><span class="pln">app </span><span class="pun">==</span><span class="pln"> </span><span class="kwd">self</span><span class="pln">
    </span><span class="kwd">end</span><span class="pln">
    route </span><span class="pun">&amp;&amp;</span><span class="pln"> route</span><span class="pun">.</span><span class="pln">path
  </span><span class="kwd">end</span><span class="pln">
</span><span class="kwd">end</span></code></pre>

<p>There doesn't seem to be too much discussion on it anywhere, aside from <a href="http://www.ruby-doc.org/gems/docs/j/journey-1.0.3/Journey/Path/Pattern.html" rel="nofollow">the official documentation</a>, which wasn't particularly helpful. I'm sure the solution is relatively simple, and the gist of the helper method I'm trying to write is below:</p>

<pre style="" class="lang-rb prettyprint prettyprinted"><code><span class="kwd">def</span><span class="pln"> in_engine</span><span class="pun">?</span><span class="pln"> engine
  current_url</span><span class="pun">.</span><span class="pln">include</span><span class="pun">?(</span><span class="pln">engine</span><span class="pun">.</span><span class="pln">mounted_path</span><span class="pun">)</span><span class="pln">
</span><span class="kwd">end</span></code></pre>

<hr>

<p><strong>Edit:</strong></p>

<p>Some of my engines are mounted as subdomains and some are mounted within the app itself, preventing me from simply checking if the current subdomain is the same as the mounted path, or using <code>path_for</code>.</p>

    </div>
    <div class="post-taglist">
        <a href="/questions/tagged/ruby-on-rails" class="post-tag" title="show questions tagged 'ruby-on-rails'" rel="tag">ruby-on-rails</a> <a href="/questions/tagged/ruby" class="post-tag" title="show questions tagged 'ruby'" rel="tag">ruby</a> <a href="/questions/tagged/rails-routing" class="post-tag" title="show questions tagged 'rails-routing'" rel="tag">rails-routing</a> 
    </div>
    <table class="fw">
    <tbody><tr>
    <td class="vt">
     <div class="post-menu">
         <a href="" title="short permalink to this question" class="short-link" id="link-post-19456321">share</a><span class="lsep">|</span><a href="/posts/19456321/edit" class="suggest-edit-post" title="">improve this question</a>
     </div>        
    </td>
    <td class="post-signature" align="right">

<div class="user-info ">
    <div class="user-action-time">
        
        
        <a href="/posts/19456321/revisions" title="show all edits to this post">edited <span title="2013-10-28 19:04:45Z" class="relativetime">Oct 28 at 19:04</span></a>
        

    </div>
    <div class="user-gravatar32">
        
    </div>
    <div class="user-details">
        <br>
        
    </div>
</div>    </td>
    <td class="post-signature owner">
        
<div class="user-info ">
    <div class="user-action-time">
        
        
            asked <span title="2013-10-18 18:08:48Z" class="relativetime">Oct 18 at 18:08</span>
        

    </div>
    <div class="user-gravatar32">
        <a href="/users/1807403/jonathan-bender"><div class=""><img src="https://www.gravatar.com/avatar/6e0dec30e79d3b6d0f5b9f17ad0afe59?s=32&amp;d=identicon&amp;r=PG" alt="" height="32" width="32"></div></a>
    </div>
    <div class="user-details">
        <a href="/users/1807403/jonathan-bender">Jonathan Bender</a><br>
        <span class="reputation-score" title="reputation score " dir="ltr">291</span><span title="1 silver badges"><span class="badge2"></span><span class="badgecount">1</span></span><span title="8 bronze badges"><span class="badge3"></span><span class="badgecount">8</span></span>
    </div>
</div>
    </td>
    </tr>
    </tbody></table>
</div>
</td>
        </tr>
<tr>
    <td class="votecell"></td>
    <td>
	    <div id="comments-19456321" class="comments" data-localized="true">
		    <table>
			    <tbody data-remaining-comments-count="0" data-addlink-html="" data-addlink-disabled="true">

    <tr id="comment-28964396" class="comment">
        <td>
            <table>
                <tbody>
                    <tr>
                        <td class="comment-score">
                            
                        </td>
                        <td>
                                &nbsp;
                        </td>
                    </tr>
                </tbody>
            </table>   
        </td>
        <td class="comment-text">
            <div style="display: block;" class="comment-body">
	<span class="comment-copy">I think you could do engine.mounted_path =~ url_for which is a regex match alias for the Journey::Path::Pattern</span>
	–&nbsp;
		<a href="/users/531479/cwitty" title="76 reputation" class="comment-user">CWitty</a>
	<span class="comment-date" dir="ltr"><a class="comment-link" href="#comment28964396_19456321"><span title="2013-10-22 16:46:19Z" class="relativetime-clean">Oct 22 at 16:46</span></a></span>
		<span class="edited-yes" title="this comment was edited 1 times"></span>
				</div>

        </td>
    </tr>
    <tr id="comment-28964568" class="comment">
        <td>
            <table>
                <tbody>
                    <tr>
                        <td class="comment-score">
                            
                        </td>
                        <td>
                                &nbsp;
                        </td>
                    </tr>
                </tbody>
            </table>   
        </td>
        <td class="comment-text">
            <div style="display: block;" class="comment-body">
	<span class="comment-copy">I would path_for instead of url_for as well.  The Path would be something like '/backend' the url would be a full url.</span>
	–&nbsp;
		<a href="/users/531479/cwitty" title="76 reputation" class="comment-user">CWitty</a>
	<span class="comment-date" dir="ltr"><a class="comment-link" href="#comment28964568_19456321"><span title="2013-10-22 16:52:30Z" class="relativetime-clean">Oct 22 at 16:52</span></a></span>
				</div>

        </td>
    </tr>
    <tr id="comment-28972981" class="comment">
        <td>
            <table>
                <tbody>
                    <tr>
                        <td class="comment-score">
                            
                        </td>
                        <td>
                                &nbsp;
                        </td>
                    </tr>
                </tbody>
            </table>   
        </td>
        <td class="comment-text">
            <div style="display: block;" class="comment-body">
	<span class="comment-copy">My application is subdomain dependent, so I'm stuck with <code>url_for</code>. Additionally, just doing <code>engine.mounted_path =~ url_for</code> didn't work because of those subdomains.</span>
	–&nbsp;
		<a href="/users/1807403/jonathan-bender" title="291 reputation" class="comment-user owner">Jonathan Bender</a>
	<span class="comment-date" dir="ltr"><a class="comment-link" href="#comment28972981_19456321"><span title="2013-10-22 21:24:25Z" class="relativetime-clean">Oct 22 at 21:24</span></a></span>
				</div>

        </td>
    </tr>
			    </tbody>
		    </table>
	    </div>
			<a id="comments-link-19456321" class="comments-link disabled-link" title="Use comments to ask for more information or suggest improvements. Avoid answering questions in comments."></a>
    </td>
</tr>    
                <tr class="bounty-notification">
            <td colspan="2">
                
<div class="question-status bounty">
    <h2>
This question has an open <a href="/help/bounty">bounty</a> worth     <span class="bounty-award">+100</span>
 reputation from <a href="/users/1807403/jonathan-bender">Jonathan Bender</a> ending <b title="started at 2013-10-29 15:46:26Z
 ending at 2013-11-05 15:46:26Z">in 26 minutes</b>.    </h2>
<p>This question has not received enough attention.</p>
<p>While I've implemented a work-around and have just mounted all the engines as subdomains and/or written specific url checkers for each of my engines, I'd much rather be able to perform a method check, and think that it would be very useful for the community as a whole.</p></div>

            </td>
            </tr>   
    </tbody></table>    
</div>


<div id="answers">

				<a name="tab-top"></a>
				<div id="answers-header">
					<div class="subheader answers-subheader">
						<h2>
								1 Answer
						</h2>
						<div>
							<div id="tabs">
        <a href="/questions/19456321/determine-if-journeypathpattern-matches-current-page?answertab=active#tab-top" title="Answers with the latest activity first">active</a>
        <a href="/questions/19456321/determine-if-journeypathpattern-matches-current-page?answertab=oldest#tab-top" title="Answers in the order they were provided">oldest</a>
        <a class="youarehere" href="/questions/19456321/determine-if-journeypathpattern-matches-current-page?answertab=votes#tab-top" title="Answers with the highest score first">votes</a>
</div>
						</div>
					</div>    
				</div>    




  
<a name="19716738"></a>
<div id="answer-19716738" class="answer" data-answerid="19716738">
    <table>
        <tbody><tr>
            <td class="votecell">
                

<div class="vote">
    <input name="_id_" value="19716738" type="hidden">
    <a class="vote-up-off" title="This answer is useful">up vote</a>
    <span class="vote-count-post ">0</span>
    <a class="vote-down-off" title="This answer is not useful">down vote</a>
    


</div>

            </td>



<td class="answercell">
    <div class="post-text"><p>Not exactly a solution, but maybe a useful lead. </p>

<p>I found your question interesting, so I started delving deep inside rails source... what a scary, yet instructive trip :D</p>

<p>Turns out that Rails' router has a <code>recognize</code> <a href="https://github.com/rails/journey/blob/master/lib/journey/router.rb#L82" rel="nofollow">method</a> that accepts a <code>request</code> as argument, and yields the routes that match the request. </p>

<p>As the routes have an <code>app</code> method you can compare to your engine, and as you can have access to the <code>request</code> object (which takes into account the http method, subdomain, etc), <strong>if you find out how to have direct access to the router instance</strong>, you should be able to do something along the lines of :</p>

<pre style="" class="lang-rb prettyprint prettyprinted"><code><span class="pln">  </span><span class="kwd">def</span><span class="pln"> in_engine</span><span class="pun">?(</span><span class="pln">engine</span><span class="pun">)</span><span class="pln">
    router</span><span class="pun">.</span><span class="pln">recognize</span><span class="pun">(</span><span class="pln">request</span><span class="pun">)</span><span class="pln"> </span><span class="kwd">do</span><span class="pln"> </span><span class="pun">|</span><span class="pln">route</span><span class="pun">,*|</span><span class="pln"> 
      </span><span class="kwd">return</span><span class="pln"> </span><span class="kwd">true</span><span class="pln"> </span><span class="kwd">if</span><span class="pln"> route</span><span class="pun">.</span><span class="pln">app </span><span class="pun">==</span><span class="pln"> engine
    </span><span class="kwd">end</span><span class="pln">
    </span><span class="kwd">false</span><span class="pln">
  </span><span class="kwd">end</span></code></pre>

<p><strong>EDIT</strong></p>

<p>I think i found out, but it's late here in I have no rails app at hand to test this :(</p>

<pre style="" class="lang-rb prettyprint prettyprinted"><code><span class="pln">  </span><span class="kwd">def</span><span class="pln"> in_engine</span><span class="pun">?(</span><span class="pln">engine</span><span class="pun">)</span><span class="pln">
    </span><span class="com"># get all engine routes. </span><span class="pln">
    </span><span class="com"># (maybe possible to do this directly with the engine, dunno)</span><span class="pln">
    engine_routes </span><span class="pun">=</span><span class="pln"> </span><span class="typ">Rails</span><span class="pun">.</span><span class="pln">application</span><span class="pun">.</span><span class="pln">routes</span><span class="pun">.</span><span class="pln">set</span><span class="pun">.</span><span class="pln">select </span><span class="kwd">do</span><span class="pln"> </span><span class="pun">|</span><span class="pln">route</span><span class="pun">|</span><span class="pln"> 
      route</span><span class="pun">.</span><span class="pln">app </span><span class="pun">==</span><span class="pln"> engine
    </span><span class="kwd">end</span><span class="pln">
    </span><span class="pun">!!</span><span class="pln">engine_routes</span><span class="pun">.</span><span class="pln">detect</span><span class="pun">{</span><span class="pln"> </span><span class="pun">|</span><span class="pln">route</span><span class="pun">|</span><span class="pln"> route</span><span class="pun">.</span><span class="pln">matches</span><span class="pun">?(</span><span class="pln">request</span><span class="pun">)</span><span class="pln"> </span><span class="pun">}</span><span class="pln">
  </span><span class="kwd">end</span></code></pre>

<p><strong>EDIT</strong></p>

<p>also, maybe a simpler workaround would be to do this :</p>

<p><strong>in your main app</strong></p>

<pre style="" class="lang-rb prettyprint prettyprinted"><code><span class="pln">  </span><span class="kwd">class</span><span class="pln"> </span><span class="typ">ApplicationController</span><span class="pln"> </span><span class="pun">&lt;</span><span class="pln"> </span><span class="typ">ActionController</span><span class="pun">::</span><span class="typ">Base</span><span class="pln">
    </span><span class="kwd">def</span><span class="pln"> in_engine</span><span class="pun">?(</span><span class="pln">engine</span><span class="pun">)</span><span class="pln">
      </span><span class="kwd">false</span><span class="pln">
    </span><span class="kwd">end</span><span class="pln">
    helper_method </span><span class="pun">:</span><span class="pln">in_engine</span><span class="pun">?</span><span class="pln">
  </span><span class="kwd">end</span></code></pre>

<p><strong>then in your engine's application controller</strong></p>

<pre style="" class="lang-rb prettyprint prettyprinted"><code><span class="pln">  </span><span class="kwd">def</span><span class="pln"> in_engine</span><span class="pun">?(</span><span class="pln">engine</span><span class="pun">)</span><span class="pln">
    engine </span><span class="pun">==</span><span class="pln"> </span><span class="pun">::</span><span class="typ">MyEngine</span><span class="pln">
  </span><span class="kwd">end</span><span class="pln">
  helper_method </span><span class="pun">:</span><span class="pln">in_engine</span><span class="pun">?</span></code></pre>
</div>
    <table class="fw">
    <tbody><tr>
    <td class="vt">











<div class="post-menu"><a href="/a/19716738" title="short permalink to this answer" class="short-link" id="link-post-19716738">share</a><span class="lsep">|</span><a href="/posts/19716738/edit" class="suggest-edit-post" title="">improve this answer</a></div>                    </td>
    <td class="post-signature" align="right">

<div class="user-info ">
    <div class="user-action-time">
        
        
        <a href="/posts/19716738/revisions" title="show all edits to this post">edited <span title="2013-10-31 21:38:06Z" class="relativetime">Oct 31 at 21:38</span></a>
        

    </div>
    <div class="user-gravatar32">
        
    </div>
    <div class="user-details">
        <br>
        
    </div>
</div>    </td>
            


    <td class="post-signature" align="right">   
       

    
<div class="user-info user-hover">
    <div class="user-action-time">
        
        
            answered <span title="2013-10-31 21:14:22Z" class="relativetime">Oct 31 at 21:14</span>
        

    </div>
    <div class="user-gravatar32">
        <a href="/users/729120/m-x"><div class=""><img src="https://www.gravatar.com/avatar/678e2e98efa6d91112be6e62dfd8ab04?s=32&amp;d=identicon&amp;r=PG" alt="" height="32" width="32"></div></a>
    </div>
    <div class="user-details">
        <a href="/users/729120/m-x">m_x</a><br>
        <span class="reputation-score" title="reputation score " dir="ltr">5,017</span><span title="1 gold badges"><span class="badge1"></span><span class="badgecount">1</span></span><span title="8 silver badges"><span class="badge2"></span><span class="badgecount">8</span></span><span title="28 bronze badges"><span class="badge3"></span><span class="badgecount">28</span></span>
    </div>
</div>
    </td>
    </tr>
    </tbody></table>
</td>        </tr>

    <tr>
      <td class="votecell"></td>
      <td>
	    <div id="comments-19716738" class="comments" data-localized="true">
		    <table>
			    <tbody data-remaining-comments-count="0" data-addlink-html="" data-addlink-disabled="true">
			       <tr id="comment-29291272" class="comment">
     		    	   <td>
 			             <table>
 			               <tbody>
  			                  <tr>
  			                      <td class="comment-score"></td>
   			                      <td>&nbsp;</td>
                  			  </tr>
                           </tbody>
                        </table>   
       			      </td>
      			      <td class="comment-text">
   			             <div style="display: block;" class="comment-body">
				          <span class="comment-copy">also, <code>ActionDispatch::Routing::RouteSet</code> has a <a href="" rel="nofollow">recognize_path</a> that you may find interesting</span>–&nbsp;
					      <a href="" title="5017 reputation" class="comment-user">m_x</a>
				          <span class="comment-date" dir="ltr"><a class="comment-link" href="#comment29291272_19716738"><span title="2013-10-31 21:16:29Z" class="relativetime-clean">Oct 31 at 21:16</span></a></span>
				        </div>
   			          </td>
   			      </tr>
			    </tbody>
		    </table>
	    </div>
			<a id="comments-link-19716738" class="comments-link disabled-link" title="Use comments to ask for more information or suggest improvements. Avoid comments like “+1” or “thanks”."></a>
       </td>
     </tr>
    </tbody>
   </table>
</div>
<form id="post-form" action="" method="post" class="post-form">
		<input id="post-id" value="19456321" type="hidden">
			<h2 class="space">Your Answer</h2>
			<div id="post-editor" class="post-editor">
   			 <div style="position: relative;">     
       			 <div class="wmd-container">
        			    <div id="wmd-button-bar" class="wmd-button-bar">
        			            <ul id="wmd-button-row" class="wmd-button-row">
        			                 <li style="left: 0px;" class="wmd-button" id="wmd-bold-button">
        			                 <span style="background-position: 0px -20px;"></span>
        			                 </li>
        			                 <li style="left: 25px;" class="wmd-button" id="wmd-italic-button">
        			                 <span style="background-position: -20px -20px;"></span>
        			                 </li>
        			                 <li style="left: 50px;" class="wmd-spacer" id="wmd-spacer1">
        			                 <span style="background-position: -40px -20px;"></span>
        			                 </li>
        			                 <li style="left: 75px;" class="wmd-button" id="wmd-link-button">
        			                 <span style="background-position: -40px -20px;"></span>
        			                 </li>
        			                 <li style="left: 100px;" class="wmd-button" id="wmd-quote-button">
        			                 <span style="background-position: -60px -20px;"></span>
        			                 </li>
        			                 <li style="left: 125px;" class="wmd-button" id="wmd-code-button">
        			                 <span style="background-position: -80px -20px;"></span>
        			                 </li>
        			                 <li style="left: 150px;" class="wmd-button" id="wmd-image-button">
        			                 <span style="background-position: -100px -20px;"></span>
        			                 </li>
        			                 <li style="left: 175px;" class="wmd-spacer" id="wmd-spacer2">
        			                 <span style="background-position: -120px -20px;"></span>
        			                 </li>
        			                 <li style="left: 200px;" class="wmd-button" id="wmd-olist-button">
        			                 <span style="background-position: -120px -20px;"></span>
        			                 </li>
        			                 <li style="left: 225px;" class="wmd-button" id="wmd-ulist-button">
        			                 <span style="background-position: -140px -20px;"></span>
        			                 </li>
        			                 <li style="left: 250px;" class="wmd-button" id="wmd-heading-button">
        			                 <span style="background-position: -160px -20px;"></span>
        			                 </li>
        			                 <li style="left: 275px;" class="wmd-button" id="wmd-hr-button">
        			                 <span style="background-position: -180px -20px;"></span>
        			                 </li>
        			                 <li style="left: 300px;" class="wmd-spacer" id="wmd-spacer3">
        			                 <span style="background-position: -200px -20px;"></span>
        			                 </li>
        			                 <li style="left: 325px;" class="wmd-button" id="wmd-undo-button">
        			                 <span style="background-position: -200px -20px;"></span>
        			                 </li>
        			                 <li style="left: 350px;" class="wmd-button" id="wmd-redo-button">
        			                 <span style="background-position: -220px -20px;"></span>
        			                 </li>
        			             </ul>
        			       </div>
        			       <textarea id="wmd-input" class="wmd-input" name="post-text" cols="92" rows="15" tabindex="101" data-min-length=""></textarea>
      			    </div>
 			   </div>

   		  	   <div class="fl" style="margin-top: 8px; height:24px;">&nbsp;</div>
      		   <div id="draft-saved" class="draft-saved community-option fl" style="margin-top: 8px; height:24px; display:none;">draft saved</div>

     		  	     <div id="draft-discarded" class="draft-discarded community-option fl" style="margin-top: 8px; height:24px; display:none;">draft discarded</div>

                      <div id="wmd-preview" class="wmd-preview"></div>
     		  	     
      		  	    <div class="edit-block">
       		  	       <input id="fkey" name="fkey" value="fbee9acce358854f04cbf749fd26f49a" type="hidden">
        		  	      <input id="author" name="author" type="text">
      		  	    </div>
   		  	   </div>
							
           
			  <div class="form-submit cbt">
									<input id="submit-button" value="Post Your Answer" tabindex="110" type="submit">
									<a href="#" class="discard-answer dno">discard</a>
   		  	      		  	   <p class="privacy-policy-agreement">
   		  	      		  	   By posting your answer, you agree to the <a href="" target="_blank">privacy policy</a> and <a href="" target="_blank">terms of service</a>.</p>
   		  	      		  	   <input name="legalLinksShown" value="1" type="hidden">								
   		  	   </div>
</form>



<h2 class="bottom-notice">
                            Not the answer you're looking for?							Browse other questions tagged <a href="" class="post-tag" title="show questions tagged 'ruby-on-rails'" rel="tag">ruby-on-rails</a> 
                            <a href="" class="post-tag" title="show questions tagged 'ruby'" rel="tag">ruby</a> 
                            <a href="" class="post-tag" title="" rel="tag">rails-routing</a>  or <a href="">ask your own question</a>.
</h2>
</div>
</div>
</div>
</div>
</div>
</body>
</html>