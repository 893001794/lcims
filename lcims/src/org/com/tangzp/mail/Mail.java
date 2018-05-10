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
        mailProperties.put("mail.smtp.auth","true"); //����smtp��֤���ܹؼ���һ��
        mailSession = Session.getDefaultInstance(mailProperties);
        //mailSession.setDebug(true);
        
        mailMessage = new MimeMessage(mailSession);
        multipart = new MimeMultipart();
        bodypartArrayList=new ArrayList();//�������BodyPart�������ж��BodyPart��
    }
    //�����ʼ�����
    public void setSubject(String mailSubject)throws MessagingException{
        this.mailSubject = mailSubject;
        mailMessage.setSubject(mailSubject);
    }
    //�����ʼ���������
    public void setSendDate(Date sendDate)throws MessagingException{
        this.mailSendDate = sendDate;
        mailMessage.setSentDate(sendDate);
    }
    //���ʹ��ı�
    public void addTextContext(String textcontent)throws MessagingException{
     BodyPart bodypart=new MimeBodyPart();
     bodypart.setContent(textcontent,"text/plain;charset=GB2312");
     bodypartArrayList.add(bodypart);
    }
    //����Html�ʼ�
    public void addHtmlContext(String htmlcontent)throws MessagingException{
     BodyPart bodypart=new MimeBodyPart();
     bodypart.setContent(htmlcontent,"text/html;charset=GB2312");
     bodypartArrayList.add(bodypart);
    }
    //���ļ����Ϊ����
    public void addAttachment(String FileName/*�����ļ���*/,String DisplayFileName/*���ʼ�����Ҫ��ʾ���ļ���*/)
        throws MessagingException,UnsupportedEncodingException{
     BodyPart bodypart=new MimeBodyPart();
        FileDataSource fds=new FileDataSource(FileName);
        
        DataHandler dh=new DataHandler(fds);
        String displayfilename="";
  displayfilename = MimeUtility.encodeWord(DisplayFileName,"gb2312", null);//����ʾ���ƽ��б��룬�����������룡
  
  bodypart.setFileName(displayfilename);//���Ժ�ԭ�ļ�����һ��
        bodypart.setDataHandler(dh);
     bodypartArrayList.add(bodypart);
    }
    //��byte[]��Ϊ�ļ����Ϊ����
    public void addAttachmentFrombyte(byte[] filebyte/*�����ļ����ֽ�����*/,String DisplayFileName/*���ʼ�����Ҫ��ʾ���ļ���*/)
        throws MessagingException,UnsupportedEncodingException{
     BodyPart bodypart=new MimeBodyPart();
     ByteDataSource fds=new ByteDataSource(filebyte,DisplayFileName);
       
        DataHandler dh=new DataHandler(fds);
        String displayfilename="";
  displayfilename = MimeUtility.encodeWord(DisplayFileName,"gb2312", null);//����ʾ���ƽ��б��룬�����������룡
  
  bodypart.setFileName(displayfilename);//���Ժ�ԭ�ļ�����һ��
        bodypart.setDataHandler(dh);
     bodypartArrayList.add(bodypart);
    }

    
    //ʹ��Զ���ļ���ʹ��URL����Ϊ�ż��ĸ���
    public void addAttachmentFromUrl(String url/*����URL��ַ*/,String DisplayFileName/*���ʼ�����Ҫ��ʾ���ļ���*/)
        throws MessagingException,MalformedURLException,UnsupportedEncodingException{
     BodyPart bodypart=new MimeBodyPart();
        //��Զ���ļ���Ϊ�ż��ĸ���
        URLDataSource ur= new URLDataSource(new URL(url));
        //ע:�����õĲ���ֻ��ΪURL����,����ΪURL�ִ�
  DataHandler dh=new DataHandler(ur);
  String displayfilename="";
        displayfilename=MimeUtility.encodeWord(DisplayFileName,"gb2312", null);
  bodypart.setFileName(displayfilename);//���Ժ�ԭ�ļ�����һ��
  bodypart.setDataHandler(dh);
  bodypartArrayList.add(bodypart);
    }

    
    //���÷����˵�ַ
    public void setMailFrom(String mailFrom)throws MessagingException{
        mailFromAddress = new InternetAddress(mailFrom);
        mailMessage.setFrom(mailFromAddress);
    }
    //�����ռ��˵�ַ���ռ�������Ϊto,cc,bcc(��Сд����)
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
    //��ʼͶ���ʼ�
    public void sendMail()throws MessagingException,SendFailedException{
     for (int i=0;i<bodypartArrayList.size();i++) {
      multipart.addBodyPart((BodyPart)bodypartArrayList.get(i)); 
     }
     mailMessage.setContent(multipart);
        mailMessage.saveChanges();
        Transport transport=mailSession.getTransport("smtp");
        transport.connect(smtpserver,name,password);//��smtp��ʽ��¼����
        transport.sendMessage(mailMessage,mailMessage.getAllRecipients());
        //�����ʼ�,���еڶ�����������������õ��ռ��˵�ַ
        transport.close();
    }

}


