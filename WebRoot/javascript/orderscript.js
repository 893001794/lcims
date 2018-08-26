
		function getTotal(total) {
			var sumTotal=0.0;
			var itemcount = document.getElementById("itemcount" + total).value;
			//alert("itemcount:"+itemcount);
			var saleprice = document.getElementById("saleprice" + total).value;
			//实际价
			var price = document.getElementById("price" + total).value;
			if(itemcount == "" || saleprice == "") {
				document.getElementById("itemtotal" + total).value = "";
			} else {
					
				if(price !=""){
					sumTotal = (itemcount * price).toFixed(0);
				}else{
					sumTotal = (itemcount * saleprice).toFixed(0);
				}
				document.getElementById("itemtotal" + total).value=sumTotal;
				//sumTotalprice();
				//sumTotalStandprice();
			}
		}
		
		function sumTotalprice() {
			var itemtotals = document.getElementsByName("itemtotal");
			var totalprice = 0;
			var temp = 0;
			for(i=0; i<itemtotals.length; i++){
				var itemtotal = itemtotals[i].value
		        temp = parseInt(totalprice)+parseInt(itemtotal);
		        if(!isNaN(temp)) {
		        	totalprice = temp;
		        }
		    }
			document.getElementById("totalprice").value = totalprice;
		}
		/**
		function sumTotalStandprice() {
			var standprices = document.getElementsByName("standprice");
			var itemcounts = document.getElementsByName("itemcount");
			var totalstandprice = 0;
			var temp = 0;
			for(i=0; i<standprices.length; i++){
				var standprice = standprices[i].value;
				var itemcount = itemcounts[i].value;
		        temp = parseInt(totalstandprice) + parseInt(standprice) * parseInt(itemcount);
		        if(!isNaN(temp)) {
		        	totalstandprice = temp;
		        }
		    }
			document.getElementById("totalstandprice").value = totalstandprice;
		}
		**/
		
		
		function addproject() {
			with (document.getElementById("quotationform")) {
			method="post";
			action="addorder_post.jsp";
			submit();
			}
		}
		
		
		function goBack() {
		window.self.location="order_manage.jsp";
	}
	
	function getinvprice(invprice) {
		if(invprice.value == "") {
			sumTotalprice();
			invprice.value = document.getElementById("totalprice").value;
		}
	}
	//////////////////////////////////////
	
	
	function getinvhead(invhead) {
		if(invhead.value == "") {
			invhead.value = document.getElementById("client").value;
		}
	}
	
	function getinvcontent(invcontent) {
		if(invcontent.value == "") {
			var content = "检测费" + document.getElementById("pid").value;
			invcontent.value = content;
		}
	}
	
	function changeSelect(invtype) {
		if(invtype.value.match("不开")) {
			//document.getElementById("invhead").readOnly=true;
			//document.getElementById("invhead").style.background="#F2F2F2";
			document.getElementById("invhead").value = "";
			document.getElementById("invhead").style.display="none";
			
			//document.getElementById("invcontent").readOnly=true;
			//document.getElementById("invcontent").style.background="#F2F2F2";
			document.getElementById("invcontent").value = "";
			document.getElementById("invcontent").style.display="none";
			
			//document.getElementById("invcount").readOnly=true;
			//document.getElementById("invcount").style.background="#F2F2F2";
			document.getElementById("invcount").value = "";
			document.getElementById("invcount").style.display="none";
			
			document.getElementById("invmethod").options[0].selected=true;
			
		} else {
			//document.getElementById("invhead").readOnly=false;
			//document.getElementById("invhead").style.background="#FFFFFF";
			
			//document.getElementById("invcontent").readOnly=false;
			//document.getElementById("invcontent").style.background="#FFFFFF";
			
			//document.getElementById("invcount").readOnly=false;
			//document.getElementById("invcount").style.background="#FFFFFF";
			document.getElementById("invhead").style.display="";
			document.getElementById("invcontent").style.display="";
			document.getElementById("invcount").style.display="";
			
		}
	}
	
		function changeMethod(invmethod) {
		if(invmethod.value.match("分项目")) {
			document.getElementById("invtype").value = "全额";
			document.getElementById("invcount").value = "";
			document.getElementById("invhead").value = "";
			document.getElementById("invcontent").value = "";
			document.getElementById("invoice").style.display="none";
			
		} else {
			document.getElementById("invoice").style.display="";
		}
	}





	function CheckForm(TheForm) {

		if (TheForm.priceid.value == "") {
			alert ("请填报价单编号！");
			TheForm.rtime.focus();
			return(false);
		}

		if (TheForm.sales.value == "") {
			alert ("请填写销售人员！");
			TheForm.sales.focus();
			return(false);
		}

		if (TheForm.client.value == "-1") {
			alert ("请选择客户名称！");
			TheForm.client.focus();
			return(false);
		}
		
	return(true);
	}

////////////////////////////


    var req;
    function Change_Select(){//当第一个下拉框的选项发生改变时调用该函数
      var companyid = document.getElementById('companyid').value;
      var url = "addorder_sales.jsp?companyid=" + companyid + "&timestampt=" + new Date().getTime();
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("POST",url,true);
         //指定回调函数为callback
        req.onreadystatechange = callback;
        req.send(null);
      }
    }
    //回调函数
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage();//解析XML文档
        }else{
         // alert("不能得到描述信息:" + req.statusText);
        }
      }
    }
    
    
 
    
    //解析返回xml的方法
    function parseMessage(){
      var xmlDoc = req.responseXML.documentElement;//获得返回的XML文档
      var xSel = xmlDoc.getElementsByTagName('select');
      
      //获得XML文档中的所有<select>标记
      var select_root = document.getElementById('salesid');
      //获得网页中的第二个下拉框
      select_root.options.length=0;
      //每次获得新的数据的时候先把每二个下拉框架的长度清0
      for(var i=0;i<xSel.length;i++){
        var xValue = xSel[i].childNodes[0].firstChild.nodeValue;
        //获得每个<select>标记中的第一个标记的值,也就是<value>标记的值
        var xText = xSel[i].childNodes[1].firstChild.nodeValue;
        //获得每个<select>标记中的第二个标记的值,也就是<text>标记的值
        var option = new Option(xText, xValue);
        //根据每组value和text标记的值创建一个option对象
        
        try{
        	if(xValue !=54){//夏念民是销售，但他不生单；所以生单选销售时排除他
        		select_root.add(option);//将option对象添加到第二个下拉框中
        	}
        }catch(e){
        }
      }
      var ops = document.getElementById("salesid").options;
		for(var i=0;i<ops.length;i++) {
			if(ops[i].value.charCodeAt() == "<%=qt.getSales()%>".charCodeAt()){
				ops[i].selected = true;	
			}
		}
    }        
/////////////////////////////////////////


    
    function validateclient(){
      var client = document.getElementById('client').value;
      encodeURIComponent(client)
      var url = "validateclient.jsp?client=" + encodeURI(encodeURI(client)) + "&timestampt=" + new Date().getTime();
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("GET",url,true);
         //指定回调函数为callback
        req.onreadystatechange = validate;
        req.send(null);
      }
    }
    //回调函数
    function validate(){
      if(req.readyState ==4){
        if(req.status ==200){
        	var res = req.responseText;
        	//alert(res+"-----------------");
        	if(res == 0) {
        		alert("客户不存在，请先输入客户资料！");
        		window.open("../client/addclient.jsp");
        	}
        }else{
          alert("系统出现故障，请联系管理员！");
        }
      }
    }



	function showitem(str) {
        $("#itemid" + str).autocomplete("item_ajax.jsp",{
            delay:10,
            max:8,
            minChars:1,
            matchSubset:1,
            matchContains:1,
            cacheLength:10,
            matchContains: true,   
            scrollHeight: 250, 
            width:250,
            dataType:'json',
            parse:function(data) {
            	var parsed = [];
		        for (var i = 0; i < data.length; i++) {
		            parsed[parsed.length] = {
	                data: data[i],
	                value: data[i].itemid,
	                result: data[i].itemid
		        	};
		        }
		        return parsed;
            },
            formatItem: function(item) {
           		return "<div>"+item.itemid + "&nbsp;&nbsp;&nbsp;" + item.name+"</div>";
	        },
	        formatMatch: function(item) {
	        	return item.itemid;
	        },
	        formatResult: function(item) {
	        	return item.itemid;
	        }
	     }).result(function(event, item, formatted) {
	    	 
	    	 if(item.itemid=="28.10.09"||item.itemid=="28.09.26"||item.itemid=="28.10.10"){
	    		 document.getElementById("samplename"+str).disabled=false;
	    	 }
	    		 $("#itemname" + str).val(item.name);
		         $("#standprice" + str).val(item.standprice);
		         $("#saleprice" + str).val(item.saleprice);
		         $("#controlprice" +str).val(item.controlprice);
		         $("#outprice" + str).val(item.outprice);
		         plane(str,item.plane);
            });   
        
     }
	
	function plane(str,planid){
		$("#plane"+str)[0].options.length=0;
		jQuery.ajax({
			url:'addorder_plane.jsp?planid='+planid+"&status=1",
			type:'POST',
			synch:true,//(默认: true) 默认设置下，所有请求均为异步请求。如果需要发送同步请求，请将此选项设置为 false。注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行。
			dataType: 'xml',//这里可以不写，但千万别写text或者html!!!   
			success:function(xml){//请求成功后回调函数。这个方法有两个参数：服务器返回数据，返回状态//
				 $(xml).find('select').each(function(){
				  var option1 = "<OPTION value='";   
				  var option2 = "'>";   
				  var option3 = "</OPTION>"; 
				  var text = $(this).children("text").text(); //获取文本框的值
				  var value = $(this).children("value").text(); //获取内容的值
				  $("#plane"+str).append(option1 + value + option2 + text + option3); 
				});
				 child(str,$("#plane"+str)[0].value);
			}
		})
	}
	
	
	function child(str,planid){
		$("#yle"+str)[0].options.length=0;
		jQuery.ajax({
			url:'addorder_plane.jsp?planid='+planid+"&status=2",
			type:'POST',
			synch:true,//(默认: true) 默认设置下，所有请求均为异步请求。如果需要发送同步请求，请将此选项设置为 false。注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行。
			dataType: 'xml',//这里可以不写，但千万别写text或者html!!!   
			success:function(xml){//请求成功后回调函数。这个方法有两个参数：服务器返回数据，返回状态//
				$(xml).find('select').each(function(){
					var option1 = "<OPTION value='";   
					var option2 = "'>";   
					var option3 = "</OPTION>"; 
					var text = $(this).children("text").text(); //获取文本框的值
					var value = $(this).children("value").text(); //获取内容的值
				//	alert(option1 + value + option2 + text + option3);
					$("#yle"+str).append(option1 + value + option2 + text + option3); 
				});
			}
		})
	}
	
	function clearAll(i) {
		var obj = document.getElementById("itemid" + i).value;
		if(obj == "") {
			document.getElementById("itemid" + i).value = "";
			document.getElementById("itemname" + i).value = "";
			document.getElementById("samplename" + i).value = "";
			document.getElementById("itemcount" + i).value = "";
			document.getElementById("standprice" + i).value = "";
			document.getElementById("saleprice" + i).value = "";
			document.getElementById("itemtotal" + i).value = "";
			document.getElementById("controlprice" + i).value="";
			document.getElementById("remark" + i).value = "";
			document.getElementById("outprice" + i).value = "";
		}
	}
						