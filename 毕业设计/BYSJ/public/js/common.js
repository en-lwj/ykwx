var baseUrl = "http://"+location.host
/**
 *	检查是pc端还是移动端 
 */
!function mobile() {
    try{
        document.createEvent("TouchEvent");
        console.log('这是移动端')
        return true;
    }
    catch(e){
        console.log('这是pc端')
        return false;
    }
}()

/**
 * 警告框
 * */
function showWarningMsg(el,msg){
	if($(el).find('.alert-warning').length != 0){
		$(el).find('.alert-warning-msg').html(msg)
		return 
	}
	var html = '<div class="alert alert-warning alert-dismissible fade in" role="alert">'+
  		'<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>'+
  		'<div class="alert-warning-msg">'+msg+'<div>'+
	'</div>'
	$(el).prepend(html)
}

// 提示栏
// {type,msg}
function fixedMsg(obj){
	var $div = $('<div class="alert" role="alert">...</div>')
	if(obj.type != undefined && obj.type == 0){
		$div.addClass('alert-success')
	} else if(obj.type != undefined && obj.type == 1){
		$div.addClass('alert-danger')
	} else if(obj.type != undefined && obj.type == 2){
		$div.addClass('alert-warning')
	} else {
		$div.addClass('alert-info')
	}
	$div.html(obj.msg||' ')
	$('body').append($div)
	$div.css({
		'position': 'fixed',
		'z-index': '1100',
		'background-color': 'rbga(0,0,0,0.2)',
		'padding': '10px'
	})
	$div.clearQueue().delay(3000).queue(function(){
		$(this).hide()
		$(this).dequeue()
	}).queue(function(){
		$(this).remove()
	})
	$div.css({
		top: '50%',
		left: '50%',
		'margin-top': -$div.height()/2-260+'px',
		'margin-left': -$div.width()/2+'px',
	})
}
/**
 * ajax二度封装
 * */
!function(){
	$._ajax = function (obj){
		var ajax_obj = {
			type:"get",
			url:"/",
			async:true
		}
		
		for(var key in obj){
			ajax_obj[key] = obj[key]
		}
		ajax_obj.url = baseUrl+ajax_obj.url
		return $.ajax(ajax_obj).done(function(res){
			if(res.status && res.status == -10){
				if(window.vm_head) vm_head.showloginModal()
				else {
					location.href = baseUrl+'/page/login'
				}
			} else if(res.status && res.status == -20){
				fixedMsg({type:1,msg:'用户权限不足'});
			} else{
				
				return res
			}
		}).fail(function(err){
			err.responseJSON&&fixedMsg({type:1,msg:err.responseJSON.msg||'注册失败'})
		})
	}
	
}()

// 获取localStorage里 ykwx 字段并转化为对象
function getStorage(){
	var ykwx = {}
	if(!window.localStorage){
		console.log('您的浏览器不支持localStorage')
		return ykwx
	}
	if(!localStorage.ykwx) return ykwx
	try{
		ykwx = JSON.parse(localStorage.ykwx)
	}catch(e){
		ykwx = eval('('+localStorage.ykwx+')')
	}
	if(typeof ykwx !="object") return {}
	return ykwx
}

// 设置localStorage里 ykwx 字段
function setStorage(obj){
	var obj = obj||{}
	localStorage.ykwx = JSON.stringify(obj)
}

// 设置localStorage里 user 字段
function setUserStorage(obj){
	var obj = obj||{}
	var ykwx = getStorage()
	var user= ykwx.user || {}
	var new_obj = {
		img: obj.img||user.img||'',
		admin: obj.admin||user.admin||0,
		name: obj.name||user.name||''
	}

	setStorage(ykwx)

	// 更新 head
	if(vm_head){
		vm_head.userInfo = new_obj
	}
}

// 克隆对象属性
function cloneObj(obj){
	var new_obj = {}
	for(var key in obj){
		new_obj[key] = obj[key]
	}
	return new_obj
}

// 对象属性覆盖添加
function mergeObj(source,obj){
	for(var key in obj){
		source[key] = obj[key]
	}
	return source
}

// 退出登录
function logout(){
	var ykwx = getStorage()
	if(ykwx.user) delete ykwx.user
	setStorage(ykwx)
	$._ajax({
		type:"get",
		url:"/user/logout"
	}).done(function(res){
		if(res.status != 200){
			fixedMsg({type:1,msg:res.msg})
		}else{
			location.href = baseUrl+'/page/login'
		}
	})
}