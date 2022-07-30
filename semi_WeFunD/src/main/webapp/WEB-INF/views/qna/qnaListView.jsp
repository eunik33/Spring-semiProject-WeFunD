<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA목록페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.container{
		max-width: 1000px;
		min-height: 800px;
		margin-top: 15px;
		margin-bottom: 50px;
	}
	.page-title{
		text-align: center;
		margin-bottom: 15px;
		font-weight : bold;
	}
	
	/* nav영역 */
	.nav-area{margin-bottom: 5px;}
	.nav-area>a{
		text-decoration: none;
		font-size: 18px;
		color: black;
	}
	.nav-area>.nav-selected{
		font-weight: bold;
		font-size: 25px;
		color: rgb(63, 74, 224);;
	}
	
	/* qna목록 */
	table>thead,tbody{text-align: center;}
	.title{text-align: left;}
	.title:hover{
		cursor: pointer;
		text-decoration:underline;
	}
	.title>a{color: black;}
	.answered{color: rgb(63, 74, 224);}
	
	/* 버튼 색상 */
	.btnBlue{
		color: white;
		background-color: rgb(63, 74, 224);
	}
	.btnBlue:hover{
        color:white;
        background-color: rgb(35, 46, 194);
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

	<jsp:include page="../common/header2.jsp"/>
	
	 <div class="container">
        <br>
        <h3 class="page-title">고객센터</h3>

        <div class="nav-area">
            <a href="list.not?cpage=1">공지사항</a>
            <a href="list.qna?cpage=1" class="nav-selected">QnA</a>
        </div>

        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th width="70">글번호</th>
                    <th width="480">제목</th>
                    <th width="100">작성자</th>
                    <th width="120">작성일</th>
                    <th width="80">처리상태</th>
                </tr>
            </thead>
            <tbody>
            	<c:choose>
            		<c:when test="${ empty list }">
            			<tr>
            				<td colspan="5">등록된 문의 글이 없습니다</td>
            			</tr>
            		</c:when>
            		<c:otherwise>
            			<c:forEach var="q" items="${list}">
            				<tr>
			                    <td>${q.qnaNo}</td>
			                    <td class="title">${q.qnaTitle}</td>
			                    <td>${q.qnaWriter}</td>
			                    <td>${q.qnaDate}</td>
			                    <c:choose>
			                    	<c:when test="${q.answer eq null}">
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
            </tbody>
        </table>

		<script>
			$(document).on("click", ".title", function(){
				var loginUserNick = "${loginUser.nickname}"; // 로그인한 유저의 닉네임(unique)
				var qno = $(this).siblings().eq(0).text();
				var qnaWriter = $(this).siblings().eq(1).text();
				
				if(loginUserNick == ""){ // 로그인 안 했을 경우
					alert("로그인 후 열람 가능합니다.");
					location.href="loginForm.me";
				} else {
					if(qnaWriter == loginUserNick || loginUserNick == "관리자"){ // 글작성자이거나 관리자일 경우
						location.href="detail.qna?qno=" + qno;
					} else {
						alert("본인 문의글만 열람 가능합니다.");
					}
				}
			});
		</script>
		
		<!-- 회원만 글작성 버튼이 보이게끔(비회원, 관리자 X) -->
		<c:if test="${(loginUser ne null) and (loginUser.userId ne 'admin')}">
			<div align="right">
            	<a href="enrollForm.qna" class="btn btnBlue">글작성</a>
        	</div>
		</c:if>
        
        
        <div align="center" class="paging-area">
			<c:if test="${pi.currentPage ne 1}">
				<button class="btn btn-sm btnYellow" onclick="location.href='list.qna?cpage=${pi.currentPage - 1}'">&lt;</button>
			</c:if>
			
			<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
				<c:choose>
					<c:when test="${i ne pi.currentPage}">
						<button class="btn btn-sm btnYellow" onclick="location.href='list.qna?cpage=${i}'">${i}</button>
					</c:when>
					<c:otherwise>
						<button class="btn btn-sm btnYellow" disabled>${i}</button>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${(pi.currentPage ne pi.maxPage) and (pi.maxPage ne 0)}">
				<button class="btn btn-sm btnYellow" onclick="location.href='list.qna?cpage=${currentPage + 1}'">&gt;</button>
			</c:if>
			
		</div>

    </div>
    
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>