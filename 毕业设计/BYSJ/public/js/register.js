$(function(){
	window.vm = new Vue({
		el : "#vm",
		data:{
			account: '',
			name: '',
			pwd1: '',
			pwd2: '',
			email: '',
			phone: '',
			captcha: '',
			isStudent: '1',
			SNO: ''
		},
		created: function(){

		},
		computed: {

		},
		methods:{
			// 非空判断
			notEmpty: function(value){
				if(value == '' && /^\s*$/.test(value)) return false
				return true
			},
			// 判断长度
			sureLength: function(value,min,max){
				if(arguments.length == 2){
					// 最小长度
					return value.length >= min
				} else if(arguments.length == 3){
					// 有最小长度和最大长度
					return value.length >=min && value.length <=max
				}
				return false
			},
			verifyAccount: function(){
				var val = this.account
				if(!this.notEmpty(val)){
					fixedMsg({type:1,msg:'用户名不能为空'})
					return false
				}
				if(!this.getExist('account',val)){
					fixedMsg({type:1,msg:'该用户名已存在'})
					return false
				}
				return true
			},
			verifyName: function(){
				var val = this.name
				if(!this.notEmpty(val)){
					fixedMsg({type:1,msg:'笔名不能为空'})
					return false
				}
				if(!this.sureLength(val,1,6)){
					fixedMsg({type:1,msg:'笔名长度不能大于6'})
					return false
				}
				if(!this.getExist('name',val)){
					fixedMsg({type:1,msg:'该笔名已存在'})
					return false
				}
				return true
			},
			verifyPwd1: function(){
				var val = this.pwd1
				if(!this.notEmpty(val)){
					fixedMsg({type:1,msg:'密码不能为空'})
					return false
				}
				if(!this.sureLength(val,6)){
					fixedMsg({type:1,msg:'密码长度不能小于6'})
					return false
				}
				return true
			},
			verifyPwd2: function(){
				if(this.pwd1 != this.pwd2){
					fixedMsg({type:1,msg:'两次输入的密码不同'})
					return false
				}
				return true
			},
			verifyEmail: function(){
				var val = this.email
				if(!this.notEmpty(val)){
					fixedMsg({type:1,msg:'邮箱不能为空'})
					return false
				}
				if(!/^\w*@\w+\.\w+$/.test(val)){
					fixedMsg({type:1,msg:'邮箱格式不正确'})
					return false
				}
				if(!this.getExist('email',val)){
					fixedMsg({type:1,msg:'该邮箱已存注册过，不能重复注册'})
					return false
				}
				return true
			},
			// 判断验证码
			verifyCaptcha: function(){
				var val = this.captcha
				if(!this.notEmpty(val)){
					fixedMsg({type:1,msg:'验证码不能为空'})
					return false
				}
				return true
			},
			verifySNO: function(){
				var val = this.SNO
				if(!this.notEmpty(val)){
					fixedMsg({type:1,msg:'学号不能为空'})
					return false
				}
				if(val.length != 10){
					fixedMsg({type:1,msg:'学号格式不正确'})
					return false
				}
				return true
			},
			// 判断字段值是否已存在
			getExist: function(filed,value){
				var return_val = false
				$._ajax({
					type: "get",
					url: "/user/exist",
					async: false,
					data:{
						filed: filed,
						value: value
					}
				}).done(function(res){
					if(res.status == 200) return_val=true
				})
				return return_val
			},
			// 获取验证码
			getCode: function(){
				var email = this.email
				if(!this.verifyEmail()) return
				$._ajax({
					type: "get",
					url: "/user/code",
					data:{
						email: email,
					}
				}).done(function(res){
					if(res.status != 200){
						fixedMsg({type:1,msg:res.data})
					}
				})
			},
			// 注册
			register: function(){
				if(!(this.verifyAccount() && this.verifyName() && this.verifyPwd1() && this.verifyPwd2()
				&& this.verifyEmail() && this.verifyCaptcha())){
					return false
				}
				if(this.isStudent == 1 && !this.verifySNO()){
					return false
				}
				$._ajax({
					type: "post",
					url: "/user/register",
					data:{
						account: this.account,
						name: this.name,
						password: this.pwd1,
						email: this.email,
						phone: this.phone,
						captcha: this.captcha,
						student: this.isStudent,
						sno: this.isStudent == 1 ? this.SNO:''
					}
				}).done(function(res){
					if(res.status == 200){
						var obj = getStorage()
						obj.user = res.data
						setStorage(obj)
						location.href = baseUrl
					} else{
						fixedMsg({type:1,msg:res.msg})
					}
				}).fail(function(err){
					fixedMsg({type:1,msg:err.responseJSON.msg||'注册失败'})
				})
			}
		}
	})
})
