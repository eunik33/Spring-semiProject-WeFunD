<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>회원관리 - 조회</title>
<jsp:include page="/views/common/header2.jsp" />
</head>
<body>
		<div class="adminall">
			<jsp:include page="/views/common/adminMenu.jsp" />
			<div class="adminWrap">
				<div id="maincontent">
					<div class="title">
						<p>회원관리 - 조회</p>
					</div>
					<hr>
					<br>
					<br>
					<div>
						<table id="QnATable" width="100%" class="table">
							<tr>
								<th width="120px">회원번호</th>
								<th width="150px">아이디</th>
								<th width="150px">회원명</th>
								<th width="170px">닉네임</th>
								<th width="170px">휴대폰번호</th>
								<th width="170px">회원가입일</th>
								<th width="170px">회원정보변경일</th>
							</tr>
							<c:choose>
								<c:when test="${empty list}">
									<tr>
										<td colspan="7">회원정보가 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="m" items="${list}">
										<tr>
											<td>${m.userNo}</td>
											<td>${m.userId}</td>
											<td>${m.userName}</td>
											<td>${m.nickname}</td>
											<td>${m.phone}</td>
											<td><fmt:formatDate value="${m.enrollDate}"
													pattern="yyyy-MM-dd" /></td>
											<td><fmt:formatDate value="${m.modifyDate}"
													pattern="yyyy-MM-dd" /></td>
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
									onclick="location.href='adminList.mem?cpage=${pi.currentPage - 1}'"
									class="btn  btnYellow">&lt;
								</button>
							</c:if>
							<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
								<c:choose>
									<c:when test="${i ne pi.currentPage}">
										<button
											onclick="location.href='adminList.mem?cpage=${i}'"
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
									onclick="location.href='adminList.mem?cpage=${pi.currentPage + 1}'"
									class="btn  btnYellow">&gt;
								</button>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${pi.currentPage > 1}">
								<button
									onclick="location.href='adminSerch.mem?
									cpage=${pi.currentPage - 1}&condition=${condition}&keyword=${keyword}'"
									class="btn  btnYellow">&lt;
								</button>
							</c:if>
							<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
								<c:choose>
									<c:when test="${i ne pi.currentPage}">
										<button
											onclick="location.href='adminSerch.mem?
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
									onclick="location.href='adminSerch.mem?
									cpage=${pi.currentPage + 1}&condition=${condition}&keyword=${keyword}'"
									class="btn  btnYellow">&gt;
								</button>
							</c:if>
						</c:otherwise>	
					</c:choose>
				</div>
				<form action="adminSerch.mem">
					<div class="srch">
						<div class= "srchOption">
							<input type="hidden" name="cpage" value="1">
							<select name="condition" class="srchOption form-control" >
								<option value="userId">아이디</option>
								<option value="userName">회원명</option>
								<option value="nickname">닉네임</option>
								<option value="phone">번호</option>
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
		<br clear="both"><br><br><br><br><br><br><br>
</body>
<footer>
	<jsp:include page="/views/common/footer.jsp" />
</footer>
</html>