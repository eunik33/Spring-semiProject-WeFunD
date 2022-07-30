<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>매출 관리</title>
<style>
#categorySales {
	text-align: center;
	width: 45%;
	display: inline-block;
}

#list {
	text-align: center;
	float: right;
	width: 45%;
	height: 100%;
}

#table123 {
	text-align: center;
	float: right;
	width: 100%;
}

.h60 {
	height: 60px;
	font-size: 20px;
}

.h40 {
	height: 40px;
	font-size: 17px;
}
</style>
<jsp:include page="/views/common/header2.jsp" />
</head>
<body>
		<div class="adminall">
			<jsp:include page="/views/common/adminMenu.jsp" />
			<div id="maincontent">
				<div class="title">
					<p>매출 관리</p>
				</div>
				<hr>
				<br> <br>
				<div id="categorySales">
					<table class="table-bordered">
						<tr class="h60">
							<th colspan="2">20${year}년 ${month}월</th>
						</tr>
						<tr class="h40">
							<th width="150px">카테고리</th>
							<th width="300px">매출</th>
						</tr>
						<c:forEach var="s" items="${list1}">
							<tr class="h40">
								<td>${s.categoryName}</td>
								<td><fmt:formatNumber value="${s.sumPayment}" type="number" />원</td>
							</tr>
						</c:forEach>
						<c:forEach var="s" items="${list1}">
							<c:set var="sum" value="${sum + s.sumPayment}" />
						</c:forEach>
						<tr class="h60">
							<th>계</th>
							<th><fmt:formatNumber value="${sum}" type="number" />원</th>
						</tr>
					</table>
				</div>
				<div id="list">
					<table id="table123" class="table-bordered">
						<tr class="h60">
							<th>날짜</th>
							<th>매출액</th>
						</tr>
						<c:choose>
							<c:when test="${not empty list2}">
								<c:forEach var="i" begin="0" end="5" items="${list2}">
									<tr class="h40">
										<td>20${fn:replace(i.yrarAndMonth,'/','년')}월</td>
										<td><fmt:formatNumber value="${i.samMonthPayment}"
												 			  type="number" />원
										</td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>
					</table>
				</div>
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
	<br>
	<br>
	<br>
</body>
<footer>
	<jsp:include page="/views/common/footer.jsp" />
</footer>
</html>