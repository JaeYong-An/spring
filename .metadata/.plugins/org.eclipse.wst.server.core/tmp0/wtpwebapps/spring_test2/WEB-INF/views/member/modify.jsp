<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    <jsp:include page="../layout/header.jsp"/>
<jsp:include page="../layout/nav.jsp"/>

<div class="container">
	<form action="/member/modify" method="post">
		<div class="mb-3">
		  <label for="e" class="form-label">이메일</label>
		  <input type="email" name="email" class="form-control" id="e" value="${mvo.email }" readonly>
		</div>
		<div class="mb-3">
		  <label for="p" class="form-label">비밀번호</label>
		  <input type="password" name="pwd" class="form-control" id="p" value="">
		</div>
		<div class="mb-3">
		  <label for="n" class="form-label">닉네임</label>
		  <input type="text" name="nickName" class="form-control" id="n" value="${mvo.nickName }">
		</div>
		<!-- 해당 멤버의 권한 출력 (2개일 수도 있음) -->
		<button type="submit" class="btn btn-primary">수정</button>
		<a href="/member/remove?email=${mvo.email }"><button type="button">탈퇴</button></a>
	</form>
</div>




<jsp:include page="../layout/footer.jsp"/>