<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰작성페이지</title>
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
	table th{
        text-align: right;
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

        <form action="insert.rv" method="post" enctype="multipart/form-data">
			<input type="hidden" name="reviewWriter" value="${loginUser.userNo}">
			
            <table class="table table-borderless">
                <thead class="thead-light">
                    <tr>
                        <th style="text-align: center;" colspan="2">리뷰작성</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th style="width: 125px;">제목:</th>
                        <td><input type="text" name="reviewTitle" class="form-control" maxlength="50" placeholder="글 제목" required></td>
                    </tr>
                    <tr>
                        <th>후원내역:</th>
                        <td>
                            <select name="supportNo" class="custom-select" style="width: 400px;" required>
	                            <option value="">프로젝트 선택</option>
	                            <c:forEach var="s" items="${sList}">
	                            	<option value="${s.supportNo}">${s.projectName}(${fn:substring(s.supportDate, 0, 16)})</option>
	                            </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>별점:</th>
                        <td>
                            <select name="rate" class="custom-select" style="width: 100px;">
                                <option value="1">1점</option>
                                <option value="2">2점</option>
                                <option value="3">3점</option>
                                <option value="4">4점</option>
                                <option value="5" selected>5점</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>사진첨부:</th>
                        <td><img id="contentImg" src="./resources/img/noimage.png" width="200" height="150"><br></td>
                    </tr>
                    <tr>
                    	<th></th>
                    	<td><input type="file" id="upfile" name="upfile" onchange="loadImg(this,1)"><input type="button" value="파일 삭제" onclick="fileReset(this.form);"></td>
                    </tr>
                    
                    <tr>
                        <th>내용:</th>
                        <td><textarea class="form-control" name="reviewContent" rows="10" placeholder="내용을 입력해주세요" style="resize: none;" required></textarea></td>
                    </tr>
                </tbody>	
            </table>

	        <script>
	     		// 선택된 파일을 읽여들여서 그 영역에 맞는 미리보기
	        	function loadImg(inputFile, num){
	        		if(inputFile.files.length == 1){ // 파일이 있는지 확인

						var reader = new FileReader();

						// 어느 파일을 읽을 것인지 인자 값으로 전달해줌
						reader.readAsDataURL(inputFile.files[0]);
						// 해달 파일을 읽어들이는 순간 그 파일만의 고유한 긴 url이 부여됨
						// => 해당 url을 src속성으로 부여할 것 (attr)

						// 파일 읽기가 완료되었을 때 실행할 함수를 정의
						reader.onload = function(e){
							// e의 target.result에 각 파일의 url이 담김

							// 영역에 맞춰서 이미지 미리보기
							$("#contentImg").attr("src", e.target.result);
						}
					}
	        	}
	        	function fileReset(form){
	        		$("#upfile").val("");
	        		$("#contentImg").attr("src", "./resources/img/noimage.png");
	        	}
            </script>

            <hr>

            <div align="center">
                <button type="button" class="btn btn-secondary" onclick="history.back();">돌아가기</button>
                <button type="submit" class="btn btnBlue">작성완료</button>
            </div>

        </form>

    </div>
    
    <jsp:include page="../common/footer.jsp"/>
</body>
</html>