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
				var gz=document.getElementById("gz").value;
				var total=parseFloat(chem)+parseFloat(safe)+parseFloat(op)+parseFloat(emc)+parseFloat(dr)+parseFloat(vip)+parseFloat(eq)+parseFloat(finance)+parseFloat(gz);
				document.getElementById("total").value=total.toFixed(2);
			}