
		function getTotal(total) {
			var sumTotal=0.0;
			var itemcount = document.getElementById("itemcount" + total).value;
			//alert("itemcount:"+itemcount);
			var saleprice = document.getElementById("saleprice" + total).value;
			//ʵ�ʼ�
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
			var content = "����" + document.getElementById("pid").value;
			invcontent.value = content;
		}
	}
	
	function changeSelect(invtype) {
		if(invtype.value.match("����")) {
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
		if(invmethod.value.match("����Ŀ")) {
			document.getElementById("invtype").value = "ȫ��";
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
			alert ("����۵���ţ�");
			TheForm.rtime.focus();
			return(false);
		}

		if (TheForm.sales.value == "") {
			alert ("����д������Ա��");
			TheForm.sales.focus();
			return(false);
		}

		if (TheForm.client.value == "-1") {
			alert ("��ѡ��ͻ����ƣ�");
			TheForm.client.focus();
			return(false);
		}
		
	return(true);
	}

////////////////////////////


    var req;
    function Change_Select(){//����һ���������ѡ����ı�ʱ���øú���
      var companyid = document.getElementById('companyid').value;
      var url = "addorder_sales.jsp?companyid=" + companyid + "&timestampt=" + new Date().getTime();
      if(window.XMLHttpRequest){
        req = new XMLHttpRequest();
      }else if(window.ActiveXObject){
        req = new ActiveXObject("Microsoft.XMLHTTP");
      }
      if(req){
        req.open("POST",url,true);
         //ָ���ص�����Ϊcallback
        req.onreadystatechange = callback;
        req.send(null);
      }
    }
    //�ص�����
    function callback(){
      if(req.readyState ==4){
        if(req.status ==200){
          parseMessage();//����XML�ĵ�
        }else{
         // alert("���ܵõ�������Ϣ:" + req.statusText);
        }
      }
    }
    
    
 
    
    //��������xml�ķ���
    function parseMessage(){
      var xmlDoc = req.responseXML.documentElement;//��÷��ص�XML�ĵ�
      var xSel = xmlDoc.getElementsByTagName('select');
      
      //���XML�ĵ��е�����<select>���
      var select_root = document.getElementById('salesid');
      //�����ҳ�еĵڶ���������
      select_root.options.length=0;
      //ÿ�λ���µ����ݵ�ʱ���Ȱ�ÿ����������ܵĳ�����0
      for(var i=0;i<xSel.length;i++){
        var xValue = xSel[i].childNodes[0].firstChild.nodeValue;
        //���ÿ��<select>����еĵ�һ����ǵ�ֵ,Ҳ����<value>��ǵ�ֵ
        var xText = xSel[i].childNodes[1].firstChild.nodeValue;
        //���ÿ��<select>����еĵڶ�����ǵ�ֵ,Ҳ����<text>��ǵ�ֵ
        var option = new Option(xText, xValue);
        //����ÿ��value��text��ǵ�ֵ����һ��option����
        
        try{
        	if(xValue !=54){//�����������ۣ���������������������ѡ����ʱ�ų���
        		select_root.add(option);//��option������ӵ��ڶ�����������
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
         //ָ���ص�����Ϊcallback
        req.onreadystatechange = validate;
        req.send(null);
      }
    }
    //�ص�����
    function validate(){
      if(req.readyState ==4){
        if(req.status ==200){
        	var res = req.responseText;
        	//alert(res+"-----------------");
        	if(res == 0) {
        		alert("�ͻ������ڣ���������ͻ����ϣ�");
        		window.open("../client/addclient.jsp");
        	}
        }else{
          alert("ϵͳ���ֹ��ϣ�����ϵ����Ա��");
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
			synch:true,//(Ĭ��: true) Ĭ�������£����������Ϊ�첽���������Ҫ����ͬ�������뽫��ѡ������Ϊ false��ע�⣬ͬ��������ס��������û�������������ȴ�������ɲſ���ִ�С�
			dataType: 'xml',//������Բ�д����ǧ���дtext����html!!!   
			success:function(xml){//����ɹ���ص���������������������������������������ݣ�����״̬//
				 $(xml).find('select').each(function(){
				  var option1 = "<OPTION value='";   
				  var option2 = "'>";   
				  var option3 = "</OPTION>"; 
				  var text = $(this).children("text").text(); //��ȡ�ı����ֵ
				  var value = $(this).children("value").text(); //��ȡ���ݵ�ֵ
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
			synch:true,//(Ĭ��: true) Ĭ�������£����������Ϊ�첽���������Ҫ����ͬ�������뽫��ѡ������Ϊ false��ע�⣬ͬ��������ס��������û�������������ȴ�������ɲſ���ִ�С�
			dataType: 'xml',//������Բ�д����ǧ���дtext����html!!!   
			success:function(xml){//����ɹ���ص���������������������������������������ݣ�����״̬//
				$(xml).find('select').each(function(){
					var option1 = "<OPTION value='";   
					var option2 = "'>";   
					var option3 = "</OPTION>"; 
					var text = $(this).children("text").text(); //��ȡ�ı����ֵ
					var value = $(this).children("value").text(); //��ȡ���ݵ�ֵ
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
						