<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fu" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>회원관리 - 신고내역</title>
<jsp:include page="/views/common/header2.jsp" />
</head>
<body>
		<div class="adminall">
			<jsp:include page="/views/common/adminMenu.jsp" />
			<div class="adminWrap">
				<div id="maincontent">
					<div class="title">
						<p>회원관리 - 신고내역</p>
					</div>
					<hr>
					<br> <br>
					<div>
						<table class="table">
							<tr>
								<th width="150px">댓글 번호</th>
								<th width="600px">글 제목</th>
								<th width="150px">댓글 작성자</th>
								<th width="200px">작성일</th>
							</tr>
							<tr>
								<th>회원 정지</th>
								<th>신고내역</th>
								<th>신고자</th>
								<th>신고일자</th>
							</tr>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="4">신고내역이 존재하지 않습니다</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="r" items="${list}">
										<tr>
											<td>${r.replyNo}</td>
											<td><a
												href="${pageContext.request.contextPath}/detail.rv?rno=${r.reviewNo}">${r.reviewTitle}</a></td>
											<td>${r.replyWriter}</td>
											<td>${fu:substring(r.replyDate,0,16)}</td>
										</tr>
										<tr>
											<td>
												<button class="btn-modal btn btn-dark" data-toggle="modal"
													data-target="#myModal"
													data-id="${r.replyWriter},${r.replyNo}">회원정지</button>
											</td>
											<td>${r.replyContent}</td>
											<td>${r.replyReporter}</td>
											<td>${fu:substring(r.reportDate,0,16)}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
				</div>
			</div>
			</div>
			<!-- The Modal -->
			<div class="modal" id="myModal">
				<div class="modal-dialog">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title" style="text-align: center;">
								<br>해당 회원을 정지하겠습니까?<br>
							</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
							<input type="hidden" class="body-contents" id="replyNo"
								name="replyNo">
							<form action="suspension.mem" method="post">
								<input type="hidden" class="body-contents" id="nickname"
									name="nickname"> <input type="hidden"
									class="body-contents" id="replyNo" name="replyNo">
								<button type="submit" class="btn btn-danger btnN" name="N">정지</button>
							</form>
							<form action="cancelReport" method="post">
								<input type="hidden" class="body-contents" id="replyNo"
									name="replyNo">
								<button type="submit" class="btn btn-danger btnY" name="Y">취소</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<script>
				$(".btn-modal").click(function() {
					var data = $(this).data('id');
					var nickname = data.split(',');
					$("#nickname").val(nickname[0]);
					$("#replyNo").val(nickname[1]);
					console.log(nickname);
				});

				$(".btnN").click(function name() {
					var Y = Y;
				})
			</script>
		<br clear="both"><br><br><br><br><br><br><br><br><br><br><br><br><br>
</body>
	<footer>
		<jsp:include page="/views/common/footer.jsp" />
	</footer>
</html>