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
    	margin-left: 10%;
    }
/* 메뉴스타일 */
.myPageNavigator{
    width: 250px;
    height: 600px;
    float: left;
    margin-left: 15%;
    margin-right: 3%;
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
#myLikeOuter{
    width: 780px;
    height: 600px;
    margin-left: 35%;
}
#myLikeContent1{
    width: 71%;
    height: 100%;
}
#myLikeContent2{
    width: 20%;
    height: 100%;
}
#myLikeOuter > div{
        float: left;
}
.list{
    width: 92%;
    height: 25%;
    border-radius: 10px;
    border: 1px solid black;
    margin-bottom: 8px;
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

#button {
  visibility: hidden;
}
</style>
</head>

<body>
	
	<jsp:include page="../common/header2.jsp" />
	
	<div class="outer">
	<br><br>
    <h2 align="center"><b>관심 프로젝트</b></h2>
    <br>

    <!-- 왼쪽 메뉴바 -->
    <div class="myPageNavigator">
        <p class="title">마이페이지</p>
        <hr>
        <div class="accordion">
            <input type="checkbox" id="answer01">
            <label for="answer01">회원정보<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKKs6OP36GlHnJCLBRA3bwO1RYfLy9VLUesg&usqp=CAU"></label>
            <div>
                <a href="myPage.me?userNo=${loginUser.userNo}"> - 개인정보 수정</a>
                <br />
                <a href="myPage.me?userNo=${loginUser.userNo}"> - 회원탈퇴</a>
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
                <a href="myProjectListView.me?userNo=${loginUser.userNo}&mppage=1&select=all"> - 나의프로젝트</a>
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

    <!-- 오른쪽 관심프로젝트 출력화면 -->
    <div id="myLikeOuter">
        <div id="myLikeContent1">
            
            <c:choose>
            <c:when test="${empty list}">
           			등록한 관심프로젝트가 없습니다
           	</c:when>
           	<c:otherwise>
           		<c:forEach var="p" items="${list}">
           			<div class="list">
           				<input type="hidden" value="${p.projectNo}">
           				<table>
		                    <tr>
		                        <td style="width: 170px;">&nbsp;&nbsp;&nbsp;${p.categoryName}</td>
		                        <td style="width: 170px;">
			                        <c:choose>
			                        <c:when test="${p.status eq 'Y'}">
	                                    	진행중
	                                </c:when>
	                                <c:otherwise>
	                                   	 	마감됨
			                        </c:otherwise>
			                        </c:choose>
		                        </td>
		                        <td rowspan="3"><img style="width: 190px; height: 140px; border-radius: 10px;"
                                    src="${p.titleImg}"></td>
		                    </tr>
		                    <tr>
		                        <td colspan="2">&nbsp;&nbsp;&nbsp;${p.projectName}</td>
		                    </tr>
		                    <tr>
		                        <td colspan="2">&nbsp;&nbsp;&nbsp;마감일&nbsp;&nbsp;&nbsp;${p.endDate}</td>
		                    </tr>
                		</table>
           			</div>
           	</c:forEach>
            </c:otherwise>
           	</c:choose>
         </div>
         
         <script>
         	$(function(){
         		$(".list").click(function(){
         			// 클릭될때마다 url 요청 
         			var pjno = $(this).children().eq(0).val();
         			
         			location.href = "detail.pj?pno=" + pjno;
         		})
         	});
         	
         </script>

        <div id="myLikeContent2" class="container">
        <form action="selectedLike.me" method="get" id="form">
        	<input type="hidden" value="${loginUser.userId}" name="userId">
	        <select class="form-control" id="likesSelect" name="select" size="1" onchange="likes();">
	            <option value="all">전체</option>
	            <option value="funding">펀딩진행중</option>
	            <option value="end">펀딩완료</option>
	        </select>
	    </form>
        </div>
        
        <script>
        	function likes(){
        		 document.getElementById('form').submit();
        	}
        </script>
        	
		<script>
        	$(function(){
        		$("#likesSelect option").each(function(){
        			
        			if($(this).val() == "${select}"){
        				$(this).attr("selected", true);
        			} 
        			
        		})
        	});
        </script>
    </div>
	
    <br><br><br>
    <div style="width: 500px; margin-left: 35%;" class="pagin-area" align="center">
   	 
	   	<!-- previous 페이지 버튼 -->
	   	<c:choose>
	   		<c:when test="${pi.currentPage eq 1}">
	       		<button class="btn btn-sm btn-info btnYellow disabled" onclick="location.href='#'">&lt;</button>
	       	</c:when>
	       	<c:when test="${not empty select}">
	       		<button class="btn btn-sm btn-info btnYellow" onclick="location.href='selectedLike.me?userId=${loginUser.userId}&select=${select}&pjpage=${pi.currentPage - 1}'">&lt;</button>
	       	</c:when>
	       	<c:otherwise>
	       		<button class="btn btn-sm btn-info btnYellow" onclick="location.href='myLikeListView.me?userNo=${loginUser.userNo}&pjpage=${pi.currentPage - 1}'">&lt;</button>                    	
	       	</c:otherwise>
	       </c:choose>
	       
	       <!-- 숫자가 나오는 페이지 버튼 -->
	       <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
	       		<c:choose>
	       			<c:when test="${not empty select}">
	       				<button class="btn btn-sm btn-info btnYellow" onclick="location.href='selectedLike.me?userId=${loginUser.userId}&select=${select}&pjpage=${p}'">${p}</button>
	       			</c:when>
	       			<c:otherwise>
				       	<button class="btn btn-sm btn-info btnYellow" onclick="location.href='myLikeListView.me?userNo=${loginUser.userNo}&pjpage=${p}'">${p}</button>
	       			</c:otherwise>
	       		</c:choose>
	       </c:forEach>
	       
	       <!-- next 페이지 버튼 -->
	       <c:choose>
	       	<c:when test="${pi.currentPage eq pi.maxPage}">
	         	<button class="btn btn-sm btn-info btnYellow disabled" onclick="location.href='#'">&gt;</button>
	       	</c:when>
	       	<c:when test="${not empty select}">
	       		<button class="btn btn-sm btn-info btnYellow" onclick="location.href='selectedLike.me?userId=${loginUser.userId}&select=${select}&pjpage=${pi.currentPage + 1}'">&gt;</button>
	       	</c:when>
	       	<c:otherwise>
	         	<button class="btn btn-sm btn-info btnYellow" onclick="location.href='myLikeListView.me?userNo=${loginUser.userNo}&pjpage=${pi.currentPage + 1}'">&gt;</button>
	       	</c:otherwise>
	       </c:choose>
    </div>
	
	
	</div>
	<br><br><br><br><br><br><br><br><br><br>
    
    <jsp:include page="../common/footer.jsp"></jsp:include>
	
	
	
	

</body>
</html>