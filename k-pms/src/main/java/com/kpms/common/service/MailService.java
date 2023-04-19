package com.kpms.common.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.kpms.common.vo.MailVO;

@Service
public class MailService {

	@Autowired
	private JavaMailSender mailSender;
	
	public void sendMail(MailVO mailVO) {
		MimeMessage mail = mailSender.createMimeMessage();
		MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
		try {
			mailHelper.setFrom(mailVO.getFrom());
			mailHelper.setTo(mailVO.getTo());
			mailHelper.setSubject(mailVO.getSubject());
			mailHelper.setText(mailVO.getContent());
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		mailSender.send(mail);
	}
	
}
