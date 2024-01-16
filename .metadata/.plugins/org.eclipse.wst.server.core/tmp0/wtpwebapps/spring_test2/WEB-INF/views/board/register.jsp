<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:include page="../layout/header.jsp"/>
<jsp:include page="../layout/nav.jsp"/>
<div class="container">
<form action="/board/register" method="post" enctype="multipart/form-data">
<div class="mb-3">
  <label for="title" class="form-label">Title</label>
  <input type="text" name="title" class="form-control" id="title" placeholder="title...">
</div>
<sec:authentication property="principal.mvo.email" var="authEmail"/>
<div class="mb-3">
  <label for="writer" class="form-label">writer</label>
  <input type="text" name="writer" class="form-control" id="writer" value="${authEmail }" readonly>
</div>
<div class="mb-3">
  <label for="content" class="form-label">content</label>
  <textarea class="form-control" name="content" id="content" rows="3"></textarea>
</div>

<div class="mb-3">
  <label for="file" class="form-label">files...</label>
  <input type="file" name="files" class="form-control" id="files" multiple style="display:none"><br>
  <button type="button" class="btn btn-primary" id="trigger">fileUpload</button>
</div>
<div class="mb-3">
	파일 목록 표시라인
	<div id="fileZone" class="mb-3">
	
	</div>
</div>

<button type="submit" class="btn btn-primary" id="regBtn">전송</button>
</form>
</div>
<script src="/resources/js/boardRegister.js"></script>
<jsp:include page="../layout/footer.jsp"/>