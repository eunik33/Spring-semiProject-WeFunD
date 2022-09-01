<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<title>마이페이지</title>
<style>
.outer{
      	width: 1200px;
      	margin-left: 10%;
    }
/* 메뉴 스타일 */
   .myPageNavigator{
    width: 250px;
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
   #myFunding{
       width: 780px;
       height: 600px;
       margin-left: 35%;
   }
   #myFundingContent1{
       width: 71%;
       height: 100%;
   }
   #myFundingContent2{
       width: 20%;
       height: 100%;
   }
   #myFunding > div{
           float: left;
   }
   .list{
       width: 92%;
       height: 25%;
       border-radius: 10px;
       border: 1px solid black;
       margin-bottom: 8px;  
       cursor: pointer;
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
    <h2 align="center"><b>후원 현황조회</b></h2>
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
                <a href="myProjectListView.me?userNo=${loginUser.userNo}&mppage=1&select=전체"> - 나의프로젝트</a>
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
    
    <!-- 오른쪽 후원현황조회 리스트 출력화면 -->
    <div id="myFunding">
        <div id="myFundingContent1">
        	
        	<c:choose>
        	<c:when test="${empty list}">
        		후원한 프로젝트가 없습니다
        	</c:when>
        	<c:otherwise>
        		<c:forEach var="s" items="${list}">
        			<div class="list">
		            	<input type="hidden" value="${s.projectNo}">
		            	<table>
		            		<tr>
		            			<td style="width: 170px;">&nbsp;&nbsp;&nbsp;${s.categoryName}</td>
		            			<td style="width: 170px;">
		            				<c:choose>
		            				<c:when test="${s.pjStatus eq 'Y'}">
		            					진행중
		            				</c:when>
		            				<c:otherwise>
		            					마감됨
		            				</c:otherwise>
		            				</c:choose>
		            			</td>
		            			<td rowspan="3"><img style="width: 190px; height: 140px; border-radius: 10px;"
		            			src="${s.titleImg}"></td>
		            		</tr>
		            		<tr>
		            			<td colspan="2">&nbsp;&nbsp;&nbsp;${s.projectName}</td>
		            		</tr>
		            		<tr>
		            			<td colspan="2">
		            			<c:choose>
		            			<c:when test="${s.status eq 'Y'}">
		            				&nbsp;&nbsp;&nbsp;결재완료&nbsp;&nbsp;/&nbsp;후원날짜&nbsp;&nbsp;${s.supportDate}
		            			</c:when>
		            			<c:when test="${s.status eq 'N'}">
		            				&nbsp;&nbsp;&nbsp;결재예약&nbsp;&nbsp;/&nbsp;후원날짜&nbsp;&nbsp;${s.supportDate}
		            			</c:when>
		            			<c:otherwise>
		            				&nbsp;&nbsp;&nbsp;펀딩실패&nbsp;&nbsp;&nbsp;
		            			</c:otherwise>
		            			</c:choose>
		            			</td>
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

                   var userId = "${loginUser.userId}";

                   location.href = "detail.sp?userId="+userId+"&pno="+pjno;
               })
           });
     </script>
     
        <div id="myFundingContent2" class="container">
        <form action="mySupportListView.me" method="get" id="form">
        	<input type="hidden" value="${loginUser.userNo}" name="userNo">
        	<select class="form-control" id="supportSelect" name="select" size="1" onchange="support();">
	            <option value="all">전체</option>
	            <option value="end">결제완료</option>
	            <option value="reserve">결제예약</option>
	            <option value="fail">펀딩실패</option>
	        </select>
        </form>
        </div>
    </div>
    
    <script>
    	function support(){
    		 document.getElementById('form').submit();
    	}
    </script>
    <script>
	    $(function(){
	        $("#supportSelect option").each(function(){
	            if($(this).text() == "${select}"){
	                $(this).attr("selected", true);
	            }
	        })
	     });
    </script>
    
    <br><br>
    
    <div style="width: 500px; margin-left: 35%;" class="pagin-area" align="center">
    	<!-- previous 페이지 버튼 -->
	   	<c:choose>
	   		<c:when test="${pi.currentPage eq 1}">
	       		<button class="btn btn-sm btn-info btnYellow disabled" onclick="location.href='#'">&lt;</button>
	       	</c:when>
	       	<c:when test="${not empty select}">
	       		<button class="btn btn-sm btn-info btnYellow" onclick="location.href='mySupportListView.me?userNo=${loginUser.userNo}&select=${select}&spage=${pi.currentPage - 1}'">&lt;</button>
	       	</c:when>
	       	<c:otherwise>
	       		<button class="btn btn-sm btn-info btnYellow" onclick="location.href='mySupportListView.me?userNo=${loginUser.userNo}&spage=${pi.currentPage - 1}'">&lt;</button>                    	
	       	</c:otherwise>
	       </c:choose>
	       
	       <!-- 숫자가 나오는 페이지 버튼 -->
	       <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
	       		<c:choose>
	       			<c:when test="${not empty select}">
	       				<button class="btn btn-sm btn-info btnYellow" onclick="location.href='mySupportListView.me?userNo=${loginUser.userNo}&select=${select}&spage=${p}'">${p}</button>
	       			</c:when>
	       			<c:otherwise>
				       	<button class="btn btn-sm btn-info btnYellow" onclick="location.href='mySupportListView.me?userNo=${loginUser.userNo}&spage=${p}'">${p}</button>
	       			</c:otherwise>
	       		</c:choose>
	       </c:forEach>
	       
	       <!-- next 페이지 버튼 -->
	       <c:choose>
	       	<c:when test="${pi.currentPage eq pi.maxPage}">
	         	<button class="btn btn-sm btn-info btnYellow disabled" onclick="location.href='#'">&gt;</button>
	       	</c:when>
	       	<c:when test="${not empty select}">
	       		<button class="btn btn-sm btn-info btnYellow" onclick="location.href='mySupportListView.me?userNo=${loginUser.userNo}&select=${select}&spage=${pi.currentPage + 1}'">&gt;</button>
	       	</c:when>
	       	<c:otherwise>
	         	<button class="btn btn-sm btn-info btnYellow" onclick="location.href='mySupportListView.me?userNo=${loginUser.userNo}&spage=${pi.currentPage + 1}'">&gt;</button>
	       	</c:otherwise>
	       </c:choose>
	</div>
	<br><br><br><br><br><br><br><br><br><br>
	
	<jsp:include page="../common/footer.jsp"></jsp:include>

</body>
</html>