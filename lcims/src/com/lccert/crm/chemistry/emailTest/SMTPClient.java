//package com.lccert.crm.chemistry.emailTest;
//import java.io.BufferedReader;
//import java.io.BufferedWriter;
//import java.io.IOException;
//import java.io.InputStreamReader;
//import java.io.OutputStreamWriter;
//import java.net.Socket;
//import java.net.SocketException;
//import java.net.UnknownHostException;
//import java.util.StringTokenizer;
//
//import com.lccert.crm.chemistry.email.EmailList;
//
//import sun.misc.BASE64Encoder;
//
///** 
// * SMTP�ͻ��˵�����
// * @author Rockay(���䳬,����) 
// * http://www.cnblogs.com/Rockay
// */ 
//
//public class SMTPClient {
// 
// public SMTPClient()
// {
//  
// }
//  private boolean debug=true;
//  BASE64Encoder encode=new BASE64Encoder();//���ڼ��ܺ����û���������
//  
//  public boolean Send(String server,String from,String[] to,String[] cc,String[] bc,
//    String subject,String content,String user,String pwd) throws UnknownHostException, IOException
//  {
//   MailMessage message=new MailMessage();
//   message.setFrom(from);//������
//   for(int i=0;i<to.length;i++)
//   {
//    message.setTo(to[i]);//�ռ���
//    message.setDatato(to[i]);//�ռ��ˣ����ʼ����ռ�����Ŀ����ʾ
//   }
//   for(int i=0;i<cc.length;i++)
//   {
//    message.setCc(cc[i]);//�ռ���
//   }
//   for(int i=0;i<bc.length;i++)
//   {
//    message.setBc(bc[i]);//�ռ���
//   }
//   message.setDatafrom(from);//�����ˣ����ʼ��ķ�������Ŀ����ʾ
//   
//   message.setSubject(subject);//�ʼ�����
//   message.setContent(content);//�ʼ�����
//   message.setUser(user);//��½������û���
//   message.setPassword(pwd);//��½���������
//    
//   SMTPClient smtp=new SMTPClient(server,25);
//   boolean flag;
//   flag=smtp.sendMail(message,server);
//   if(flag){
//   System.out.println("�ʼ����ͳɹ���");
//   }
//   else{
//    System.out.println("�ʼ�����ʧ�ܣ�");
//   }
//   return flag;
//  }
//  
//  private Socket socket;
//  public SMTPClient(String server,int port) throws UnknownHostException, IOException{
//   try{
//    socket=new Socket(server,25);
//   }catch(SocketException e){
//    System.out.println(e.getMessage());
//   }catch(Exception e){
//    e.printStackTrace();
//   }finally{
//    System.out.println("�Ѿ���������!");
//   }
//
//  }
//  //ע�ᵽ�ʼ�������
//  public void helo(String server,BufferedReader in,BufferedWriter out) throws IOException{
//   int result;
//   result=getResult(in);
//   //�������ʼ������,����������220Ӧ��
//   if(result!=220){
//    throw new IOException("���ӷ�����ʧ��");
//   }
//   result=sendServer("HELO "+server,in,out);
//   //HELO����ɹ��󷵻�250
//   if(result!=250)
//   {
//    throw new IOException("ע���ʼ�������ʧ�ܣ�");
//   }
//  }
//  
//  private int sendServer(String str,BufferedReader in,BufferedWriter out) throws IOException{
//   out.write(str);
//   out.newLine();
//   out.flush();
//   if(debug)
//   {
//    System.out.println("�ѷ�������:"+str);
//   }
//   return getResult(in);
//  }
//  
//  public int getResult(BufferedReader in){
//   String line="";
//   try{
//    line=in.readLine();
//    if(debug){
//     System.out.println("����������״̬:"+line);
//    }
//   }catch(Exception e){
//    e.printStackTrace();
//   }
//   //�ӷ�����������Ϣ�ж���״̬��,����ת������������
//   StringTokenizer st=new StringTokenizer(line," ");
//   return Integer.parseInt(st.nextToken());
//  }
//  
//  public void authLogin(MailMessage message,BufferedReader in,BufferedWriter out) throws IOException{
//   int result;
//   result=sendServer("AUTH LOGIN",in,out);
//   if(result!=334){
//    throw new IOException("�û���֤ʧ�ܣ�");
//   }
//   
//    result=sendServer(encode.encode(message.getUser().getBytes()),in,out);
//    if(result!=334){
//    throw new IOException("�û�������"); 
//    }
//    result=sendServer(encode.encode(message.getPassword().getBytes()),in,out);
//   
//    if(result!=235){
//     throw new IOException("��֤ʧ�ܣ�"); 
//   }
//  }
//  //��ʼ������Ϣ���ʼ�Դ��ַ
//  public void mailfrom(String source,BufferedReader in,BufferedWriter out) throws IOException{
//   int result;
//   result=sendServer("MAIL FROM:<"+source+">",in,out);
//   if(result!=250){
//    throw new IOException("ָ��Դ��ַ����");
//   }
//  }
//  // �����ʼ��ռ���
//  public void rcpt(String touchman,BufferedReader in,BufferedWriter out) throws IOException{
//   int result;
//   result=sendServer("RCPT TO:<"+touchman+">",in,out);
//   if(result!=250){
//    throw new IOException("ָ��Ŀ�ĵ�ַ����");
//   }
//  }
//  
//  //�ʼ���
//  public void data(String from,String to,String subject,String content,BufferedReader in,BufferedWriter out) throws IOException{
//   int result;
//   result=sendServer("DATA",in,out);
//   //����DATA�س���,���յ�354Ӧ���,���������ʼ�����
//   if(result!=354){
//    throw new IOException("���ܷ�������");
//   }
//   out.write("From: "+from);
//   out.newLine();
//   out.write("To: "+to);
//   out.newLine();
//   out.write("Subject: "+subject);
//   out.newLine();
//   out.newLine();
//   out.write(content);
//   out.newLine();
//   //��żӻس������ʼ���������
//   result=sendServer(".",in,out);
//   System.out.println(result);
//   if(result!=250)
//   {
//    throw new IOException("�������ݴ���");
//   }
//  }
//  
//  //�˳�
//  public void quit(BufferedReader in,BufferedWriter out) throws IOException{
//   int result;
//   result=sendServer("QUIT",in,out);
//   if(result!=221){
//    throw new IOException("δ����ȷ�˳�");
//   }
//  }
//  
//  //�����ʼ�������
//  public boolean sendMail(MailMessage message,String server){
//   try{
//    BufferedReader in=new BufferedReader(new InputStreamReader(socket.getInputStream()));
//    BufferedWriter out=new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
//    helo(server,in,out);//HELO����
//    authLogin(message,in,out);//AUTH LOGIN����
//    mailfrom(message.getFrom(),in,out);//MAIL FROM
//    rcpt(message.getTo(),in,out);//RCPT
//    data(message.getDatafrom(),message.getDatato(),message.getSubject(),message.getContent(),in,out);//DATA
//    quit(in,out);//QUIT
//   }catch(Exception e){
//    e.printStackTrace();
//    return false;
//    
//   }
//   return true;
//  }
//}
//

