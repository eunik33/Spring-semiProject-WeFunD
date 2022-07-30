<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰수정페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
    .container{
		max-width: 1000px;
		min-height: 1000px;
		margin-top: 15px;
        margin-bottom: 50px;
	}
	.page-title{
		text-align: center;
		margin-bottom: 15px;
		font-weight: bold;
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
        background-color: rgb(35, 45, 182);
    }
</style>
</head>
<body>

	<jsp:include page="../common/header2.jsp"/>
	
    <div class="container">
        <br>
        <h3 class="page-title">리뷰게시판</h3>

        <form enctype="multipart/form-data" action="update.rv" method="post">
			<input type="hidden" name="reviewNo" value="${r.reviewNo}">
            <table class="table table-borderless">
                <thead class="thead-light">
                    <tr>
                        <th style="text-align: center;" colspan="2">리뷰수정</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th style="width: 125px;">제목:</th>
                        <td><input type="text" name="reviewTitle" class="form-control" placeholder="글 제목" maxlength="50" value="${r.reviewTitle}"></td>
                    </tr>
                    <tr>
                      <th>후원프로젝트:</th>
                      <td>
                        <select name="projectName" class="custom-select" style="width: 400px;" disabled>
                            <option value="${r.supportNo}" selected>${r.projectName}</option>
                        </select>
                      </td>
                    </tr>
                    <tr>
                      <th>별점:</th>
                      <td>
                        <select id="rate" name="rate" class="custom-select" style="width: 100px;">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                        </select>
                        <script>
                        	$(function(){
                        		$("#rate option").each(function(){
                        			if($(this).text() == "${r.rate}"){
                        				$(this).attr("selected", "true");
                        			}
                        		})
                        	});
                        </script>
                      </td>
                    </tr>
                    <tr>
                        <th>사진첨부:</th>
                        <td>
                        	<c:choose>
                        		<c:when test="${not empty rat}">
	                        		<img id="contentImg" src="${rat.filePath}${rat.changeName}" width="200"><br>
	                        		<div id="contentImg-fileName">${rat.originName}</div>
	                        		<input type="hidden" name="originFileNo" value="${rat.fileNo}">
	                        		<input type="hidden" name="originFileName" value="${rat.changeName}">
                        		</c:when>
                        		<c:otherwise>
                        			<img id="contentImg" src="./resources/img/noimage.png" width="200"><br>
                        		</c:otherwise>
                        	</c:choose>
                        </td>
                    </tr>
                    <tr>
                    	<th><input type="hidden" id="checkDeleteOrigin" name="checkDeleteOrigin" value=""></th>
                    	<td><input id="reUpfile" type="file" name="reUpfile" onchange="loadImg(this,1)"><input type="button" value="파일 삭제" onclick="fileReset(this.form);"></td>
                    </tr>
                    <tr>
                        <th>내용:</th>
                        <td><textarea name="reviewContent" class="form-control" rows="10" placeholder="내용을 입력해주세요" style="resize: none;">${r.reviewContent}</textarea></td>
                    </tr>
                </tbody>	
            </table>

			<script>
	        	function loadImg(inputFile, num){
	        		if(inputFile.files.length == 1){
						var reader = new FileReader();

						reader.readAsDataURL(inputFile.files[0]);

						reader.onload = function(e){
							$("#contentImg").attr("src", e.target.result);
							$("#contentImg-fileName").attr("style", "display:none;");
						}
					}
	        	}
	        	
	        	function fileReset(form){
	        		$("#reUpfile").val(""); // 새 첨부파일 삭제
	        		$("#contentImg").attr("src", "./resources/img/noimage.png"); // 디폴트 사진으로 띄우기
	        		<c:if test="${not empty rat}">
	        			$("#checkDeleteOrigin").val("deleteOrigin"); // 원본파일 삭제
	        			$("#contentImg-fileName").attr("style", "display:none;"); // 원본 파일 이름 숨기기
	        		</c:if>
	        	}
            </script>
            <hr>

            <div align="center">
                <a href="detail.rv?rno=${r.reviewNo}" class="btn btn-secondary">돌아가기</a>
                <button type="submit" class="btn btnBlue">작성완료</button>
            </div>

        </form>

    </div>
    
    <jsp:include page="../common/footer.jsp"/>
    
</body>
</html>