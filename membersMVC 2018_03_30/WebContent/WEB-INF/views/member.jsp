<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%-- jstl-1.2.jar 파일 필요 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>SIST_쌍용교육센터</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<style>
div#input:hover, div#output:hover {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script>
	$(document).ready(function() {

		//검색
		var key = "${key}";
		var value = "${value}";
        $("select#key > option[value='"+key+"']").attr("selected","selected");
        $("input#value").val(value);
     
        
	});


</script>
</head>
<body>
	<div class="container">

		<div class="panel page-header" style="text-align:center;">
			<h1 style="font-size:xx-large;">
				<a href="${pageContext.request.contextPath}/member/list"><img src="${pageContext.request.contextPath}/img/sist_logo.png" alt="sist_logo.png"> </a>
				회원관리 <small>v4.2</small> <span style="font-size:small; color: #777777;">A website that manages personal information for members</span>
			</h1>
		</div>

		<div class="panel panel-default" id="input">
			<div class="panel-heading">회원관리 입력</div>
			<div class="panel-body">

				<form action="${pageContext.request.contextPath}/member/insert" method="post">
				
					<div class="form-group">
						<label for="name_">Name:</label> <input type="text"
							class="form-control" id="name_" name="name_" placeholder="max:20" required>
					</div>
					<div class="form-group">
						<label for="phone">Phone:</label> <input type="text"
							class="form-control" id="phone" name="phone" placeholder="max:20" required>
					</div>
					<div class="form-group">
						<label for="email">Email:</label> <input type="email"
							class="form-control" id="email" name="email" placeholder="max:50">
					</div>
					
					<div class="form-group">
						<label for="regDate">RegDate:</label> <input type="date"
							class="form-control" id="regDate" name="regDate">
					</div>
										
					<div class="form-group">
					  <label for="deptId">DeptName:</label>
					  <select class="form-control" id="deptId" name="deptId">
					  	<c:forEach var="m" items="${deptList}">
					  	<option value ="${m.deptId}">${m.deptName}</option>
					   	</c:forEach>
					  </select>
					</div>					
					<button type="submit" class="btn btn-default">Submit</button>
					
					<c:if test="${param.success==1}">
					<div class="alert alert-success alert-dismissible fade in" style="display:inline-block; padding-top:5px; padding-bottom:5px; margin:0px;">  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>  <strong>Success!</strong> 요청한 작업이 처리되었습니다. </div>
					</c:if>
					<c:if test="${param.success==0}">
					<div class="alert alert-danger alert-dismissible fade in" style="display:inline-block; padding-top:5px; padding-bottom:5px; margin:0px;">  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>  <strong>Fail!</strong> 요청한 작업 처리가 실패했습니다. </div>
					</c:if>
					
				</form>
			</div>
		</div>

		<div class="panel panel-default" id="output">
			<div class="panel-heading">회원관리 출력</div>
			<div class="panel-body">

				<table class="table table-striped">
					<thead>
						<tr>
							<th>Mid</th>
							<th>Name</th>
							<th>Phone</th>
							<th>Email</th>
							<th>RegDate</th>
							<th>DeptName</th>
							<th>Update/Delete</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${count==0}">
						<tr><td colspan="7" style="text-align:center;"> <strong>출력 대상이 없습니다.</strong> </td></tr>
						</c:if>
						<c:if test="${count>0}">
						<c:forEach var="m" items="${list}">
						<tr>
							<td>${m.mid_}</td>
							<td>${m.name_}</td>
							<td>${m.phone}</td>
							<td>${m.email}</td>
							<td>${m.regDate}</td>
							<td>${m.deptName}</td>
							<td><div class="btn-group"><button type="button" class="btn btn-default btn-xs">Update</button><button type="button" class="btn btn-default btn-xs">Delete</button></div></td>
						</tr>
						</c:forEach>
						</c:if>
					</tbody>
				</table>

				<form class="form-inline" method="post">
					<div class="form-group">
						<button type="button" class="btn btn-default">TotalCount <span class="badge">${totalCount}</span></button>
						<button type="button" class="btn btn-default">Count <span class="badge">${count}</span></button>
						<button	type="button" class="btn btn-default" ><span class="glyphicon glyphicon-step-backward"></span> Previous</button>
						<button	type="button" class="btn btn-default" >Next <span class="glyphicon glyphicon-step-forward"></span></button>
						
						<select class="form-control" id="key" name="key">
							<option value="mid_">Mid</option>
							<option value="name_">Name</option>
							<option value="phone">Phone</option>
							<option value="email">Email</option>
							<option value="regDate">RegDate</option>
							<option value="deptName">DeptName</option>
						</select>
					</div>
					<div class="input-group">
						<input type="text" class="form-control" id="value" name="value"
							placeholder="Search" >

						<div class="input-group-btn">
							<button class="btn btn-default" type="submit">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
					</div>
				</form>
								
			</div>
		</div>

	</div>

</body>
</html>