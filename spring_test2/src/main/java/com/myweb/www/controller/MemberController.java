package com.myweb.www.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.www.security.MemberVO;
import com.myweb.www.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/member/*")
@Controller
@RequiredArgsConstructor
public class MemberController {

	private final MemberService msv;
	private final BCryptPasswordEncoder bcEncoder;
	
	@GetMapping("/register")
	public void register() {
	}
	
	@PostMapping("/register")
	public String register(MemberVO mvo) {
		mvo.setPwd(bcEncoder.encode(mvo.getPwd()));
		log.info(">>>> register >> mvo>> {}"+ mvo);
		int isOK = msv.register(mvo);
		log.info(""+isOK);
		return "index";
	}
	
	@GetMapping("/login")
	public void login() {}
	
	@PostMapping("/login")
	public String loginPost(HttpServletRequest request, RedirectAttributes re) {
		//로그인 실패시 다시 로그인 페이지로 돌아와 오류메시지 전송
		re.addAttribute("email", request.getAttribute("email"));
		re.addAttribute("errMsg", request.getAttribute("errMsg"));
		
		
		return "redirect:/member/login";
	}
	
	//@RequestParam("email")String email : 쿼리스트링 (파라미터 받기)
	@GetMapping("/modify")
	public void modify(Principal p, Model m) {
		log.info(">>>> principal >> email >>"+p.getName());
		String email = p.getName();
		m.addAttribute("mvo", msv.detail(email));
	}
	
	
	@PostMapping("/modify")
	public String modify(MemberVO mvo, HttpServletRequest request, HttpServletResponse response) {
		if(mvo.getPwd().isEmpty()) {
			//비번없는 업데이트 진행
			msv.noPwd(mvo);
		}else {
			//비번을 다시 인코딩 하여 업데이트 진행
			mvo.setPwd(bcEncoder.encode(mvo.getPwd()));
			msv.yesPwd(mvo);
		}
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		new SecurityContextLogoutHandler().logout(request, response, authentication);
		
		return "/member/login";
	}
	
	@GetMapping("/list")
	public void list(Model m) {
		List<MemberVO> list = msv.getList();
		m.addAttribute("mvo", list);
	}
	
	@GetMapping("/remove")
	public String removeMember(@RequestParam("email")String email, HttpServletRequest request, HttpServletResponse response) {
		msv.remove(email);
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		new SecurityContextLogoutHandler().logout(request, response, authentication);
		return "index";
	}
}
