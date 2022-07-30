<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>게시판관리 - 공지</title>
<style>
#createNotice {
	float: right;
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
						<p>게시판관리 - 공지</p>
					</div>
					<hr>
					<br> <br>
					<table class="table">
						<tr>
							<th width="100px">글 번호</th>
							<th width="600px">글 제목</th>
							<th width="140px">작성자</th>
							<th width="100px">조회수</th>
							<th width="160px">작성일</th>
						</tr>
						<c:choose>
							<c:when test="${empty list}">
								<tr>
									<td colspan="5">공지사항이 존재하지 않습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="n" items="${list}">
									<tr>
										<td>${n.noticeNo}</td>
										<td><a href="detail.no?nno=${n.noticeNo}">${n.noticeTitle}</a></td>
										<td>${n.noticeWriter}</td>
										<td>${n.count}</td>
										<td>${n.noticeDate}</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</table>
					<a href="enrollForm.no"
						id="createNotice" class="btn  btnYellow">글작성</a>
				</div>	
				<div class="selectPage">
					<c:choose>
						<c:when test="${empty keyword}">
							<c:if test="${pi.currentPage > 1}">
								<button
									onclick="location.href='adminSerchList.no?cpage=${pi.currentPage - 1}'"
									class="btn  btnYellow">&lt;
								</button>
							</c:if>
							<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
								<c:choose>
									<c:when test="${i ne pi.currentPage}">
										<button
											onclick="location.href='adminSerchList.no?cpage=${i}'"
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
									onclick="location.href='adminSerchList.no?cpage=${pi.currentPage + 1}'"
									class="btn  btnYellow">&gt;
								</button>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${pi.currentPage > 1}">
								<button
									onclick="location.href='adminSerchList.no?
									cpage=${pi.currentPage - 1}&condition=${condition}&keyword=${keyword}'"
									class="btn  btnYellow">&lt;
								</button>
							</c:if>
							<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
								<c:choose>
									<c:when test="${i ne pi.currentPage}">
										<button
											onclick="location.href='adminSerchList.no?
											cpage=${i}&condition=${condition}&keyword=${keyword}'"
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
									onclick="location.href='adminSerchList.no?
									cpage=${pi.currentPage + 1}&condition=${condition}&keyword=${keyword}'"
									class="btn  btnYellow">&gt;
								</button>
							</c:if>
						</c:otherwise>	
					</c:choose>
				</div>
				<form action="adminSerchList.no">
					<div class="srch">
						<div class= "srchOption">
							<input type="hidden" name="cpage" value="1">
							<select name="condition" class="srchOption form-control" >
								<option value="noticeTitle">제목</option>
								<option value="noticeContent">내용</option>
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