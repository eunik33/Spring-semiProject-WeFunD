<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>게시판 - 공지작성</title>
<style>
#content, #noticeTitle {
	resize: none;
	width: 100%;
	font-size: 20px
}

#submit {
	width: 100px;
	height: 50px;
	float: right;
	margin-right: 1px;
}
</style>
<jsp:include page="/views/common/header2.jsp" />
</head>
<body>
		<div class="adminall">
			<jsp:include page="/views/common/adminMenu.jsp" />
			<div class="adminWrap">
				<div id="maincontent">
					<div class="title">
						<p>게시판 - 공지작성</p>
					</div>
					<hr>
					<div>
						<form action="insert.no" id="createform" method="post">
							<table width="100%">
								<tr>
									<td><input id="noticeTitle" type="text"
										placeholder="제목을 입력하세요" required name="title" /></td>
								</tr>
								<tr>
									<td width="100%"><textarea name="content" id="content"
											rows="20" placeholder="내용을 입력해주세요" required></textarea></td>
								</tr>
							</table>
							<div id="insertNotice">
								<button type="submit" id="submit" class="btn  btnYellow">작성</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	<br clear="both"><br><br><br><br><br><br><br>
</body>
<footer>
	<jsp:include page="/views/common/footer.jsp" />
</footer>
</html>
