<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fu" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>프로젝트 관리</title>
<style>
#Status {
	float: right;
	font-size: 20px;
	color: black;
	font-weight: bold;
}

#Status a {
	color: black;
}

#Status a:hover {
	color: gray;
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
						<p>프로젝트 - 상태</p>
					</div>
					<hr>
					<br>
					<div id="Status">
						<select class="form-control" onchange="if(this.value) location.href=(this.value);" name="type">
							<option>선택</option>
							<option value="adminList.pj?cpage=1&type=all">전체</option>
							<option value="adminList.pj?cpage=1&type=Y">승인</option>
							<option value="adminList.pj?cpage=1&type=N">대기</option>
							<option value="adminList.pj?cpage=1&type=X">반려</option>
							<option value="adminList.pj?cpage=1&type=E">마감</option>
						</select>
					</div>
					
					
					<div>
						<table class="table">
							<tr>
								<th width="150px">프로젝트 번호</th>
								<th width="600px">프로젝트 명</th>
								<th width="150px">신청자</th>
								<th width="200px">신청일</th>
							</tr>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="4">신청프로젝트가 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="p" items="${list}">
										<tr>
											<td>${p.projectNo}</td>
											<td><a
												href="${pageContext.request.contextPath}/detail.pj?pno=${p.projectNo}">${p.projectName}</a></td>
											<td>${p.projectCreator}</td>
											<td>${fu:substring(p.applyDate,0,10)}</td>
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
									onclick="location.href='adminList.pj?cpage=${pi.currentPage - 1}&type=${type}'"
									class="btn  btnYellow">&lt;
								</button>
							</c:if>
							<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
								<c:choose>
									<c:when test="${i ne pi.currentPage}">
										<button
											onclick="location.href='adminList.pj?cpage=${i}&type=${type}'"
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
									onclick="location.href='adminList.pj?cpage=${pi.currentPage + 1}&type=${type}'"
									class="btn  btnYellow">&gt;
								</button>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${pi.currentPage > 1}">
								<button
									onclick="location.href='adminSerch.pj?
									cpage=${pi.currentPage - 1}&type=${type}&condition=${condition}&keyword=${keyword}'"
									class="btn  btnYellow">&lt;
								</button>
							</c:if>
							<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
								<c:choose>
									<c:when test="${i ne pi.currentPage}">
										<button
											onclick="location.href='adminSerch.pj?
											cpage=${i}&type=${type}&condition=${condition}&keyword=${keyword}'"
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
									onclick="location.href='adminSerch.pj?
									cpage=${pi.currentPage + 1}&type=${type}&condition=${condition}&keyword=${keyword}'"
									class="btn  btnYellow">&gt;
								</button>
							</c:if>
						</c:otherwise>	
					</c:choose>
				</div>
				<form action="adminSerch.pj">
					<input type="hidden" name="type" value="${type}">
					<div class="srch">
						<div class= "srchOption">
							<input type="hidden" name="cpage" value="1">
							<select name="condition" class="srchOption form-control" >
								<option value="projectName">제목</option>
								<option value="categoryName">신청자</option>
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