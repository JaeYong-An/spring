<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <jsp:include page="../layout/header.jsp"/>
<jsp:include page="../layout/nav.jsp"/>
<form action="/board/modify" method="post" enctype="multipart/form-data">
<c:set value="${bdto.bvo }" var="bvo"/>
		<div class="mb-3">
		  <label for="bno" class="form-label">번호</label>
		  <input type="text" name="bno" class="form-control" id="bno" value="${bvo.bno }" readonly="readonly">
		</div>
		<div class="mb-3">
		  <label for="title" class="form-label">제목</label>
		  <input type="text" name="title" class="form-control" value="${bvo.title }" id="title">
		</div>
		<div class="mb-3">
		  <label for="writer" class="form-label">글쓴이</label>
		  <input type="text" name="writer" class="form-control" id="writer" value="${bvo.writer }" readonly="readonly">
		</div>
		<div class="mb-3">
		  <label for="regAt" class="form-label">작성일</label>
		  <input type="text" name="regAt" class="form-control" id="regAt" value="${bvo.regAt }" readonly="readonly">
		</div>
	<%-- 	<div class="mb-3">
		  <label for="read_count" class="form-label">조회수</label>
		  <input type="text" name="read_count" class="form-control" id="read_count" value="${bvo.read_count }" readonly="readonly">
		</div> --%>
		<div class="mb-3">
		  <label for="content" class="form-label">내용</label>
		  <textarea class="form-control" name="content" id="content" rows="3">${bvo.content }</textarea>
		</div>
		
		<c:set value="${bdto.flist }" var="flist"/>
<div class="col-12">
	<label for="f" class="form-label">File</label>
	<ul class="list-group list-group-flush">
		<c:forEach items="${flist }" var="fvo">
		<li class="list-group-item">
			<c:choose>
				<c:when test="${fvo.fileType == 1 }">
					<div>
						<img alt="" src="/upload/${fvo.saveDir }/${fvo.uuid}_th_${fvo.fileName}">
					</div>
				</c:when>
				<c:otherwise>
					<div>
						<!-- 일반 표시 아이콘 -->
						<i class="bi bi-files"></i>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="ms-2 me-auto">
				<div class="fw-bold">${fvo.fileName }</div>
				<span class="badge text-bg-secondary">${fvo.fileSize }</span>
				<button type="button" data-uuid="${fvo.uuid }" class="btn btn-sm btn-outline-danger file-x">X</button>
			</div>
			</li>
			
		</c:forEach>
  </ul>
</div>
	
<!-- 	수정 파일 등록 라인 -->
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
	
	
		<button type="submit" id="regBtn" class="btn btn-primary">수정</button>
		<a href="/board/list"><button type="button" class="btn btn-primary">리스트</button></a>
	</form>
	
	<script src="/resources/js/boardModify.js"></script>
	<script src="/resources/js/boardRegister.js"></script>
	
	<jsp:include page="../layout/footer.jsp"/>