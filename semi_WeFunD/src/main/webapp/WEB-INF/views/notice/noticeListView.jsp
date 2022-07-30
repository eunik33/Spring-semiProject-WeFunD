<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항목록페이지</title>
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
	
	/* 공지사항 목록 */
	table>thead,tbody{text-align: center;}
	.title{text-align: left;}
	.title>a{color: black;}
	
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
		color: white;
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
            <a href="list.not?cpage=1" class="nav-selected"><b>공지사항</b></a>
            <a href="list.qna?cpage=1">QnA</a>
        </div>

		
        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th width="70">글번호</th>
                    <th width="480">제목</th>
                    <th width="100">작성자</th>
                    <th width="120">작성일</th>
                    <th width="80">조회수</th>
                </tr>
            </thead>
            <tbody>
            	<c:choose>
            		<c:when test="${empty list}">
	            		<tr>
	            			<td colspan="5">공지사항 글이 없습니다.</td>
	            		</tr>
            		</c:when>
            		<c:otherwise>
            			<c:forEach var="n" items="${list}">
	            		<tr>
		                    <td>${n.noticeNo}</td>
		                    <td class="title"><a href="detail.no?nno=${n.noticeNo}">[공지사항]&nbsp;${n.noticeTitle}</a></td>
		                    <td>${n.noticeWriter}</td>
		                    <td>${fn:substring(n.noticeDate, 0, 10)}</td>
		                    <td>${n.count}</td>
	                	</tr>
						</c:forEach>
					</c:otherwise>
            	</c:choose>
            </tbody>
        </table>


		<!-- 관리자만 글작성 버튼이 보임-->
		<!-- 관리자페이지의 공지사항 작성 페이지로 이동-->
		<c:if test="${loginUser.userId eq 'admin'}">
            <div align="right">
            	<a href="enrollForm.no" class="btn btnBlue">글작성</a>
        	</div>
        </c:if>


		<div align="center" class="paging-area">
			<c:if test="${pi.currentPage ne 1}">
				<button class="btn btn-sm btnYellow" onclick="location.href='list.not?cpage=${pi.currentPage - 1}'">&lt;</button>
			</c:if>
			<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}" step="1">
				<c:choose>
					<c:when test="${i ne pi.currentPage}">
						<button class="btn btn-sm btnYellow" onclick="location.href='list.not?cpage=${i}'">${i}</button>
					</c:when>
					<c:otherwise>
						<button class="btn btn-sm btnYellow" disabled>${i}</button>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${(pi.currentPage ne pi.maxPage) and (pi.maxPage ne 0)}">
				<button class="btn btn-sm btnYellow" onclick="location.href='list.not?cpage=${pi.currentPage + 1}'">&gt;</button>
			</c:if>
		</div>

    </div>
    
    <jsp:include page="../common/footer.jsp"/>
    
</body>
</html>