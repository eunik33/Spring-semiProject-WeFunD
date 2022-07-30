<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fu" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<style>
.answered {
	color: rgb(63, 74, 224);
}
</style>
<jsp:include page="/views/common/header2.jsp" />
</head>
<body>
		<div class="adminall">
			<jsp:include page="/views/common/adminMenu.jsp" />
			<div class="adminWrap">
				<div id="maincontent">
					<div class="title">
						<p>Q&A 관리</p>
					</div>
					<hr>
					<br> <br>
					<div>
						<table class="table">
							<tr>
								<th width="150px">글 번호</th>
								<th width="500px">글 제목</th>
								<th width="150px">작성자</th>
								<th width="150px">작성일</th>
								<th width="150px">상태</th>
							</tr>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="4">QnA가 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="q" items="${list}">
										<tr>
											<td>${q.qnaNo}</td>
											<td><a
												href="${pageContext.request.contextPath}/detail.qna?qno=${q.qnaNo}">${q.qnaTitle}</a>
											</td>
											<td>${q.qnaWriter}</td>
											<td>${fu:substring(q.qnaDate,0,10)}</td>
											<c:choose>
												<c:when test="${empty q.answer}">
													<td>접수</td>
												</c:when>
												<c:otherwise>
													<td><span class="answered">답변완료</span></td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
				</div>

				<div class="selectPage">
					<c:choose>
						<c:when test="${empty keyword }">
							<c:if test="${pi.currentPage > 1}">
								<button
									onclick="location.href='adminList.qna?cpage=${pi.currentPage - 1}'"
									class="btn  btnYellow">&lt;
								</button>
							</c:if>
							<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
								<c:choose>
									<c:when test="${i ne pi.currentPage}">
										<button
											onclick="location.href='adminList.qna?cpage=${i}'"
											class="btn  btnYellow">${i}
										</button>
									</c:when>
									<c:otherwise>
										<button style="background: rgb(255, 240, 110);"
											class="btn  btnYellow">${i}
										</button>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${pi.currentPage ne pi.maxPage and 0 ne pi.maxPage}">
								<button
									onclick="location.href='adminList.qna?cpage=${pi.currentPage + 1}'"
									class="btn  btnYellow">&gt;
								</button>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${pi.currentPage > 1}">
								<button
									onclick="location.href='adminSerch.qna?
									cpage=${pi.currentPage - 1}&condition=${condition}&keyword=${keyword}'"
									class="btn  btnYellow">&lt11;
								</button>
							</c:if>
							<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
								<c:choose>
									<c:when test="${i ne pi.currentPage}">
										<button
											onclick="location.href='adminSerch.qna?
											cpage=${i}&condition=${condition}&keyword=${keyword}'"
											class="btn  btnYellow">${i}11
										</button>
									</c:when>
									<c:otherwise>
										<button style="background: rgb(255, 240, 110);"
											class="btn  btnYellow">${i}11
										</button>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${pi.currentPage ne pi.maxPage and 0 ne pi.maxPage}">
								<button
									onclick="location.href='adminSerch.qna?
									cpage=${pi.currentPage + 1}&condition=${condition}&keyword=${keyword}'"
									class="btn  btnYellow">&gt11;
								</button>
							</c:if>
						</c:otherwise>	
					</c:choose>
				</div>
				<form action="adminSerch.qna" method="get">
					<div class="srch">
						<div class= "srchOption">
							<input type="hidden" name="cpage" value="1">
							<select name="condition" class="srchOption form-control" >
								<option value="qnaTitle">제목</option>
								<option value="qnaContent">내용</option>
								<option value="qnaWriter">작성자</option>
							</select>
						</div>
						<div class="srchText">
							<input type="text" class="form-control srchInput" name="keyword">
							<div class="serchBtn">
							<button class="serchBtn">
								<img class="serchBtnImg" src="./resources/img/search.png">
							</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	<br clear="both">
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
</body>
<footer>
	<jsp:include page="/views/common/footer.jsp" />
</footer>
</html>