<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰글목록</title>
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
	.reviewList-area{
		width: 100%;
		overflow:hidden;
		height:auto;
	}
	.reviewList{
		width: 100%;
        height: 370px;
        margin-top: 20px;
        margin-left: 24px;
	}
	.reviewList> div{float:left;}
	.review{
        width: 23%;
        height: 100%;
        display: inline-block;
        margin-right: 10px;
        margin-bottom:20px;
        cursor: pointer;
        border: 1px solid black;
        border-radius:10px;
        padding: 10px;
    }
    .review-top-area>p, table{
    	margin:0px;
    	margin-top: 8px;
    }
	.review-top-area:hover, .review-bottom-area:hover{
		cursor: pointer;
		opacity: 0.8;
	}

	#reviewImg{
		width: 100%;
		height: 160px;
		border-radius:10px;
	}
	#review-title{
		font-weight: bold;
		font-size: 15px;
		height: 45px;
		overflow: hidden;
		text-overflow: ellipsis;
		word-break: break-word;
		display: -webkit-box;
   		-webkit-line-clamp: 2;
   		-webkit-box-orient: vertical;
	}
	.review-writer-date{width: 100%;}
	#review-profileImg, #project-thumbnail{
		width: 40px;
		height:40px;
	}
	#review-writer, #review-date{
		color: rgb(85, 85, 85);
		font-size: 14px;
	}
	#review-writer{font-weight: bold;}
	.review-project{
		width: 100%;
		table-layout: fixed;
		border-collapse:collapse;
	}
	#project-title{
		font-weight: bold;
		font-size : 13px;
		text-overflow: ellipsis;
		overflow: hidden;
	}
	#review-rate{font-size : 14px;}
	
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
        <h3 class="page-title">리뷰게시판</h3>
        <hr>
        
        <div class="reviewList-area">
        	<div class="reviewList">
        	<c:choose>
        		<c:when test="${empty list}">
        			등록된 게시글이 없습니다.
        		</c:when>
        		<c:otherwise>
        			<c:forEach var="r" items="${list}">
						<div class="review">
							<div class="review-top-area">
								<input type="hidden" value="${r.reviewNo}">
								<c:choose>
									<c:when test="${r.reviewImg ne null}">
										<img src="${r.reviewImg}" id="reviewImg">
									</c:when>
									<c:otherwise>
										<img src="./resources/img/reviewDefaultImg.png" id="reviewImg">
									</c:otherwise>
								</c:choose>
								<p id="review-title">${r.reviewTitle}</p>
								<table class="review-writer-date">
									<tr><td rowspan="2" id="review-profileImg"><img src="./resources/img/user.png" width="100%" height="100%"></td><td id="review-writer">${r.reviewWriter}</td></tr>
									<tr><td id="review-date">${r.reviewDate}</td></tr>
								</table>
								<p id="review-count" align="right">조회수: ${r.count}</p>
							</div>
							
							<div class="review-bottom-area">
								<input type="hidden" value="${r.projectNo}">
								<table class="review-project">
									<tr style="border-top:1px solid lightgray;">
										<td rowspan="2" id="project-thumbnail"><img src="${r.projectThumbnail}" width="100%" height="100%"></td>
										<td id="project-title"><nobr>${r.projectName}</nobr></td>
									</tr>
									<tr><td id="review-rate">별점 : ${r.rate}점</td></tr>
								</table>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</div>
		</div>

		<!-- 리뷰글작성버튼 회원한테만 보임 (관리자, 비회원X) -->
		<c:if test="${(not empty loginUser) and (loginUser.userId ne 'admin')}">
			<div align="right" style="margin-right:20px;">
				<form action="enrollForm.rv" method="post">
					<input type="hidden" name="userNo" value="${loginUser.userNo}">
					<button type="submit" class="btn btnBlue">글작성</button>
				</form>
        	</div>
        </c:if>

		<!-- 페이지 이동 버튼 -->
        <div align="center" class="paging-area">
			<c:if test="${pi.currentPage ne 1}">
				<button class="btn btn-sm btnYellow" onclick="location.href='list.rv?cpage=${pi.currentPage - 1}'">&lt;</button>
			</c:if>
			<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}" step="1">
				<c:choose>
					<c:when test="${i ne pi.currentPage}">
						<button class="btn btn-sm btnYellow" onclick="location.href='list.rv?cpage=${i}'">${i}</button>
					</c:when>
					<c:otherwise>
						<button class="btn btn-sm btnYellow" disabled>${i}</button>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${(pi.currentPage ne pi.maxPage) and (pi.maxPage ne 0)}">
				<button class="btn btn-sm btnYellow" onclick="location.href='list.rv?cpage=${pi.currentPage + 1}'">&gt;</button>
			</c:if>
		</div>

    </div>

  	<script>
		$(function(){
			$(".review-top-area").click(function(){
				var rno = $(this).children().eq(0).val();
				location.href = "detail.rv?rno=" + rno;
			});
			
			$(".review-bottom-area").click(function(){
				var pno = $(this).children().eq(0).val();
				location.href = "detail.pj?pno=" + pno;
			});
		});
	</script>
	
	<jsp:include page="../common/footer.jsp"/>
	
</body>
</html>