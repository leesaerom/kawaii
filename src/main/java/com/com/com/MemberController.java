package com.com.com;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSpinnerUI;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.EntityAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.cloud.vision.v1.LocationInfo;
import com.google.protobuf.ByteString;

import DAO.MemberMapper;
import DAO.imageMapper;
import VO.Member;
import VO.MyImage;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MemberController {
	
	@Autowired
	SqlSession sqlSession;
	
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		
		return "login";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		
		return "join";
	}
	
	@RequestMapping(value = "/joinup", method = RequestMethod.GET)
	public String join(Member member, HttpSession session) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		System.out.println(member.getNickname());
		if(member.getNickname() == null) {
			member.setNickname("별명없음");
			System.out.println(member);
		}
		System.out.println(member.getNickname());
		mapper.registerMember(member);
		
		return "login";
	}
	
	@RequestMapping(value = "/signin", method = RequestMethod.POST)
	public String login(Member member, HttpSession session) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		
		Member m = mapper.selectOne(member);
		
		session.setAttribute("userid", m.getUserid());
		session.setAttribute("userpassword", m.getUserpassword());
		session.setAttribute("nickname", m.getNickname());
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
}
