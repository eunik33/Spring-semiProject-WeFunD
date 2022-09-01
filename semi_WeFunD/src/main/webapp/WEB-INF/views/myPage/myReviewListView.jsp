<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
/*
div{
    border: 1px solid red;
    box-sizing: border-box;
}
*/
.outer{
    width: 1200px;
    margin-left: 8%;
    }
/* 메뉴 스타일 */
.myPageNavigator{
    width: 280px;
    height: 600px;
    float: left;
    margin-left: 15%;
    margin-right: 2%;
}
.myPageNavigator label:hover {
    font-size: 26px;
    color: rgb(63, 74, 224);
}
.myPageNavigator a:hover {
    font-size: 26px;
    color: rgb(63, 74, 224);
}
.myPageNavigator div {
    margin-bottom: 25px;
    margin-top: 25px;
}
.title {
    font-size: xx-large;
    width: 100%;
    font-weight: bold;
}

a {
    text-decoration: none !important;
}
/*
@media ( max-width : 1810px ) {
    .myPageNavigator {
        display: none;
        
    }
}
*/
.myPageNavigator a {
    color: black;
}
input[id*="answer"] {
    display: none;
}
input[id*="answer"]+label {
    display: block;
    cursor: pointer;
    position: relative;
    color: black;
}
input[id*="answer"]+label+div {
    max-height: 0;
    transition: all 0.5s;
    overflow: hidden;
}
input[id*="answer"]:checked+label+div {
    max-height: 120px;
}
input[id*="answer"]+label img{
    position: absolute;
    top: 50%;
    right: 10px;
    width: 20px;
    height: 20px;
    margin-top: -10px;
    display: inline-block;
    background: 0 0 no-repeat;
}
input[id*="answer"]:checked+label img{
    background-position: 0 -30px;
}

/* 본문 스타일 */
#myReviewOuter{
    width: 650px;
    height: 100%;
    margin-left: 2%;
    float: left;
}
.btnYellow{
    font-weight : bold;
    color:white;
    background-color: rgb(255,217,72); 
}
.btnYellow:hover{
    background-color: rgb(255,190,18); 
    color: black;
}
</style>
</head>

<body>

	<jsp:include page="../common/header2.jsp" />
	
	<div class="outer">
    <br><br>
    <h2 align="center"><b>나의 리뷰 목록</b></h2>
    <br>

    <!-- 왼쪽 메뉴바 -->
    <div class="myPageNavigator">
        <p class="title">마이페이지</p>
        <hr>
        <div class="accordion">
            <input type="checkbox" id="answer01">
            <label for="answer01">회원정보<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKKs6OP36GlHnJCLBRA3bwO1RYfLy9VLUesg&usqp=CAU"></label>
            <div>
                <a href="myPage.me?userNo=${sessionScope.loginUser.userNo}"> - 개인정보 수정</a>
                <br />
                <a href="myPage.me?userNo=${sessionScope.loginUser.userNo}"> - 회원탈퇴</a>
            </div>
        </div>
        <div class="accordion">
            <input type="checkbox" id="answer02">
            <label for="answer02">활동내역(서포터)<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKKs6OP36GlHnJCLBRA3bwO1RYfLy9VLUesg&usqp=CAU"></label>
            <div>
                <a href="myLikeListView.me?userNo=${loginUser.userNo}"> - 관심프로젝트</a>
                <br />
                <a href="myReviewListView.me?userNo=${loginUser.userNo}"> - 나의 리뷰조회</a>
                <br />
                <a href="mySupportListView.me?userNo=${loginUser.userNo}"> - 후원 현황조회</a>
            </div>
        </div>
        <div class="accordion">
            <input type="checkbox" id="answer03">
            <label for="answer03">활동내역(메이커)<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKKs6OP36GlHnJCLBRA3bwO1RYfLy9VLUesg&usqp=CAU"></label>
            <div>
                <a href="myProjectListView.me?userNo=${ loginUser.userNo}&mppage=1&select=전체"> - 나의프로젝트</a>
            </div>
        </div>
        <div class="accordion">
            <input type="checkbox" id="answer04">
            <label for="answer04">고객센터<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKKs6OP36GlHnJCLBRA3bwO1RYfLy9VLUesg&usqp=CAU"></label>
            <div>
                <a href="enrollForm.qna"> - 문의하기</a>
            </div>
        </div>
    </div>

    <!-- 오른쪽 나의 리뷰 화면 -->
    <div id="myReviewOuter">
        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th>글번호</th>
                    <th>후원프로젝트</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
		    	<c:choose>
		    		<c:when test="${empty list}">
		    			<tr>
		    				<td colspan="5">나의 리뷰 목록이 없습니다</td>
		    			</tr>
		    		</c:when>
		    	
		    		<c:otherwise>
		    			<c:forEach var="r" items="${list}">
		    				<tr>
			                    <td>${r.reviewNo}</td>
			                    <td><a href="detail.pj?pno=${r.projectNo}"><img src="${r.titleImg}" width="80" height="50"></a></td>
			                    <td><a href="detail.rv?rno=${r.reviewNo}">${r.reviewTitle}</a></td>
			                    <td>${r.reviewWriter}</td>
			                    <td>${r.reviewDate}</td>
		                	</tr>
		    			</c:forEach>
		    		</c:otherwise>
		    	</c:choose>
            </tbody>
        </table>

        <br><br>
        <!-- 페이지 이동 버튼 -->
        <div style="width: 300px; margin-left: 40%;">
			<c:if test="${pi.currentPage ne 1}">
				<button class="btn btn-sm btnYellow" onclick="location.href='myReviewListView.me?userNo=${loginUser.userNo}&rvpage=${pi.currentPage - 1}'">&lt;</button>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}" step="1">
				<c:choose>
					<c:when test="${p ne pi.currentPage}">
						<button class="btn btn-sm btnYellow" onclick="location.href='myReviewListView.me?userNo=${loginUser.userNo}&rvpage=${p}'">${p}</button>
					</c:when>
					<c:otherwise>
						<button class="btn btn-sm btnYellow" disabled>${p}</button>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${(pi.currentPage ne pi.maxPage) and (pi.maxPage ne 0)}">
				<button class="btn btn-sm btnYellow" onclick="location.href='myReviewListView.me?userNo=${loginUser.userNo}&rvpage=${pi.currentPage + 1}'">&gt;</button>
			</c:if>
		</div>

	</div>
	<br><br><br><br><br><br><br><br><br><br clear="both">
    
    <jsp:include page="../common/footer.jsp"></jsp:include>

</body>
</html>