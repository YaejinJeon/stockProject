package com.bitcamp.project.view.user;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

 
	@Controller
	public class SignUpMailController {
		public static String signUpEmailNumStr = ""; //난수가 저장될 변수
	    @Autowired
	    private JavaMailSender mailSender;
	    
	    @RequestMapping(value="/user/signUp/mail")
	    public String signUpSendMail(@ModelAttribute("id") String id){
	        MimeMessage message = mailSender.createMimeMessage();
				
	        	Random rand = new Random();
				String ranNum = Integer.toString(rand.nextInt(8) + 1);
				for (int i = 0; i < 5; i++) {
					ranNum += Integer.toString(rand.nextInt(9));
				}
				
				String ran = ranNum;
	        
		        signUpEmailNumStr = ran;
		        System.out.println("생성된 난수 : " + signUpEmailNumStr);
	        try {
	            message.setSubject("FantasyStock입니다. 회원가입 이메일인증입니다.");
	            message.setText("안녕하세요.\n인증번호는 ["+signUpEmailNumStr+"] 입니다.\n인증번호입력창에 입력해주세요.");
	            message.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(id));
	            mailSender.send(message);
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        }
	        
	        return null;
	    }
	}