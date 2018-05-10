package org.com.tangzp.mail;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.io.PrintWriter;
import java.io.BufferedWriter;
import java.io.*;
public class NewSendMail {
  public static void main(String[] args) {
     Mainprogram1 w1= new Mainprogram1();
  
     w1.sendmail() ;
 
   
  }
}

class Mainprogram1{
 
  private  java.util.Date sysdate;
  Mainprogram1(){
      //获取要查询的起止时间
      sysdate = new java.util.Date();
     }

  public void sendmail(){ //创建邮件发送实例，发送邮件
    String smtp = "smtp.163.com";//邮件服务器地址
//    String smtp = "61.151.239.132";//邮件服务器地址
    String mailname = "lcims@lccert.com";//连接邮件服务器的用户名
    String mailpsw = "12345678";//连连接邮件服务器的用户密码
    String mailto = "tangzp@lccert.com";// 接收邮件的地址
    String copyto = "";// 抄送邮件的地址
    String mailfrom = "lcims@lccert.com";// 发送邮件的地址
    String mailtitle = "测试邮件标题";// 邮件的标题
     //请根据实际情况赋值
    Mail mymail= new Mail(smtp,mailname, mailpsw);
    String mto[]={mailto};
    String mcc[]={copyto};
    try{
       mymail.setMailFrom(mailfrom);
       mymail.setSendDate(new Date());
       mymail.setMailTo(mto,"to");
       if (!copyto.matches("")){ //如果抄送不为空，则将信件抄送给copyto
           mymail.setMailTo(mcc,"cc");
       }
       mymail.setSubject(mailtitle);
       mymail.addTextContext("邮件内容");
       mymail.addHtmlContext("html内容");
       mymail.addAttachment("c://立创号外 第16期.PDF","立创号外 第16期.PDF");
       mymail.addAttachmentFromUrl("http://162.105.109.163/getimg?imgid=148","c://1.JPG");
       mymail.addAttachmentFromUrl("http://file","1.html");
       
       //下面的附件内容来自一个byte[]类型，增加这个方法的意图在于如果在web模式下发邮件，就不用生成临时文件
       //直接将上载的文件保存成byte[]格式，然后使用该方法添加到邮件的附件中，进行发送
       InputStream inputStream=null;
     try {
     File imageFile = new File("c://1.JPG");
         inputStream = new FileInputStream(imageFile);
      } catch(IOException ei){}
   
    try {
     byte[] b=new byte[inputStream.available()];
   
     inputStream.read(b);
     mymail.addAttachmentFrombyte(b,"c://1.JPG");
     
  
  } catch (IOException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  } 
       
       
       
       mymail.sendMail() ;
       WriteinfoToFile("邮件发出！");
    }
    catch (Exception ex){ WriteinfoToFile("邮件发送失败！"+ex.toString());}
  }

   //向ini文件中写提示信息
  private void WriteinfoToFile(String info){
    try{
      PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter("mailinfo.txt",true)));
      pw.println(sysdate.toString()+" "+info);
      pw.close();
    }
    catch(IOException ei){
      System.out.println(sysdate.toString()+ " 向mailinfo.txt文件中写数据错误:"+ei.toString());
      System.exit(0);
    }
  }
}


