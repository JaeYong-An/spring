<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="layout/header.jsp"/>
    <jsp:include page="layout/nav.jsp"/>
    
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

<a href="/board/register"><button>reg</button></a>

<jsp:include page="layout/footer.jsp"/>
