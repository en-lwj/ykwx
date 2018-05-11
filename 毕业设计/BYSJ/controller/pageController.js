'use strict'
class pageController {
    // 首页
    renderIndex(req,res){
        res.render('index.html')
    }
    // 登录页面
    renderLogin(req,res){
        res.render('login.html')
    }
    // 注册页面
    renderRegister(req,res){
        res.render('Register.html')
    }
    // 投稿页面
    renderTougao(req,res){
        res.render('tougao.html')
    }
    // 修改密码页面
    renderChangePwd(req,res){
        res.render('changePwd.html')
    }
    // 文章页面
    renderArticle(req,res){
        // 保存用户行为
        if(req.session.user) require('../model/userActionModel').saveUserRead(req.session.user.id, req.params.id)
        // 增加点击量
        require('../model/articleModel').addClick(req.params.id)
        res.render('article.html')
    }
    // 个人中心
    renderUserPersonal(req,res){
        res.render('userPersonal.html')
    }
    renderSetUserImg(req,res){
        res.render('setUserImg.html')
    }
    renderCategory(req,res){
        res.render('category.html')
    }
    // 活动页面
    renderActivity(req,res){
        res.render('activity.html')
    }
    // 所有消息页面
    renderNewsListALL(req,res){
        res.render('news_list.html')
    }
    // 具体消息页面
    renderNews(req,res){
        // 增加点击量
        require('../model/newsModel').addClick(req.params.id)
        res.render('news.html')
    }
    // 活动获奖页面
    renderPrize(req,res){
        res.render('prize.html')
    }
    // 搜索页面
    renderSearch(req,res){
        res.render('search.html')
    }
    // 后台管理
    renderAdmin(req,res){
        res.render('admin/admin.html')
    }
    // 后台管理-用户权限
    renderUserRole(req,res){
        res.render('admin/user/userRole.html')
    }
    // 后台管理-用户文章
    renderArticleList(req,res){
        res.render('admin/article/articleList.html')
    }
    // 后台管理-文章推荐
    renderRecommendList(req,res){
        res.render('admin/article/recommendList.html')
    }
    // 后台管理-日常稿件审核
    renderCheckCategoryArticle(req,res){
        res.render('admin/article/checkCategoryArticle.html')
    }
    // 后台管理-活动稿件审核
    renderCheckActivityArticle(req,res){
        res.render('admin/article/checkActivityArticle.html')
    }
    // 后台管理-活动奖项评选
    renderAdminArticlePrize(req,res){
        res.render('admin/article/adminArticlePrize.html')
    }
    // 后台管理-活动列表
    renderActivityList(req,res){
        res.render('admin/activity/activityList.html')
    }
    // 后台管理-信息列表
    renderNewsList(req,res){
        res.render('admin/news/newsList.html')
    }
    //后台管理-信息添加
    renderAddNews(req,res){
        res.render('admin/news/addNews.html')
    }
}

module.exports = new pageController()