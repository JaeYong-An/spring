<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <jsp:include page="../layout/header.jsp"/>
	<jsp:include page="../layout/nav.jsp"/>
	<div class="container my-3">
		<form action="/member/login" method="post">
	
			<div class="mb-3">
			  <label for="e" class="form-label">이메일</label>
			  <input type="email" name="email" class="form-control" id="email" placeholder="oooo@oooo.ooo">
			</div>
			<div class="mb-3">
			  <label for="p" class="form-label">비밀번호</label>
			  <input type="password" name="pwd" class="form-control" id="pwd">
			</div>
			
			<button type="submit" class="btn btn-primary">로그인</button>
		</form>
	
		<c:if test="${not empty param.errMsg }">
			<div class="class=mb-3">
				<c:choose>
					<c:when test="${param.errMsg eq 'bad credentials' }">
						<c:set value="이메일 & 비밀번호가 일치하지 않습니다." var="errText"/>
					</c:when>
					<c:otherwise>
						<c:set value="괸리자에게 문의하세요." var="errText"/>
					</c:otherwise>
				</c:choose>
				${errText }
			</div>
		</c:if>
	
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<jsp:include page="../layout/footer.jsp"/>