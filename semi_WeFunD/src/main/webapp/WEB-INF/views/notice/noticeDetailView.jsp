<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항상세페이지</title>
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
	table>thead>tr>th{
		text-align: center;
		font-size: 18px;
	}
	.btnBlue{
		color: white;
		background-color: rgb(63, 74, 224);
	}
	.btnBlue:hover{
        color:white;
        background-color: rgb(35, 46, 194);
    }
    .modal{text-align: center;}
</style>
</head>
<body>

	<jsp:include page="../common/header2.jsp"/>
	
    <div class="container">
		<br>
        <h3 class="page-title">공지사항</h3>

        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th>[공지사항]&nbsp;${n.noticeTitle}</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                  	<td align="right">작성자:${n.noticeWriter}&nbsp;|&nbsp;작성일:${fn:substring(n.noticeDate, 0, 16)}&nbsp;(조회수:${n.count})</td>
                </tr>
                <tr>
                	<% pageContext.setAttribute("newLine", "\n"); %>
                  	<td><p style="min-height:500px;">${fn:replace(n.noticeContent, newLine, '<br/>')}</p></td>
                </tr>
            </tbody>
        </table>

        <br><br>
        <hr>

		<c:if test="${(loginUser ne null) and (loginUser.userId eq 'admin')}">
			<div align="right">
	        	<a class="btn btnBlue" onclick="postFormSubmit(1)">수정</a>  
		        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteNotice">삭제</button>
	        </div>
		</c:if>
        
		<div align="center">
			<a href="list.not?cpage=1"class="btn btn-secondary">돌아가기</a>
		</div>

    </div>
	
	<form action="" method="post" id="postForm">
		<input type="hidden" value="${n.noticeNo}" name="nno">
	</form>
	
	<script>
		function postFormSubmit(num){
			if(num == 1){ // 수정 버튼 클릭 시
				$('#postForm').attr('action', 'updateForm.no').submit();
			}
			else{ // 모달창에서 삭제하기 버튼 클릭 시
				$('#postForm').attr('action', 'delete.no').submit();
			}
		}
	</script>
	
    <!-- 공지사항 삭제 모달 -->
	<div class="modal" id="deleteNotice">
		<div class="modal-dialog">
			<div class="modal-content">
                <div class="modal-body">
                    <div style="margin:30px;">
                		<h6>공지사항을 삭제하시겠습니까?</h6>
                	</div>
                    <div align="center">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <a class="btn btn-danger" onclick="postFormSubmit(2)">삭제하기</a>
                    </div>
                </div>
			</div>
		</div>
	</div>
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>