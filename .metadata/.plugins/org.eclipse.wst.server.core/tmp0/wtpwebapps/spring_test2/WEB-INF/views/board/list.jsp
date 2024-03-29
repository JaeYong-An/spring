<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="../layout/header.jsp"/>
<jsp:include page="../layout/nav.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- search line -->
<div class="col-sm-12 col-md-6">
	<form action="/board/list" method="get">
		<div class="input-group mb-3">
			<select class="form-select" name="type" id="inputGroupSelect01">
				<option>Choose...</option>
				<option value="t">Title</option>
				<option value="w">Writer</option>
				<option value="c">Content</option>
				<option value="tw">Title&Writer</option>
				<option value="tc">Title&Content</option>
				<option value="wc">Writer&Content</option>
				<option value="twc">Title&Writer&Content</option>
			</select>
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="qty" value="${ph.pgvo.qty }">
			<input name="keyword" class="form-control me-2" type="search" aria-label="Search" value="${ph.pgvo.keyword }" placeholder="Search...">
			<button class="btn btn-outline-success" type="submit">search
				<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
				    ${ph.totalCount }
				</span>	
			</button>
		</div>
	</form>
</div>

	<table class="table">
	  <thead>
	    <tr>
	      <th scope="col">bno</th>
	      <th scope="col">title</th>
	      <th scope="col">writer</th>
	      <th scope="col">reg_date</th>
	      <th scope="col">read_count</th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach items="${list }" var="bvo">
		    <tr>
		      <th scope="row"><a href="/board/detail?bno=${bvo.bno }">${bvo.bno }</a></th>
		      <td><a href="/board/detail?bno=${bvo.bno }">${bvo.title } 
		      <%-- <c:if test="${bvo.commentCount eq 0 }"></c:if>
		      <c:if test="${bvo.commentCount ne 0 }"><span style="color=danger; font-weight:bold"> (${bvo.commentCount })</span></c:if>
		      <c:if test="${bvo.fileCount eq 0 }"></c:if>
		      <c:if test="${bvo.fileCount ne 0 }"><span class="badge rounded-pill text-bg-danger"> ${bvo.fileCount }</span></c:if> --%>
		      </a></td>
		      <td>${bvo.writer }</td>
		      <td>${bvo.regAt }</td>
		      <td>${bvo.readCount }</td>
		    </tr>
	    </c:forEach>
	  </tbody>
	</table>
	
	<!-- 페이징 라인 -->
	<nav aria-label="Page navigation example">
	  <ul class="pagination">
	  <c:if test="${ph.prev }">
	    <li class="page-item"><a class="page-link" href="/board/list?pageNo=${ph.startPage-1 }&qty=${ph.pgvo.qty }&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">Previous</a></li>
	  </c:if>
	    
	  <c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
	    <li class="page-item"><a class="page-link" href="/board/list?pageNo=${i }&qty=${ph.pgvo.qty }&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">${i }</a></li>
	  </c:forEach>
	    
	  <c:if test="${ph.next }">
	    <li class="page-item"><a class="page-link" href="/board/list?pageNo=${ph.endPage+1 }&qty=${ph.pgvo.qty }&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">Next</a></li>
	  </c:if>
	  <li class="page-item"><a class="page-link" href="/board/list">전체보기</a></li>
	  </ul>
	</nav>
		
	<jsp:include page="../layout/footer.jsp"/>