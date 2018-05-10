package org.com.tangzp.mail;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.activation.URLDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
//http://wenku.baidu.com/view/f24f371555270722192ef748.html
//http://wenku.baidu.com/view/7a4574bafd0a79563c1e728d.html
//http://www.blogjava.net/lhbjava/archive/2008/12/11/202327.html
//http://qsfwy.iteye.com/blog/257276
//http://liupengchao1027.blog.163.com/blog/static/840494672008527113356790/
public  class Mail{
    
    protected ArrayList bodypartArrayList=null;
    protected Multipart multipart = null;
    protected MimeMessage mailMessage = null;
    protected Session mailSession = null;
    protected Properties mailProperties = System.getProperties();
    protected InternetAddress mailFromAddress = null;
    protected InternetAddress mailToAddress = null;
    protected String mailSubject ="";
    protected Date mailSendDate = null;
    private String smtpserver="";
    private String name="";
    private String password="";
    
    public Mail(String smtpHost,String username,String password){
     smtpserver=smtpHost;
     name=username;
     this.password=password;
        mailProperties.put("mail.smtp.host",smtpHost);
        mailProperties.put("mail.smtp.auth","true"); //设置smtp认证，很关键的一句
        mailSession = Session.getDefaultInstance(mailProperties);
        //mailSession.setDebug(true);
        
        mailMessage = new MimeMessage(mailSession);
        multipart = new MimeMultipart();
        bodypartArrayList=new ArrayList();//用来存放BodyPart，可以有多个BodyPart！
    }
    //设置邮件主题
    public void setSubject(String mailSubject)throws MessagingException{
        this.mailSubject = mailSubject;
        mailMessage.setSubject(mailSubject);
    }
    //设置邮件发送日期
    public void setSendDate(Date sendDate)throws MessagingException{
        this.mailSendDate = sendDate;
        mailMessage.setSentDate(sendDate);
    }
    //发送纯文本
    public void addTextContext(String textcontent)throws MessagingException{
     BodyPart bodypart=new MimeBodyPart();
     bodypart.setContent(textcontent,"text/plain;charset=GB2312");
     bodypartArrayList.add(bodypart);
    }
    //发送Html邮件
    public void addHtmlContext(String htmlcontent)throws MessagingException{
     BodyPart bodypart=new MimeBodyPart();
     bodypart.setContent(htmlcontent,"text/html;charset=GB2312");
     bodypartArrayList.add(bodypart);
    }
    //将文件添加为附件
    public void addAttachment(String FileName/*附件文件名*/,String DisplayFileName/*在邮件中想要显示的文件名*/)
        throws MessagingException,UnsupportedEncodingException{
     BodyPart bodypart=new MimeBodyPart();
        FileDataSource fds=new FileDataSource(FileName);
        
        DataHandler dh=new DataHandler(fds);
        String displayfilename="";
  displayfilename = MimeUtility.encodeWord(DisplayFileName,"gb2312", null);//对显示名称进行编码，否则会出现乱码！
  
  bodypart.setFileName(displayfilename);//可以和原文件名不一致
        bodypart.setDataHandler(dh);
     bodypartArrayList.add(bodypart);
    }
    //将byte[]作为文件添加为附件
    public void addAttachmentFrombyte(byte[] filebyte/*附件文件的字节数组*/,String DisplayFileName/*在邮件中想要显示的文件名*/)
        throws MessagingException,UnsupportedEncodingException{
     BodyPart bodypart=new MimeBodyPart();
     ByteDataSource fds=new ByteDataSource(filebyte,DisplayFileName);
       
        DataHandler dh=new DataHandler(fds);
        String displayfilename="";
  displayfilename = MimeUtility.encodeWord(DisplayFileName,"gb2312", null);//对显示名称进行编码，否则会出现乱码！
  
  bodypart.setFileName(displayfilename);//可以和原文件名不一致
        bodypart.setDataHandler(dh);
     bodypartArrayList.add(bodypart);
    }

    
    //使用远程文件（使用URL）作为信件的附件
    public void addAttachmentFromUrl(String url/*附件URL地址*/,String DisplayFileName/*在邮件中想要显示的文件名*/)
        throws MessagingException,MalformedURLException,UnsupportedEncodingException{
     BodyPart bodypart=new MimeBodyPart();
        //用远程文件作为信件的附件
        URLDataSource ur= new URLDataSource(new URL(url));
        //注:这里用的参数只能为URL对象,不能为URL字串
  DataHandler dh=new DataHandler(ur);
  String displayfilename="";
        displayfilename=MimeUtility.encodeWord(DisplayFileName,"gb2312", null);
  bodypart.setFileName(displayfilename);//可以和原文件名不一致
  bodypart.setDataHandler(dh);
  bodypartArrayList.add(bodypart);
    }

    
    //设置发件人地址
    public void setMailFrom(String mailFrom)throws MessagingException{
        mailFromAddress = new InternetAddress(mailFrom);
        mailMessage.setFrom(mailFromAddress);
    }
    //设置收件人地址，收件人类型为to,cc,bcc(大小写不限)
    public void setMailTo(String[] mailTo,String mailType)throws Exception{
        for(int i=0;i<mailTo.length;i++){
            mailToAddress = new InternetAddress(mailTo[i]);
            if(mailType.equalsIgnoreCase("to")){
                mailMessage.addRecipient(Message.RecipientType.TO,mailToAddress);
            }
            else if(mailType.equalsIgnoreCase("cc")){
                mailMessage.addRecipient(Message.RecipientType.CC,mailToAddress);
            }
            else if(mailType.equalsIgnoreCase("bcc")){
                mailMessage.addRecipient(Message.RecipientType.BCC,mailToAddress);
            }
            else{
                throw new Exception("Unknown mailType: "+mailType+"!");
            }
        }
    }
    //开始投递邮件
    public void sendMail()throws MessagingException,SendFailedException{
     for (int i=0;i<bodypartArrayList.size();i++) {
      multipart.addBodyPart((BodyPart)bodypartArrayList.get(i)); 
     }
     mailMessage.setContent(multipart);
        mailMessage.saveChanges();
        Transport transport=mailSession.getTransport("smtp");
        transport.connect(smtpserver,name,password);//以smtp方式登录邮箱
        transport.sendMessage(mailMessage,mailMessage.getAllRecipients());
        //发送邮件,其中第二个参数是所有已设好的收件人地址
        transport.close();
    }

}


