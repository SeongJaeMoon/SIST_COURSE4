<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ct" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>SIST_쌍용교육센터</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script
	src="${pageContext.request.contextPath}/resources/script/util.js"></script>

<script src="https://maps.googleapis.com/maps/api/js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<style>
div#input:hover, div#output:hover {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}
</style>

<script>
	$(document).ready(function() {
		
		//답변보기 버튼에 대한 팝오버 액션
		$('[data-toggle="popover"]').popover(); 

		//답변쓰기 버튼에 대한 이벤트 등록
		$(".btnReplyAdd").click(function() {
			
			//기존 글제목, 기존 글내용을 모달창의 입력폼에 출력하는 액션 추가
			var title = $(this).parents("tr").find("a").text();
	        var content = $(this).parents("tr").find("p:nth-child(2)").text();
	        $("#replyQABoardInsertForm #title").val(title);
	        $("#replyQABoardInsertForm #content").text(content);
	         
			//부모 글번호를 hidden 태그에 저장하는 액션 추가
			var qid = $(this).val();
			$("#replyQABoardInsertForm #qid").val(qid);
			$("#replyQABoardInsertForm #replyContent").val("");
			$("#replyQABoardInsertForm").modal();
		});
		
		//답변 삭제
		$("button.btnReplyRemove").on("click", function() {
			if (confirm("선택한 게시물을 삭제하시겠습니까?")) {
				location.assign("${pageContext.request.contextPath}/admin/replydelete?qid=" + $(this).val());
			}
		});
		
		//블라인드 처리
		$("input.blind").on("click", function(event) {
			
			if ($(this).is(":checked")) {
				if (confirm("선택한 게시물을 블라인드 처리할까요?")) {
					location.assign("${pageContext.request.contextPath}/admin/blind?blind=1&qid=" + $(this).val());
				} else {
					//이벤트 취소
					return false;
				}
			} else {
				if (confirm("선택한 게시물을 블라인드 해제할까요?")) {
					location.assign("${pageContext.request.contextPath}/admin/blind?blind=0&qid=" + $(this).val());
				} else {
					//이벤트 취소
					return false;
				}
			}
			
		});
	
	
	});
</script>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header" style="padding: 10px;">
				<a href="${pageContext.request.contextPath}/admin/main"><img
					src="${pageContext.request.contextPath}/resources/img/sist_logo.png"
					alt="sist_logo.png" style="vertical-align: bottom;"></a>
			</div>
			<div>
				<ul class="nav navbar-nav">
					<li><a href="${pageContext.request.contextPath}/admin/main">Home</a></li>
					<li><a href="#">과정</a></li>
					<li><a href="#">공지사항</a></li>
					<li class="active"><a
						href="${pageContext.request.contextPath}/admin/qaboardlist">문의게시판</a></li>
					<li><a href="#">회원</a></li>
					<li><a href="#">상담</a></li>
					<li><a href="#">성적</a></li>
					<li><a href="#">교재</a></li>

					<%-- EL 표현을 이용해서 세션객체에 저장된 정보를 확인할 수 있다 --%>
					<li><a href="${pageContext.request.contextPath}/login/logout">관리자(${sessionScope.adminlogin.id_})
							로그아웃</a></li>

				</ul>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="panel-group">

			<div class="panel panel-default" id="output">
				<div class="panel-heading">
					교육 과정 및 교육원 관련 문의
					<button type="button" class="btn btn-default btn-xs"
						id="QABoardInsert" data-toggle="tooltip" data-placement="top"
						title="로그인 과정 없이 글쓰기가 가능합니다." disabled="disabled">글쓰기</button>
				</div>
				<div class="panel-body">
					<table class="table">
						<thead>
							<tr>
								<th>번호</th>
								<th class="col-md-7">제목</th>
								<th>작성일</th>
								<th>답변보기</th>
								<th>답변쓰기</th>
								<th>답변삭제</th>
								<th>블라인드</th>
							</tr>
						</thead>
						<tbody>
							<!-- 
							<tr>
								<td>1</td>
								<td><a href="#demo1" data-toggle="collapse">제목</a>
									<div id="demo1" class="collapse"
										style="width: 80%; margin: 10px;">

										<p>아이피주소</p>
										<p>글내용</p>

									</div></td>
								<td>글쓴날짜</td>
								<td><button type="button"
										class="btn btn-default btn-xs btnReply">답변보기</button></td>
								<td><button type="button"
										class="btn btn-default btn-xs btnReplyAdd">답변쓰기</button></td>
								<td><button type="button"
										class="btn btn-default btn-xs btnReplyRemove">답변삭제</button></td>		
								<td><input type="checkbox" class="blindCB"></td>
							</tr>
							 -->
							<!-- count, blindCount 임시 변수 준비 --> 
							<c:set var="count" value="0" />
							<c:set var="blindCount" value="0" />
							
							<c:forEach var="q" items="${list}" varStatus="a">
						
							<!-- 일반 게시물, 블라인드 게시물 카운팅 -->
							<c:if test="${q.blind==0}">
							<c:set var="count" value="${count+1}" />
							</c:if>
							<c:if test="${q.blind==1}">
							<c:set var="blindCount" value="${blindCount+1}" />
							</c:if>
						
						
							<tr>
								<td>${q.qid}</td>
								<td>
									<a href="#demo${a.index}" data-toggle="collapse">${q.title}</a>
								
									<c:if test="${q.privacy == 1}">
										<span class="text-danger small">(비밀글)</span>								
									</c:if>
										
									<div id="demo${a.index}" class="collapse"
										style="width: 80%; margin: 10px;">

										<p>${q.clientIP}</p>
										
										<!-- 줄바꿈 문자에 대한 유지 -->
										<!-- 커스텀 태그 적용 -->
										<p><ct:pre value="${q.content}" /></p>

									</div></td>
								<td>${q.writeday}</td>
								<td>
								<c:if test="${empty q.replyContent}">
								<button type="button"
											class="btn btn-default btn-xs btnReply" title="관리자 답변" disabled="disabled">답변보기</button>
								</c:if>
								<c:if test="${not empty q.replyContent}">
								<button type="button"
										class="btn btn-default btn-xs btnReply" title="관리자 답변"
										data-toggle="popover" data-placement="left"
										data-content="${q.replyContent}">답변보기</button>		
								</c:if>			
								</td>
								<td><button type="button"
										class="btn btn-default btn-xs btnReplyAdd" value="${q.qid}">답변쓰기</button></td>
								<td><button type="button"
										class="btn btn-default btn-xs btnReplyRemove" value="${q.qid}">답변삭제</button></td>
								<td>
								
								<!-- 현재 게시물의 상태에 따라서 체크 유무 지정 -->
								<input type="checkbox" class="blind" value="${q.qid}" ${(q.blind==1)?"checked":""}>
								
								</td>
							</tr>
							</c:forEach>

						</tbody>
					</table>
					<div>
						<button type="button" class="btn btn-default btn-sm btnPicture">
							TotalCount <span class="badge totalCount">${totalcount}</span>
						</button>
						<button type="button" class="btn btn-default btn-sm btnPicture">
							Count <span class="badge totalCount">${count}</span>
						</button>
						<button type="button" class="btn btn-default btn-sm btnPicture">
							Blind <span class="badge blindCount">${blindCount}</span>
						</button>
						<button type="button" class="btn btn-default btn-sm btnPrevious">
							<span class="glyphicon glyphicon-step-backward"></span>Previous
						</button>
						<button type="button" class="btn btn-default btn-sm btnNext">
							Next<span class="glyphicon glyphicon-step-forward"></span>
						</button>
					</div>
				</div>
			</div>


		</div>


		<!-- Modal -->
		<div id="replyQABoardInsertForm" class="modal fade" role="dialog">
			<div class="modal-dialog modal-lg">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">교육 과정 및 교육원 관련 문의에 대한 답변</h4>
					</div>
					<div class="modal-body">

						<div class="form-group">
							<label for="content">제목:</label> <input type="text"
								class="form-control" id="title" name="title"
								disabled="disabled" value="제목">
						</div>
						<div class="form-group">
							<label for="content">내용:</label>
							<textarea class="form-control" rows="10" id="content"
								name="content" disabled="disabled">글내용</textarea>
						</div>
						<form role="form"
							action="${pageContext.request.contextPath}/admin/replyinsert"
							method="post">
							<input type="hidden" id="qid" name="qid" value="">
							<div class="form-group">
								<label for="content">답변내용:</label>
								<textarea class="form-control" rows="10" id="replycontent"
									name="replycontent" placeholder="내용 (1000자 이내)" maxlength="1000"
									required="required"></textarea>
							</div>
							<button type="submit" class="btn btn-default btn-sm">Submit</button>
						</form>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm"
							data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>
		</div>


	</div>

	<footer class="container-fluid bg-4 text-center">
		<p>www.sist.co.kr 쌍용교육센터 since 1985</p>
	</footer>

</body>
</html>

