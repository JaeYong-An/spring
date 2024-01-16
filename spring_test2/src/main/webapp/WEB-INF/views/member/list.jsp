<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    
    <h1>회원 목록</h1>
<table border="1">
	<tr>
		<th>이메일</th>
		<th>닉네임</th>
		<th>생성일</th>
		<th>마지막 로그인</th>
		<th>권한</th>
	</tr>
	<c:forEach items="${mvo }" var="mvo">
		<tr>
			<td>${mvo.email }</td>
			<td>${mvo.nickName }</td>
			<td>${mvo.regAt }</td>
			<td>${mvo.lastLogin }</td>
			<td>
				<c:forEach items="${mvo.authList }" var="authList">
					${authList.auth }
				</c:forEach>
			</td>
		</tr>
	</c:forEach>
	</table>
	<a href="/"><button type="button">인덱스로</button></a>
    

<jsp:include page="../layout/footer.jsp"/>