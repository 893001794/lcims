package com.temp;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.security.Security;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.FetchProfile;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.URLName;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;


public class RecvMail
{
 public RecvMail() { }
 
 private String protocol = null;
    private String pop3host = null;    
    private String username = null;
    private String password = null;
    private String savePath = null;
    private int pop3port = 110;

 
 /**
  * @function 设置接收邮件参数
  * @param prot
  * @param host
  * @param mail
  * @param pswd
  */
 public void setParams(String prot, String host, String user, String pswd)
 {
  protocol = prot;
  pop3host = host;
  username = user;
  password = pswd;
 }
 
 /**
  * @function 设置附件存放目录
  * @param dir
  */
 public void setSavePath(String dir)
 {
  savePath = (dir==null?"/":dir.trim().toLowerCase());  
  File f = new File(savePath);
  if (f.mkdirs()) System.out.println("创建目录~ "+f.isDirectory());
  else  System.out.println("目录存在~ "+f.isDirectory());
 }
 
 
 /**
  * @fucntion 设置接收端口
  * @param port
  */
 public void setPort(int port)
 {
  pop3port = (port<1?pop3port:port);
 }
 

 
 private void debugRecs(String[] recs)
 {
  String[] kws = {"msg id", "need reply", "msg size", "msg num", "send date", "recv date", "mail from", "mail to", "mail cc", "mail bcc", "mail subject", "content", "attachs path"};
  StringBuffer msg = new StringBuffer(1200); //, "attachs file", "count"
  msg.append("---------------------------------------------\n");
  for (int i=0; i<kws.length; i++) msg.append(kws[i]).append(": ").append(recs[i]).append(" \n");
  System.out.println(msg.toString());
  msg = null;
 }
 
 private String getMessageId(MimeMessage msg)
    {
        try { return msg.getMessageID(); } catch (Exception e) { }
        return "";
    }
 
    private File buildFile(String fileName)
    {
        File file = new File(fileName);
        int lastDot = fileName.lastIndexOf(".");
        String extension = fileName.substring(lastDot);
        fileName = fileName.substring(0, lastDot);
        for (int i = 0; file.exists(); i++) file = new File(fileName + i + extension);
        return file;
    }
    
 private boolean isNeedReply(MimeMessage msg)
    {
  String head[] = null;
        try { head = msg.getHeader("Disposition-Notification-To"); } catch (Exception e) { }
  return (head==null);
    }
 
 
 /**
  * @function 解析单条邮件消息
  * @param msg
  * @return
  */
 private String[] parseMessage(MimeMessage msg)
 {
  int idx = 0;
        String[] recs = new String[20];        
        recs[idx++] = getMessageId(msg); //MSGID
        recs[idx++] = isNeedReply(msg)?"0":"1"; //NeedReply
        recs[idx++] = String.valueOf(getMessageSize(msg)); //SIZE
        recs[idx++] = String.valueOf(msg.getMessageNumber()); //MSGNUM
        recs[idx++] = String.valueOf(getSendDate(msg)); //SEND
        recs[idx++] = String.valueOf(getRecvDate(msg)); //RECV
        recs[idx++] = getMessageFrom(msg).toLowerCase();//FROM
        recs[idx++] = parseMessageAddress(msg, 1); //TO
        recs[idx++] = parseMessageAddress(msg, 2); //CC
        recs[idx++] = parseMessageAddress(msg, 3); //BCC       
        recs[idx++] = getMessageSubject(msg); //SUBJECT
        String[] arr = parseMessagePart(msg);
        recs[idx++] = toStr(arr[0]); //CONTENT
        recs[idx++] = toStr(arr[1]); //ATTACHS PATH       
        if (false) debugRecs(recs);
        return recs;
 }
 
 


 private String parseMessageAddress(MimeMessage msg, int type)
 {
  if (msg==null) return "";
  try
  {
   InternetAddress[] address = null;
   switch (type)
   {
    case 1: 
     address = (InternetAddress[])msg.getRecipients(Message.RecipientType.TO);
     break;
    case 2: 
     address = (InternetAddress[])msg.getRecipients(Message.RecipientType.CC);
     break;
    case 3: 
     address = (InternetAddress[])msg.getRecipients(Message.RecipientType.BCC);
     break;
    default:
     break;
   } 
   StringBuffer mails = new StringBuffer(1200);
   int len = (address==null?0:address.length);  
   for (int i=0; i<len; i++) mails.append(address[i].getAddress()).append(";");
   address = null;
   return mails.toString().toLowerCase();
  }
  catch (Exception e)
  {
   System.err.println("parseMessageAddress: "+e);
  }
  return "";
 } 
 
 /**
  * @function 分析邮件组成
  * @param msg
  * @return
  */
 private String[] parseMessagePart(MimeMessage msg)
    {
        //1.读出邮件内容
        //2.读出邮件附件
        //3.附件命名规则[防止重复]
        //4.确定邮件内容[小于多少直接到邮件内容中,否则就按附件] * 65536

  try
        {
            Object content = msg.getContent();
            if (content instanceof Multipart)
            {
             System.out.println("### ---> "+content.getClass().getName());
             return handleMultipart((Multipart)content);
            }
            else
            {
             System.out.println("$$$ ---> "+content.getClass().getName());
             return handlePart(msg);
            }
        }
        catch (Exception e)
        {
            System.err.println("[parseMessagePart] error:"+e);
        }
        return (new String[2]);
    }
 
 
    private String[] handleMultipart(Multipart mpart)
    {
     StringBuffer list = new StringBuffer(360);
     String txt = null;
        Part part = null;
     int len = 0;
        try { len = mpart.getCount(); } catch (Exception e) { }
        for (int i=0; i<len; i++)
        {
            try { part = mpart.getBodyPart(i); } catch (Exception e) { }
            String[] arr = handlePart(part);
            if (toStr(txt).length()<3) txt = toStr(arr[0]);
            if (toStr(arr[1]).length()>3) list.append(toStr(arr[1])).append(";");
        }
        return (new String[]{txt, list.toString()});
    }
    
 
 

    

    

        
 private String[] handlePart(Part part) 
    {
  String[] arr = {"",""}; //[content][filenames][filesize]
  if (part==null) return arr;

        try
        {
         File file = null;
         String contentType = toStr(part.getContentType());
         String disposition = toStr(part.getDisposition());         
         String fileName = toStr(part.getFileName());
         if (fileName.startsWith("=?")) fileName = MimeUtility.decodeText(fileName);         
         if (contentType.indexOf("name=")>0)
         {
          file = saveFile(savePath+fileName, part.getInputStream());
         }
         else if (disposition.equals(Part.ATTACHMENT) || disposition.equals(Part.INLINE))
         {
          file = saveFile(savePath+fileName, part.getInputStream());
         }
         else if (part.isMimeType("multipart/alternative") || part.isMimeType("multipart/related") ||           
             part.isMimeType("multipart/mixed") || part.isMimeType("multipart/*") )
            {
          String[] kk = handleMultipart((Multipart)(part.getContent()));
          if (toStr(arr[0]).length()<3) arr[0] = toStr(kk[0]);
          if (toStr(arr[1]).length()>3) arr[1] += toStr(kk[1])+";";
            }
         else if (part.isMimeType("text/html"))
         {
          if (toStr(arr[0]).length()<3) arr[0] = toStr(part.getContent());
          else file = saveFile(savePath+"邮件内容.htm", toStr(part.getContent()));
         }
         else if (part.isMimeType("text/plain"))
         {
          if (toStr(arr[0]).length()<3) arr[0] = toStr(part.getContent());
          else file = saveFile(savePath+"邮件内容.txt", toStr(part.getContent()));
         }
         else
         {
          Object obj = part.getContent();
          if (obj!=null && obj instanceof com.sun.mail.util.BASE64DecoderStream)
          {
           //System.err.println("ZZZ ~ ~ contentType: ["+contentType+"] ~ >> file:"+fileName);
           file = saveFile(savePath+"附件.gif", part.getInputStream());          
          }
          else
          {
           //System.err.println("YYYY ~ ~ contentType: ["+contentType+"] ~ >> file:"+fileName);
           if (toStr(arr[0]).length()<3) arr[0] = saveAsStr(part.getInputStream());
           else file = saveFile(savePath+"邮件内容.txt", part.getInputStream());
          }
         }         
         if (file!=null && file.exists()) arr[1] += file.getName()+";";         
        }
        catch (Exception e)
        {
         System.err.println("@@ handlePart >> "+e);
        }
        return arr;
    }
 
    private String getMessageSubject(MimeMessage msg)
    {
        try
        {
         String head = toStr(msg.getHeader("Subject")[0]);
         boolean test = head.toLowerCase().startsWith("=?gb") || head.toLowerCase().startsWith("=?utf-8");
            String cs = "iso-8859-1";
            if (head.toLowerCase().startsWith("=?us-assic")) cs = "us-assic";            
            return (test?MimeUtility.decodeText(head):(new String(head.getBytes(cs))));
        }
        catch (Exception e)
        {
            System.err.println("getMessageSubject: "+e);
        }
        return "";
    }
    
    
    

    
    private long getRecvDate(MimeMessage msg)
    {
        Date d = null;
        try { d = msg.getReceivedDate(); }  catch (Exception e) { }
        return (d==null?0l:d.getTime());
    }
 
    private long getSendDate(MimeMessage msg)
    {
        Date d = null;
        try { d = msg.getSentDate(); }  catch (Exception e) { }
        return (d==null?0l:d.getTime());
    }
 
 private String getMessageFrom(MimeMessage msg)
    {
        try
        {
         InternetAddress[] address = (InternetAddress[])(msg==null?null:msg.getFrom());
            if (address==null) return "";
            return address[0].getAddress(); //address[0].getPersonal()
        }
        catch (Exception e)
        {
            System.err.println("[getFrom] error:"+e);
        }
        return "";        
    }
 
    private int getMessageSize(MimeMessage msg)
    {
        try { return msg.getSize(); } catch (Exception e) { }
        return 0;
    }
    
    private File saveFile(String fileName, InputStream in) 
    {
     File file = null;
        try 
        {
         file = buildFile(fileName);
            FileOutputStream  out = new FileOutputStream(file);
            int read = 0;
            byte[] bytes = new byte[2048];
            while ((read = in.read(bytes))>-1) out.write(bytes, 0, read);
            out.flush();
            out.close();
            in.close(); 
        }
        catch (Exception e)
        {         
         System.err.println("[saveFile] [InputStream] ~ "+e);
        }   
        return file;
    }
    
    private File saveFile(String fileName, String data) 
    {
     File file = null;
        try 
        {
         file = buildFile(fileName);
         BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(file));
         out.write(data.getBytes());
         out.close();
        }
        catch (Exception e)
        {         
         System.err.println("[saveFile] [String] ~ "+e);
        }
        return file;
    }
    
    private String saveAsStr(InputStream in) 
    {
        try 
        { 
         String str = null;
         ByteArrayOutputStream out = new ByteArrayOutputStream();
            int read = 0;
            byte[] bytes = new byte[2048];
            while ( (read = in.read(bytes)) > 0) out.write(bytes, 0, read);            
            out.flush();
            str = out.toString();
            out.close();
            in.close();
            return str;
        }
        catch (Exception e)
        {         
         System.err.println("[saveFile] [InputStream] ~ "+e);
        }   
        return "";
    }
        
 /**
  * @function 对象转为字符串
  * @param obj
  * @return
  */
 private String toStr(Object obj)
 {
  return (obj==null?"":obj.toString().trim());
 }
 
 /**
  * @function 计算所用时间
  * @param start
  * @return
  */
 private static long cost(long start)
 {
  return System.currentTimeMillis()-start;
 }
 
 /**
  * 接收普通邮件
  */
 public List recvMail()
 {
        Properties props = System.getProperties();
        if (pop3port==995)
        {
      Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
      props.setProperty("mail.pop3.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
      props.setProperty("mail.pop3.socketFactory.fallback", "false");
      props.setProperty("mail.pop3.port", "995");
      props.setProperty("mail.pop3.socketFactory.port", "995");
        }
        else
        {
            props.put("mail.smtp.auth", "true");
        }

        Store store = null;
  Folder inbox = null;
  try 
  {
   Session session = Session.getDefaultInstance(props, null);
   URLName url = new URLName(protocol, pop3host, pop3port, null, username, password); 
   store = session.getStore(url);
   store.connect();
   inbox = store.getFolder("INBOX");
   inbox.open(Folder.READ_ONLY); 
   FetchProfile profile = new FetchProfile(); //Folder.READ_ONLY Folder.READ_WRITE
   profile.add(FetchProfile.Item.ENVELOPE); //FetchProfile.Item.FLAGS FetchProfile.Item.CONTENT_INFO
   Message[] messages = inbox.getMessages();
   inbox.fetch(messages, profile);
   int num = (messages==null?0:messages.length);
   List list = new ArrayList();
   for (int i=0; i<num; i++) list.add(parseMessage((MimeMessage)messages[i]));
   return list;
  }
  catch (Exception e)
  {
   System.err.println("接收邮件出错: "+e);
  }
  finally
  {
   try { inbox.close(false); } catch (Exception e) { }
   try { store.close(); } catch (Exception e) { }
  }
  return (new ArrayList());
  
 }
  
 public static void main(String argv[]) throws Exception
 {
  long start = System.currentTimeMillis();
  System.out.println("开始读取邮件......");
  RecvMail tc = new RecvMail();
  //tc.setParams("pop3", "pop.gmail.com", "yourgmail@gmail.com", "yourpassword");
  //tc.setPort(995); //just for ssl port as 995
  //tc.setParams("pop3", "pop.163.com", "yourgmail@163.com", "yourpassword");
//  tran.connect("192.168.0.241", "lcims@lccert.com", "12345678");
  tc.setParams("pop3", "pop.21cn.com", "yourgmail@21cn.com", "yourpassword");
  tc.setSavePath("C:\\1.eml");
  List list = tc.recvMail();
  System.out.println("读取邮件完毕! cost: "+cost(start));
  start = System.currentTimeMillis();
  for (int i=0; i<list.size(); i++)
  {
   //do something here ...
  }
  System.out.println("处理邮件完毕! cost: "+cost(start));
 } 
}



//本文来自CSDN博客，转载请标明出处：http://blog.csdn.net/huangyp2008/archive/2009/02/28/3945540.aspx