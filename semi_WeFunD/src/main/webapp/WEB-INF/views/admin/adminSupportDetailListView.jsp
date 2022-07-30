<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fu" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>프로젝트 관리</title>
<jsp:include page="/views/common/header2.jsp" />
</head>
<body>
		<div class="adminall">
			<jsp:include page="/views/common/adminMenu.jsp" />
			<div class="adminWrap">
				<div id="maincontent">
					<div class="title">
						<p>프로젝트 - 상세구매내역</p>
					</div>
					<br> <br>
					<br>
					<div>
						<table class="table">
							<tr>
								<th width="120px" rowspan="4" style="vertical-align: middle;">주문
									번호</th>
								<th width="200px">구매자</th>
								<th width="280px">구매자 휴대폰번호</th>
								<th width="500px">구매자 이메일</th>
							</tr>
							<tr>
								<th>수령자</th>
								<th>수령자 휴대폰번호</th>
								<th>수령지</th>
							</tr>
							<tr>
								<th>가격</th>
								<th>결제일</th>
								<th>상품명</th>
							</tr>
							<tr>
								<th colspan="3">요청사항</th>
							</tr>
							<c:forEach var="s" items="${list}">
								<tr>
									<td rowspan="4" style="vertical-align: middle;">${s.supportNo}번</td>
									<td>${s.orderName}</td>
									<td>${s.orderPhone}</td>
									<td>${s.orderEmail}</td>
								</tr>
								<tr>
									<td>${s.receiverName}</td>
									<td>${s.receiverPhone}</td>
									<td>${s.receiverAddress}</td>
								</tr>
								<tr>
									<td>${s.payment}원</td>
									<td>${fu:substring(s.supportDate,0,16)}</td>
									<td>${s.product}</td>
								</tr>
								<tr>
									<td colspan="3">${s.orderComment}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
	<br>
	<br clear="both"><br><br><br><br><br><br><br>
</body>
<footer>
	<jsp:include page="/views/common/footer.jsp" />
</footer>
</html>