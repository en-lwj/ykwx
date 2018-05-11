$(function(){
	window.vm = new Vue({
		el : "#vm",
		data:{
			category : null,
			ranks: null,
			userLike: null,
			recommend_list: [],
			news_list: []
		},
		created: function(){
			sessionStorage.lastPage = location.href
			this.getRecommendList()
			this.getNewsList()			
			this.getUserLike()
			this.getCategoryAll()
			this.getRanks()
		},
		computed: {
			arrangeRanks: function(){
				if(this.ranks == null) return
				ranks = this.ranks
				var data=[]
				ranks.dayRank && (ranks.dayRank.data=ranks.dayRank, ranks.dayRank.title='日阅读量排名') &&data.push(ranks.dayRank)
				ranks.weekRank && (ranks.weekRank.data=ranks.weekRank, ranks.weekRank.title='周阅读量排名') &&data.push(ranks.weekRank)
				ranks.monthRank && (ranks.monthRank.data=ranks.monthRank, ranks.monthRank.title='月阅读量排名') &&data.push(ranks.monthRank)
				ranks.yearRank && (ranks.yearRank.data=ranks.yearRank, ranks.yearRank.title='年阅读量排名') &&data.push(ranks.yearRank)
				ranks.allRank && (ranks.allRank.data=ranks.allRank, ranks.allRank.title='历史阅读量排名') &&data.push(ranks.allRank)
				return ranks
			}
		},
		methods:{
			// 猜你喜欢
			getUserLike: function(){
				$._ajax({
					type: "get",
					url: "/rank/userLike",
					data:{
						count: 6
					}
				}).done(function(res){
					res.status == 200 && (vm.userLike = res.data)
					res.status != 200 && console.log(res)
				})
			},
			// 获取分类信息
			getCategoryAll : function(){
				$._ajax({
					type: "get",
					url: "/category/all"
				}).done(function(res){
					res.status == 200 && (vm.category = res.data)
					res.status != 200 && console.log(res)
				})
			},			
			// 获取所有排名
			getRanks : function(){
				$._ajax({
					type: "get",
					url: "/rank/ranks"
				}).done(function(res){
					res.status == 200 && (vm.ranks = res.data)
					res.status != 200 && console.log(res)
				})
			},
			// 获取推荐列表
			getRecommendList : function(){
				var that = this
				$._ajax({
					type: "get",
					url: "/recommend/list",
					data:{
						count: 4
					}
				}).done(function(res){
					if(res.status == 200){
						(that.recommend_list = res.data)
						that.$nextTick(function(){
							$('.recommend-describe').each(function(i,item){
								var h = 60
								if(item.scrollHeight <= 60) return
								$(item).dotdotdot({
									height: 60,
									truncate: "letter"
								})
							})
						})
						
					}
				})
			},
			// 获取消息列表
			getNewsList : function(){
				var that = this
				$._ajax({
					type: "get",
					url: "/news/list",
					data:{
						count: 6
					}
				}).done(function(res){
					if(res.status == 200){
						that.news_list = res.data	
					}
				})
			}
		}
	});
})
