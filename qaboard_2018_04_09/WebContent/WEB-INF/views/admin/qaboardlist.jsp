<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
		$("button.btnReplyAdd").on("click", function(){
			$("div#replyQABoardInsertForm input#qid").val($(this).val());
			$("div#replyQABoardInsertForm textarea#content").val($(this).parents("tr").find("p:nth-child(2)").text());
			$("div#replyQABoardInsertForm input#replytitle").val($(this).parents("tr").find("a").text());
			$("div#replyQABoardInsertForm").modal();
		});
		
		$('[data-toggle="popover"]').popover(); 
		
		$("button.btnReplyRemove").on("click", function(){
			$("div#deleteFormModal input#qid").val($(this).val());
			$("div#deleteFormModal").modal();

		});
		
		/* //-----------------
		//블라인드
		$("input#blindCB").on("change", function(){
			
			if($(this).is(':checked')){
				location.assign("${pageContext.request.contextPath}/admin/blind?qid="+$(this).val()+"&blind=1");
			} else{
				location.assign("${pageContext.request.contextPath}/admin/blind?qid="+$(this).val()+"&blind=0");
			}
		});	
		//----------------- */
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
					<li><a href="${pageContext.request.contextPath}/login/logout">관리자(${sessionScope.logininfo.id_})
							로그아웃</a></li>

					<c:if test="${param.ret==1}">
						<div class="alert alert-success alert-dismissible fade in"
							style="display: inline-block; padding-top: 5px; padding-bottom: 5px; margin: 0px;">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Success!</strong> 요청한 작업이 처리되었습니다.
						</div>
					</c:if>
					<c:if test="${param.ret==0}">
						<div class="alert alert-danger alert-dismissible fade in"
							style="display: inline-block; padding-top: 5px; padding-bottom: 5px; margin: 0px;">
							<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
							<strong>Fail!</strong> 요청한 작업 처리가 실패했습니다.
						</div>
					</c:if>
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
							<c:if test="${qaListSize == 0}">
								<tr>
									<td colspan="6" style="text-align: center;"><strong>출력
											대상이 없습니다.</strong></td>
								</tr>
							</c:if>
							<c:if test="${qaListSize > 0}">
								<c:forEach var="q" items="${qaList}" varStatus="status">
									<tr>
										<td>${status.index}</td>
										<td><a href="#${status.index}" data-toggle="collapse">${q.title}</a>
											<c:if test="${q.privacy == 1}">
												<span class="text-danger small">(비밀글)</span>
											</c:if>
											<div id="${status.index}" class="collapse"
												style="width: 80%; margin: 10px;">
												<p>${q.clientip}</p>
												<p>${q.content_}</p>
											</div></td>
										<td>${q.writeday}</td>
										<td><c:if test="${empty q.replyContent}">
												<button type="button"
													class="btn btn-default btn-xs btnReply" title="관리자 답변"
													disabled="disabled">답변보기</button>
											</c:if> <c:if test="${not empty q.replyContent}">
												<button type="button"
													class="btn btn-default btn-xs btnReply" title="관리자 답변"
													data-toggle="popover" data-placement="left"
													data-content="${q.replyContent}">답변보기</button>
											</c:if></td>
										<td><button type="button"
												class="btn btn-default btn-xs btnReplyAdd" value="${q.qid}">답변쓰기</button></td>
										<td>
										<c:if test = "${empty q.replyContent}">
											<button type="button"
												class="btn btn-default btn-xs btnReplyRemove"
												value="${q.qid}" disabled="disabled">답변삭제</button>
										</c:if>
										<c:if test = "${not empty q.replyContent}">
											<button type="button"
												class="btn btn-default btn-xs btnReplyRemove"
												value="${q.qid}">답변삭제</button>
										</c:if>
										
										</td>
												
										<td><c:if test = "${q.blind == 0}">
												<input type="checkbox" class="blindCB" value="${q.qid}">										
											</c:if>
											<c:if test = "${q.blind == 1}">
												<input type="checkbox" class="blindCB" value="${q.qid}" checked="checked">		
											</c:if></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>

					</table>
					<div>
						<button type="button" class="btn btn-default btn-sm btnPicture">
							Total <span class="badge totalCount">${qaListSize}</span>
						</button>
						<button type="button" class="btn btn-default btn-sm btnPicture">
							Count <span class="badge totalCount">1</span>
						</button>
						<button type="button" class="btn btn-default btn-sm btnPicture">
							Blind <span class="badge blindCount">0</span>
						</button>
						<button type="button" class="btn btn-default btn-sm btnTotalPages">
							Pages <span class="badge totalPages">1</span>
						</button>
						<button type="button"
							class="btn btn-default btn-sm btnCurrentPage">
							Page <span class="badge currentPage">1</span>
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
						<!-- 동적 세팅 -->
						<div class="form-group">
							<label for="content">제목:</label> <input type="text" class="form-control" id="replytitle" name="replytitle" disabled="disabled" value="제목">
						</div>
						<div class="form-group">
							<label for="content">내용:</label>
							<textarea class="form-control" rows="10" id="content"
								name="content" disabled="disabled"></textarea>
						</div>
						<form role="form"
							action="${pageContext.request.contextPath}/admin/replyinsert"
							method="post">
							<input type="hidden" id="qid" name="qid" value="">
							<div class="form-group">
								<label for="content">답변내용:</label>
								<textarea class="form-control" rows="10" id="replyContent"
									name="replyContent" placeholder="내용 (1000자 이내)" maxlength="1000"
									required="required"></textarea>
							</div>
							<button type="submit" class="btn btn-default btn-sm">Submit</button>
						</form>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>
		</div>

		<!-- Modal -->
	<div id="deleteFormModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">답변 삭제</h4>
				</div>
				<div class="modal-body">
					<p>정말 삭제 하시겠습니까?</p>
					<form action="${pageContext.request.contextPath}/admin/replydelete"
						method="post">

						<!-- 주의) 삭제 진행을 위해서 글번호 정보가 필요합니다. -->
						<input type="hidden" id="qid" name="qid" value="">
						<button type="submit" class="btn btn-default">Submit</button>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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

