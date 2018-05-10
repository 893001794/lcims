<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.lccert.crm.project.ProjectAction"%>
<%@page import="java.io.File"%>
<%@page import="com.lccert.crm.chemistry.util.ReadExl"%>
<%@page import="com.lccert.crm.project.Project"%>
<%@page import="com.lccert.crm.flow.Flow"%>
<%@page import="com.lccert.crm.project.ProjectTimeAction"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%


 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <link href="reset.css" rel="stylesheet" type="text/css" />
    <style type="text/css">*{    font-size:12px;}
    #dFlightContent1 {    width: 704px;    height:auto;    border-bottom: 1px solid #B0CAED;    border-left: 1px solid #B0CAED;    border-right: 1px solid #B0CAED;    overflow: hidden;}.w_tt {    font-size:14px;    color:#006699;    margin:0px 4px;}.w_tit {    width:85px;    text-align:right;}.w_uinfo {    width:500px;    margin:5px 20px 10px;}.w_uinfo input {    height:18px;    border:solid 1px #999999;}</style><script language="javascript">    //添加成人   
     function addAdult(){       
      var selAdult = $("#SelectAdult");       
       var tabtrCss = $(".tabtr");        
       var selValue = selAdult.val();        
       var addStr = "<tr class='tabtr'><td><table><tr height='30px'><td class='w_tit'>乘客姓名：</td><td colspan='2'><input type='text' name='userName' /></td></tr><tr height='30px'><td class='w_tit'>证件号：</td><td><input type='text' name='papersNum' /></td><td class='w_tit'>证件类型：</td><td><select name='paper' id='paper'><option value='1'>身份证</option><option value='2'>护照</option><option value='3'>军官证</option><option value='4'>其它</option></select></td></tr></table></td></tr>";        
       tabtrCss.remove();           
        for(var i=1;i<=selValue;i++){                
        $("#adult").append(addStr);            }    }    //添加儿童    
        function addChildren(){        
        var selChild = $("#SelectChildren");        
        var children = $(".children");        
        var selValue = selChild.val();        
        var addStr = "<tr class='children'><td><table><tr height='30px'><td class='w_tit'>乘客姓名：</td><td colspan='2'><input type='text' name='userName' /></td></tr><tr height='30px'><td class='w_tit'>证件号：</td><td><input type='text' name='papersNum' /></td><td class='w_tit'>证件类型：</td><td><select name='paper' id='paper'><option value='1'>身份证</option><option value='2'>出生日期</option><option value='3'>其它</option></select></td></tr></table></td></tr>";        
        children.remove();        
        for(var i = 1;i<=selValue;i++){            
        $("#child").append(addStr);        }    }
        </script>
        </head>
        <body>
        <div id="dFlightContent1" class="ct">  
        <table cellpadding="0px" cellspacing="0px" border="0px" class="w_uinfo" id="adult">    
        <tr height="40px">      <td colspan="4"><img src="06.png" alt="" /><b class="w_tt">成人</b>        
        <select name="SelectAdult" id="SelectAdult" onchange="addAdult()">          
        <option value="1">1人</option>          <option value="2">2人</option>          
        <option value="3">3人</option>          <option value="4">4人</option>          
        <option value="5">5人</option>        
        </select></td>    
        </tr>    
        <tr class="tabtr">      
        <td>
        <table>          
        <tr height="30px">            
        <td class="w_tit">乘客姓名：</td>            
        <td colspan="2"><input type="text" name="userName" /></td>          
        </tr>          
        <tr height="30px">            
        <td class="w_tit">证件号：</td>            
        <td><input type="text" name="papersNum" /></td>            
        <td class="w_tit">证件类型：</td>            
        <td><select name="paper" id="paper">                
        <option value="1">身份证</option>                
        <option value="2">护照</option>                
        <option value="3">军官证</option>                
        <option value="4">其它</option>              
        </select></td>          
        </tr>        
        </table>
        </td>    
        </tr>  
        </table>  
        <table cellpadding="0px" cellspacing="0px" border="0px" class="w_uinfo" id="child">    
        <tr height="40px">      
        <td colspan="4"><img src="06.png" alt="" /><b class="w_tt">儿童</b>        
        <select name="SelectChildren" id="SelectChildren" onchange="addChildren()">          
        <option value="0">0人</option>          
        <option value="1">1人</option>          
        <option value="2">2人</option>        
        </select></td>    
        </tr>  
        </table>  
        <table cellpadding="0px" cellspacing="0px" border="0px" class="w_uinfo">    
        <tr height="40px">      
        <td class="w_tit">联系人姓名：</td>      
        <td><input type="text" name="userName" /></td>      
        <td class="w_tit">联系方式：</td>      
        <td><input type="text" name="tel" /></td>    
        </tr>    
        <tr height="40px" align="center">      
        <td colspan="4"><img src="tijiao.jpg" alt="" /></td>    
        </tr>  
        </table>
        </div>
        </body>
        </html>