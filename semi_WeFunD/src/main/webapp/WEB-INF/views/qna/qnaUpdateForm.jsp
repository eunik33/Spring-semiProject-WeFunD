<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QNA수정페이지</title>
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
</style>
</head>
<body>
	
	<jsp:include page="../common/header2.jsp"/>

    <div class="container">
        <br>
        <h3 class="page-title">QnA</h3>

        <form action="update.qna" method="post">
        	<input type="hidden" name="qnaNo" value="${q.qnaNo}">
        	
            <table class="table">
                <thead class="thead-light">
                    <tr>
                        <th>QnA 글 수정</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input type="text" class="form-control" name="qnaTitle" placeholder="Q&A 제목" value="${q.qnaTitle}" required></td>
                    </tr>
                    <tr>
                        <td>
                            <textarea class="form-control" name="qnaContent" rows="15" placeholder="Q&A 문의 내용" style="resize: none;" required>${q.qnaContent}</textarea>
                        </td>
                    </tr>
                </tbody>
            </table>

            <hr>

            <div align="center">
                <button type="button" class="btn btn-secondary" onclick="history.back();">돌아가기</button>
                <button type="submit" class="btn btnBlue">수정완료</button>
            </div>
            
        </form>

    </div>

    <jsp:include page="../common/footer.jsp"/>
</body>
</html>