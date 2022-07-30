<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항수정페이지</title>
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
        <h3 class="page-title">공지사항</h3>

        <form action="update.no" method="post">
        	<input type="hidden" name="noticeNo" value="${n.noticeNo}">
        	
            <table class="table table-bordered">
                <thead class="thead-light" align="center">
                    <tr>
                        <th>공지사항 수정</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input type="text" class="form-control" name="noticeTitle" placeholder="공지사항 제목" value="${n.noticeTitle}" required ></td>
                    </tr>
                    <tr>
                        <td>
                            <textarea class="form-control" name="noticeContent" rows="15" placeholder="공지사항 내용" style="resize: none;" required>${n.noticeContent}</textarea>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div align="center">
                <button type="button" class="btn btn-secondary" onclick="history.back();">돌아가기</button>
                <button type="submit" class="btn btnBlue">수정완료</button>
            </div>
            
        </form>

    </div>
    
    <jsp:include page="../common/footer.jsp"/>
</body>
</html>