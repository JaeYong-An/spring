package com.myweb.www.security;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import com.myweb.www.service.MemberService;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@ToString
@Slf4j
@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Getter
	@Setter
	private String authEmail;
	
	@Setter
	@Getter
	private String authUrl;
	
	//해당 정보를 가지고 리다이렉트하는 역할
	private RedirectStrategy rdstg = new DefaultRedirectStrategy();
	//실제 로그인 정보, 경로등을 저장
	private RequestCache reqCache = new HttpSessionRequestCache();
	
	@Inject
	private MemberService msv;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// Authentication 인증된 객체
		setAuthEmail(authentication.getName());
		setAuthUrl("/board/list");
		
		boolean isOK = msv.updateLastLogin(getAuthEmail());

		HttpSession ses = request.getSession();
		
		ses.setAttribute("ses", getAuthEmail());
		
		log.info("loginSuccess >> ses>>"+ses.toString());
		
		if(!isOK || ses==null) {
			return;
		}else {
			//시큐리티에서 로그인을 시도하면 시도한 로그인 기록 남게됨
			//이전에 사도한 시큐리티의 인증 실패 기록 삭재]
			ses.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
		}
	SavedRequest saveReq = reqCache.getRequest(request, response);
	rdstg.sendRedirect(request, response, (saveReq != null ? saveReq.getRedirectUrl():getAuthUrl()));
	}

}
