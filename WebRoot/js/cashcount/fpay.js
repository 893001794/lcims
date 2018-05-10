	//重复刷新、重复提交 
	var checkSubmitFlg = false; 
	function checkSubmit() { 
		if (checkSubmitFlg == true) { 
		   return false; 
		} 
		checkSubmitFlg = true; 
		return true; 
	} 
	document.ondblclick = function docondblclick() { 
		window.event.returnValue = false; 
	} 
	document.onclick = function doconclick() { 
		if (checkSubmitFlg) { 
		window.event.returnValue = false; 
		} 
	} 

//统计小计
	function sumTotal(){
		var chem=document.getElementById("chem").value;
		var safe=document.getElementById("safe").value;
		var op=document.getElementById("op").value;
		var emc=document.getElementById("emc").value;
		var dr=document.getElementById("dr").value;
		var vip=document.getElementById("vip").value;
		var eq=document.getElementById("eq").value;
		var finance=document.getElementById("finance").value;
		var gmo=document.getElementById("gmo").value;
		var administration=document.getElementById("administration").value;
		var engineering=document.getElementById("engineering").value;
		var total=parseFloat(chem)+parseFloat(safe)+parseFloat(op)+parseFloat(emc)+parseFloat(dr)+parseFloat(vip)+parseFloat(eq)+parseFloat(finance)+parseFloat(administration)+parseFloat(engineering)+parseFloat(gmo);
		document.getElementById("total").value=total.toFixed(2);
	}
	
	//获取下拉框值
	function changeValue(obj){
		$('#einvtype').val(obj);
	}
	//根据三级获取二级和一级科目
	function findSubsByThreeLevelSub(threeSubName){
		if(threeSubName ==''){
			alert("输入三级科目，动态获取二级和一级科目");
		}else{
			$.ajax({ //调用jquery ajax
				type:"POST",  //跳转方法为POST
				url:"/lcims/fpayAction", //跳转了路径
				data:"threeSubName="+threeSubName, //传输的值或参数
		        error: function(XMLHttpRequest, textStatus, errorThrown){
		        	alert(XMLHttpRequest.status);
		            alert(XMLHttpRequest.readyState);
		            alert(textStatus);
		        },//如果路径错误或者参数有错的时候就弹出此窗口
				success: function(data){  //如果正确或拿到java里面传输过来的值
				var agent = $(data).find('agent'); //得到一个名称为agent的xml对象
				if(agent.attr('suc') == 'true'){ //得到名称为agent的xml对象里面suc元素，并且判断suc元素的值是否为true
				 	var firstName=agent.attr('firstName'); //获取一级科目
				 	var secondName=agent.attr('secondName'); //获取二级科目
				 	$('#onelevelsub').val(firstName);
				 	$('#twolevelsub').val(secondName);
				}else{
					alert("没有对应的一级和二级科目");
					return false;
				}
				} 
			});
		}
	}