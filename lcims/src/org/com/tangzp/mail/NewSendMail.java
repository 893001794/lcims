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
      //��ȡҪ��ѯ����ֹʱ��
      sysdate = new java.util.Date();
     }

  public void sendmail(){ //�����ʼ�����ʵ���������ʼ�
    String smtp = "smtp.163.com";//�ʼ���������ַ
//    String smtp = "61.151.239.132";//�ʼ���������ַ
    String mailname = "lcims@lccert.com";//�����ʼ����������û���
    String mailpsw = "12345678";//�������ʼ����������û�����
    String mailto = "tangzp@lccert.com";// �����ʼ��ĵ�ַ
    String copyto = "";// �����ʼ��ĵ�ַ
    String mailfrom = "lcims@lccert.com";// �����ʼ��ĵ�ַ
    String mailtitle = "�����ʼ�����";// �ʼ��ı���
     //�����ʵ�������ֵ
    Mail mymail= new Mail(smtp,mailname, mailpsw);
    String mto[]={mailto};
    String mcc[]={copyto};
    try{
       mymail.setMailFrom(mailfrom);
       mymail.setSendDate(new Date());
       mymail.setMailTo(mto,"to");
       if (!copyto.matches("")){ //������Ͳ�Ϊ�գ����ż����͸�copyto
           mymail.setMailTo(mcc,"cc");
       }
       mymail.setSubject(mailtitle);
       mymail.addTextContext("�ʼ�����");
       mymail.addHtmlContext("html����");
       mymail.addAttachment("c://�������� ��16��.PDF","�������� ��16��.PDF");
       mymail.addAttachmentFromUrl("http://162.105.109.163/getimg?imgid=148","c://1.JPG");
       mymail.addAttachmentFromUrl("http://file","1.html");
       
       //����ĸ�����������һ��byte[]���ͣ����������������ͼ���������webģʽ�·��ʼ����Ͳ���������ʱ�ļ�
       //ֱ�ӽ����ص��ļ������byte[]��ʽ��Ȼ��ʹ�ø÷�����ӵ��ʼ��ĸ����У����з���
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
       WriteinfoToFile("�ʼ�������");
    }
    catch (Exception ex){ WriteinfoToFile("�ʼ�����ʧ�ܣ�"+ex.toString());}
  }

   //��ini�ļ���д��ʾ��Ϣ
  private void WriteinfoToFile(String info){
    try{
      PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter("mailinfo.txt",true)));
      pw.println(sysdate.toString()+" "+info);
      pw.close();
    }
    catch(IOException ei){
      System.out.println(sysdate.toString()+ " ��mailinfo.txt�ļ���д���ݴ���:"+ei.toString());
      System.exit(0);
    }
  }
}


