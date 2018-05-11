$(function(){
	window.vm = new Vue({
		el : "#vm",
		data:{
			type: '请选择',
			running_activity: null,
			category: null,
			typeAndId: '',
			title: '',
			editoy: null
		},
		created: function(){
			
			this.getRunningActivity()
			this.getCategory()
			this.useUEeditor('editor')
		},
		mounted: function(){
			this.showPanel()
		},
		watch: {
		},
		methods:{
			// 分栏渲染
			showPanel: function(){
				$(".left ul li").each(function(i,item){
					$(item).hasClass('active') && $('.contain-panel').hide() && $('.contain-panel').eq(i).fadeIn(300)
				})
			},
			// 改变分栏
			changePanel: function(el){
				$(".left ul li").removeClass('active')
				$(el.target).addClass('active')
				this.showPanel()
			},
			// 判断文件类型是否正确
			judgeFileType: function(el){
				if($(el.target).val().split('.')[1] =='docx'){return}
				el.target.value = ""
				fixedMsg({
					type: 2,
					msg: '请上传docx后缀文件'
				})
			},
			// 使用ueEditor
			useUEeditor: function(id){
				this.editor = UE.getEditor(id,{
		            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
		            toolbars:[['FullScreen','Bold','|','justifyleft','justifycenter','justifyright','|','removeformat']],
		            //关闭elementPath
		            elementPathEnabled:false,
				    autoHeightEnabled: false,
				    //粘贴只保留标签，去除标签所有属性
        			retainOnlyLabelPasted: true
		        })
				this.editor.addListener('contentChange',function(){
					vm.saveContent(vm.editor.getContent())
				})
				this.editor.ready(function(){
					vm.getLocalContent()
				})
			},
			// 保存内容到localstorage
			saveContent: function(text){
				var text = text || ''
				if(!window.localStorage){
					console.log('浏览器不支持localStorage存储')
					return
				}
				var ykwx = localStorage.ykwx&&JSON.parse(localStorage.ykwx)||{}
				ykwx.article_content = text
				localStorage.ykwx = JSON.stringify(ykwx)
			},
			// 获取localstorage
			getLocalContent: function(){
				if(!window.localStorage){
					console.log('浏览器不支持localStorage存储')
					return
				}
				if(localStorage.ykwx){
					var html = JSON.parse(localStorage.ykwx).article_content || ""
					this.editor.setContent(html)
				}
			},
			// 获取正在进行的活动
			getRunningActivity: function(){
				$._ajax({
					type:"get",
					url:"/activity/running"
				}).done(function(res){
					if(res.status == 200){
						res.data.forEach(function(item){
							item.type = 'activity-'+item.id
						})
						vm.running_activity = res.data
					}
				})
			},
			// 获取日常栏目
			getCategory: function(){
				$._ajax({
					type:"get",
					url:"/category"
				}).done(function(res){
					if(res.status == 200){
						res.data.forEach(function(item){
							item.type = 'category-'+item.id
						})
						vm.category = res.data
					}
				})
			},
			// 上传手写文本类型文章
			addTextArticle: function(){
				if(this.title == '' || this.editor.getContentTxt()=='' || this.typeAndId==''){
					fixedMsg({
						type: 2,
						msg: '标题或类别或内容不能为空'
					})
					return 
				}
				$._ajax({
					type:"post",
					url:"/article/textArticle",
					data:{
						name: this.title,
						type: this.typeAndId,
						content: this.editor.getContent()
					}
				}).done(function(res){
					if(res.status && res.status == -10){
						vm_head.showloginModal()
					}
					if(res.status == 200){
//						vm.saveContent("")
						vm.editor.setContent("")
						fixedMsg({
							type: 0,
							msg: '投稿成功'
						})
					}
				})
			},
			// 上传文件文章
			addFileArticle: function(){
//				if(this.title == '' || $('#file')[0].files.length ==0 || this.typeAndId==''){
//					fixedMsg({
//						type: 2,
//						msg: '标题或类别或文件不能为空'
//					})
//					return 
//				}
//				if($('#file').val().split('.')[1] != 'docx'){
//					$('#file').val("")
//					fixedMsg({
//						type: 2,
//						msg: '请上传docx后缀文件'
//					})
//					return 
//				}
				$('#part2').attr('action','/article/fileArticle')
				$('#part2').attr('enctype','multipart/form-data')
				$('#part2').attr('method','post')
				$('#part2').submit()
//				$._ajax({
//					type:"post",
//					url:"/article/textArticle",
//					data:{
//						name: this.title,
//						type: this.typeAndId,
//						content: this.editor.getContent()
//					}
//				}).done(function(res){
//					if(res.status && res.status == -10){
//						vm_head.showloginModal()
//					}
//					res.status == 200 && vm.saveContent("")
//				})
			}
		}
	});
})
