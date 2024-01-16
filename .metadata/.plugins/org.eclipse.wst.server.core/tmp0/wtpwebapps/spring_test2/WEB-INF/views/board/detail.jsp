<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    <jsp:include page="../layout/header.jsp"/>
<jsp:include page="../layout/nav.jsp"/>
<table class="table table-bordered border-primary">

<c:set value="${bdto.bvo }" var="bvo"/>
<tr>
<th>제목</th><td>${bvo.title }</td>
</tr>
<tr>
<th>글쓴이</th><td>${bvo.writer }</td>
</tr>
<tr>
<th>작성일</th><td>${bvo.regAt }</td>
</tr>
<tr>
<th>수정일</th><td>${bvo.modAt }</td>
</tr>
<tr>
<th>조회수</th><td>${bvo.readCount }</td>
</tr>
<tr>
<th>내용</th><td>${bvo.content }</td>
</tr>
</table>
<sec:authentication property="principal.mvo.email" var="authEmail"/>
<!-- 댓글 등록 라인 -->
<div class="input-group input-group-sm mb-3">
  <span class="input-group-text" id="cmtWriter">${authEmail }</span>
  <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" id="cmtText">
  <button type="button" id="cmtPostBtn" class="btn btn-primary">전송</button>
</div>


<!-- 댓글 표시 라인 -->
<ul class="list-group list-group-flush" id="cmtListArea">
  <li class="list-group-item">
  	<div>
  		<div>writer</div>
  		content
  	</div>
  	<span>modAt</span>
  </li>
</ul>

<!-- 댓글 더보기 버튼 -->
<div>
<button type="button" class="btn btn-primary" style="visibility:hidden" id="moreBtn" data-page="1">더보기</button>
</div>

<!-- 모달 창 -->
<div class="modal" id="myModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Writer</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="input-group input-group-sm mb-3">
        	<input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm" id="cmtTextMod">
	        <button type="button" class="btn btn-primary" id="cmtModBtn">등록</button>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary"  data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- file line -->
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
					<a href="/upload/${fvo.saveDir }/${fvo.uuid}_${fvo.fileName}" download="${fvo.fileName }">
						<!-- 일반 표시 아이콘 -->
						<i class="bi bi-files"></i>
					</a>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="ms-2 me-auto">
				<div class="fw-bold">${fvo.fileName }</div>
				<span class="badge text-bg-secondary">${fvo.fileSize }</span>
			</div>
			</li>
			
		</c:forEach>
  </ul>
</div>


<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-primary">수정</button></a>
	<a href="/board/remove?bno=${bvo.bno }"><button type="button" class="btn btn-primary">삭제</button></a>
	<a href="/board/list"><button type="button" class="btn btn-primary">리스트</button></a>
	
	<script>
		let bnoVal = `<c:out value="${bdto.bvo.bno}" />`;
		console.log(bnoVal);
	</script>
	<script src="/resources/js/boardComment.js"></script>
	<script>
	spreadCommentList(bnoVal);
	</script>
	<jsp:include page="../layout/footer.jsp"/>