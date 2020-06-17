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
	    for(int i=0;i<4;i++) {
	        //0~9 까지 난수 생성
	        String ran = Integer.toString(rand.nextInt(10000));
	        signUpEmailNumStr = ran;
	    }
        try {
            message.setSubject("FanstayStock입니다. 회원가입 이메일인증입니다.");
            message.setText("안녕하세요.\n인증번호는 ["+signUpEmailNumStr+"] 입니다.\n인증번호입력창에 입력해주세요.");
            message.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(id));
            mailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}