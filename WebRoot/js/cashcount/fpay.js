	//�ظ�ˢ�¡��ظ��ύ 
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

//ͳ��С��
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
	
	//��ȡ������ֵ
	function changeValue(obj){
		$('#einvtype').val(obj);
	}
	//����������ȡ������һ����Ŀ
	function findSubsByThreeLevelSub(threeSubName){
		if(threeSubName ==''){
			alert("����������Ŀ����̬��ȡ������һ����Ŀ");
		}else{
			$.ajax({ //����jquery ajax
				type:"POST",  //��ת����ΪPOST
				url:"/lcims/fpayAction", //��ת��·��
				data:"threeSubName="+threeSubName, //�����ֵ�����
		        error: function(XMLHttpRequest, textStatus, errorThrown){
		        	alert(XMLHttpRequest.status);
		            alert(XMLHttpRequest.readyState);
		            alert(textStatus);
		        },//���·��������߲����д��ʱ��͵����˴���
				success: function(data){  //�����ȷ���õ�java���洫�������ֵ
				var agent = $(data).find('agent'); //�õ�һ������Ϊagent��xml����
				if(agent.attr('suc') == 'true'){ //�õ�����Ϊagent��xml��������sucԪ�أ������ж�sucԪ�ص�ֵ�Ƿ�Ϊtrue
				 	var firstName=agent.attr('firstName'); //��ȡһ����Ŀ
				 	var secondName=agent.attr('secondName'); //��ȡ������Ŀ
				 	$('#onelevelsub').val(firstName);
				 	$('#twolevelsub').val(secondName);
				}else{
					alert("û�ж�Ӧ��һ���Ͷ�����Ŀ");
					return false;
				}
				} 
			});
		}
	}