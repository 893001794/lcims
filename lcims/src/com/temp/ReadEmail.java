package com.temp;
import  java.util.*;
import  java.io.*;
import  javax.mail.*;
import  javax.mail.internet.*;


public class ReadEmail {

   public static void main(String args[]) throws Exception{
       display(new File("C:\\1.eml"));
   }

   public static void display(File emlFile) throws Exception{
        Properties props = System.getProperties();
        props.put("mail.host", "smtp.dummydomain.com");
        props.put("mail.transport.protocol", "smtp");

        Session mailSession = Session.getDefaultInstance(props, null);
        InputStream source = new FileInputStream(emlFile);
        MimeMessage message = new MimeMessage(mailSession, source);


        System.out.println("Subject : " + message.getSubject());
        System.out.println("From : " + message.getFrom()[0]);
        System.out.println("--------------");
        System.out.println("Body : " +  message.getContent());
        //2   
        Multipart mp = (Multipart)message.getContent();   
        int count = mp.getCount();   
        MimeBodyPart body_part=null;   
        for (int i = 0; i < count; i++){   
            body_part = (MimeBodyPart) mp.getBodyPart(i);   
            System.out.println(body_part.getContent());   
        }   
        //BufferedReader reader = new BufferedReader (new InputStreamReader(System.in));// Get directoryMessage message[] = folder.getMessages();for (int i=0, n=message.length; i<n; i++) {  System.out.println(i + ": " + message[i].getFrom()[0]     + "\t" + message[i].getSubject());  System.out.println("Do you want to read message? " +    "[YES to read/QUIT to end]");  String line = reader.readLine();  if ("YES".equals(line)) {    message[i].writeTo(System.out);  } else if ("QUIT".equals(line)) {    break;  }}

    }
   
   
   
   public static Object getContent(Part part) throws MessagingException, IOException{   
       /*1.  
                 if (part.isMimeType("text/plain")) {  
           return (String) part.getContent();  
       } else if (part.isMimeType("text/html")) {  
           return (String) part.getContent();  
       }else if (part.isMimeType("multipart/*")) {  
           Multipart multipart = (Multipart) part.getContent();  
           return getContent(multipart.getBodyPart(0));  
       }else if (part.isMimeType("message/rfc822")) {  
           return getContent((Part) part.getContent());  
       }  
       return "";*/  
                 //2   
       Multipart mp = (Multipart)part.getContent();   
       int count = mp.getCount();   
       MimeBodyPart body_part=null;   
       for (int i = 0; i < count; i++){   
           body_part = (MimeBodyPart) mp.getBodyPart(i);   
           return (Object) body_part.getContent();   
       }   
       return "";   
   }  



}

