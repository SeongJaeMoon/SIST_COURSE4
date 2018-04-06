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
		
		$("button.btnWrite").on("click", function(){
			$("div#myQABoardInsertForm").modal();
		});
	 
	});
</script>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header" style="padding: 10px;">
				<a href="${pageContext.request.contextPath}/sist/main"><img
					src="${pageContext.request.contextPath}/resources/img/sist_logo.png"
					alt="sist_logo.png" style="vertical-align: bottom;"></a>
			</div>
			<div>
				<ul class="nav navbar-nav">
					<li><a href="${pageContext.request.contextPath}/sist/main">Home</a></li>
					<li><a href="${pageContext.request.contextPath}/sist/intro">센터소개</a></li>
					<li><a
						href="${pageContext.request.contextPath}/sist/education">교육과정
							소개</a></li>
					<li class="active"><a
						href="${pageContext.request.contextPath}/qaboard/list">문의게시판</a></li>
					<li><a href="#" data-toggle="modal"
						data-target="#myLoginFormModal">회원가입/로그인</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="panel-group">

			<div class="panel panel-default" id="output">
				<div class="panel-heading">
					교육 과정 및 교육원 관련 문의
					<button type="button" class="btn btn-default btn-xs btnWrite"
						id="QBBoardInsert" data-toggle="tooltip" data-placement="top"
						title="로그인 과정 없이 글쓰기가 가능합니다.">글쓰기</button>
						<c:if test="${param.ret==1}">
					<div class="alert alert-success alert-dismissible fade in" style="display:inline-block; padding-top:5px; padding-bottom:5px; margin:0px;">  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>  <strong>Success!</strong> 요청한 작업이 처리되었습니다. </div>
					</c:if>
					<c:if test="${param.ret==0}">
					<div class="alert alert-danger alert-dismissible fade in" style="display:inline-block; padding-top:5px; padding-bottom:5px; margin:0px;">  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>  <strong>Fail!</strong> 요청한 작업 처리가 실패했습니다. </div>
					</c:if>
						
				</div>
				
				<div class="panel-body">
					<table class="table">
						<thead>
							<tr>
								<th>번호</th>
								<th style="width: 70%">제목</th>
								<th>작성일</th>
								<th>답변보기</th>
							</tr>
						</thead>
						<tbody>
							

							<c:if test="${qaListSize == 0}">
								<tr>
									<td colspan="4" style="text-align: center;"><strong>출력
											대상이 없습니다.</strong></td>
								</tr>
							</c:if>
							<c:if test="${qaListSize > 0}">
								<c:forEach var="q" items="${qaList}" varStatus="status">
									<tr>
										<td>${status.index}</td>
										<td><a href="#${status.index}" data-toggle="collapse">${q.title}</a>
											<div id="${status.index}" class="collapse"
												style="width: 80%; margin: 10px;">
												<p>${q.content_}</p>
											</div></td>
										<td>${q.writeday}</td>
										<td><button type="button"
												class="btn btn-default btn-xs btnReply" disabled="disabled">답변보기</button></td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<ul class="pager">
						<li><button type="button"
								class="btn btn-default btn-sm btnPrevious">
								<span class="glyphicon glyphicon-step-backward"></span>Previous
							</button></li>
						<li><button type="button"
								class="btn btn-default btn-sm btnNext">
								Next<span class="glyphicon glyphicon-step-forward"></span>
							</button></li>
					</ul>
				</div>
			</div>


		</div>


		<!-- Modal -->
		<div id="myQABoardInsertForm" class="modal fade" role="dialog">
			<div class="modal-dialog modal-lg">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">교육 과정 및 교육원 관련 문의</h4>
						<label>최대한 빠른 답변을 해드리겠습니다.</label>
					</div>
					<div class="modal-body">

						<form role="form"
							action="${pageContext.request.contextPath}/qaboard/insert"
							method="post">
							<div class="form-group">
								<label for="name">제목:</label> <input type="text"
									class="form-control" id="title" name="title"
									placeholder="제목 (100자 이내)" maxlength="100" required="required"
									autofocus="autofocus">
							</div>
							<div class="form-group">
								<label for="comment">내용:</label>
								<textarea class="form-control" rows="10" id="content"
									name="content_" placeholder="내용 (1000자 이내)" maxlength="1000"
									required="required" style="resize: none;"></textarea>
							</div>
							<div class="checkbox">
								<label><input type="checkbox" value="" id="undercover">비밀글
									<span class="small">(비밀글을 체크하면 글내용 보기를 할 때 패스워드를 확인하는
										게시물이 됩니다.)</span></label> <label class="text-danger small">* 수강 신청 확인
									등 신원 확인이 필요한 문의는 이름, 전화번호, 이메일을 적어주시고, 비밀글 체크를 해주시기 바랍니다.</label>
							</div>
							<div class="form-group" id="pwForm" style="display: none;">
								<input type="password" class="form-control " id="pw" name="pw"
									placeholder="패스워드 (4자리)" maxlength="4" required="required"
									disabled="disabled">
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

		<!-- Modal -->
		<div id="myLoginFormModal" class="modal fade" role="dialog">

			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header" style="padding: 35px 50px;">
						<h4>
							<span class="glyphicon glyphicon-lock"></span> 로그인
						</h4>
						<label>정상적인 서비스 사용을 위해서 로그인해야 합니다.</label>
					</div>
					<div class="modal-body" style="padding: 40px 50px;">
						<form role="form" method="post"
							action="${pageContext.request.contextPath}/login/login">
							<div class="form-group">
								<label for="id"> ID :</label> <input type="text"
									class="form-control" id="id_" name="id_" placeholder="Enter ID"
									required="required">
							</div>
							<div class="form-group">
								<label for="pw"> Password :</label> <input type="password"
									class="form-control" id="pw" name="pw"
									placeholder="Enter Password" required="required">
							</div>
							<button type="submit" class="btn btn-default btn-block">
								Login</button>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm"
							id="memberInsertForm">회원가입</button>
						<button type="button" class="btn btn-default btn-sm"
							data-dismiss="modal">Close</button>
					</div>
				</div>

			</div>

		</div>

	</div>
</body>
</html>