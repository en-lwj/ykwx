$(function(){
	'use strict'
	$('head').append(`<style type="text/css">
				.app-header.navbar{
					border-radius: 0 !important;
					min-height: auto;
				}
				.app-header.navbar *{
					min-height: auto;
				}
				.app-header .navbar-brand{
					padding: 10px 15px;
					height: 40px;
				}
				.app-header.navbar-default{
					background-color: #fff;
				}
				.app-header .navbar-nav>li>a{
					padding-top: 10px !important;
					padding-bottom: 10px !important;
				}
				.app-header .navbar-toggle{
					margin-top: 3px;
					margin-bottom: 3px;
				}
				.app-header .nav>li>a{
					padding: 10px;
				}
				@media (min-width: 768px){
					.app-header.navbar-default{
						background-color: transparent;
					}
					.navbar *{
						background-color: transparent !important;
					}
					.navbar{
						border: none;
					}
					.navbar li>a{
						color: #60AA18 !important;
					}
				}
				@media (max-width: 768px){
					.navbar{
						margin: 0;
						padding: 0 15px;
					}
				}
			</style>`)
	$('body').prepend(`<nav class="app-header navbar navbar-default">
				<div class="container">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			              <span class="icon-bar"></span>
			              <span class="icon-bar" style="width: 80%;"></span>
			              <span class="icon-bar"></span>
			            </button>
						<a class="navbar-brand visible-xs" href="#">邑刊文学</a>
					</div>
					<div id="navbar" class="navbar-collapse collapse">
						<ul class="nav navbar-nav">
							<li class="active">
								<a href="#">首页</a>
							</li>
							<li>
								<a href="#">About</a>
							</li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li>
								<a href="#">登录</a>
							</li>
							<li>
								<a href="#">注册</a>
							</li>
						</ul>
					</div>
				</div>
			</nav>
			<div class="container" style="background-color: transparent;">
			<div class="row">
				<div class="col-sm-4 col-md-3">
					<a href="index.html"><img src="img/web_icon.png"/ style="width: 180px;"></a>
				</div>
				<div class="col-sm-4 col-md-6">
					<div style="max-width: 300px;margin: auto;">
						<div class="input-group search">
					        <input type="text" class="form-control" placeholder="Search for...">
					        <span class="input-group-btn">
					        	<button class="btn btn-default" type="button">搜索</button>
					     	</span>
				    	</div>
					</div>
			 	 </div>
			 	 <div class="col-sm-4 col-md-3" style="text-align: right;">
			    	<button class="btn btn-default btn-md send-btn" onclick = "location.href = location.origin+'/tougao.html'">
						<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> 我要投稿
					</button>
				</div>
			</div>
		</div>
		<div class="container category">
			<div class="category-main">
				<a href="#">诗歌</a>
				<a href="#">散文</a>
				<a href="#">小说</a>
				<a href="#">戏剧</a>
				<a href="#">记叙</a>
				<a href="#">说明</a>
				<a href="#">议论</a>
				<a href="#">校闻</a>
			</div>
		</div>`)
	
	$('body').append(`<div class="modal fade" id="loginModal" role="dialog" aria-labelledby="exampleModalLabel">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="exampleModalLabel">登录框</h4>
				      </div>
				      <div class="modal-body">
				        <form>
				          <div class="form-group">
				            <label for="recipient-name" class="control-label">用户名:</label>
				            <input type="text" class="form-control" id="user_account">
				          </div>
				          <div class="form-group">
				            <label for="message-text" class="control-label">密码:</label>
				            <input type="password" class="form-control" id="user_password">
				          </div>
				        </form>
				      </div>
				      <div class="modal-footer">
				      	<button type="button" class="btn btn-primary" onclick="userLogin()">确认</button>
				        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				      </div>
				    </div>
				  </div>
				</div>`)
	
	// 尾部
	$('body').append(`<div class="app-footer" style="text-align: center;padding: 10px 0;">
			<p>本站文摘栏目所收录作品、图片等信息部分来源互联网，目的只是为了系统归纳学习和传递资讯</p>
			<p>所有作品版权归原创作者所有，与本站立场无关，如不慎侵犯了您的权益，请联系我们告知，我们将做删除处理！</p>
		</div>`)
})