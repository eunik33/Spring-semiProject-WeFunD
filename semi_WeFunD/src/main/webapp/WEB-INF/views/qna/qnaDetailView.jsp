<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA상세페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.container{
		max-width: 1000px;
		min-height: 800px;
		margin-top: 15px;
        margin-bottom: 15px;
	}
	table>thead>tr>th{
		text-align: center;
		font-size: 18px;
	}
	.content{min-height: 200px;}
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
        
        <h2 style="text-align:center">QnA</h2>
		<br>
        <table class="table table-bordered">
            <thead class="thead-light">
                <tr>
                    <th>${q.qnaTitle}</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                	<td align="right">작성자:&nbsp;${q.qnaWriter}&nbsp;|&nbsp;작성일:&nbsp;${fn:substring(q.qnaDate, 0, 16)}</td>
                </tr>
                <tr>
                	<% pageContext.setAttribute("newLine", "\n"); %>
                	<td><p class="content">${fn:replace(q.qnaContent, newLine, '<br/>')}</p></td>
                </tr>
            </tbody>
        </table>

        <c:choose>
        	<%-- 접수 상태일 경우 --%>
        	<c:when test="${empty q.answer}">
        		<%-- 해당 글을 쓴 회원일 경우 수정, 삭제 버튼이 보임 --%>
        		<c:if test="${loginUser.nickname eq q.qnaWriter}">
			        <div align="right">
			            <a class="btn btnBlue" onclick="postFormSubmit(1)">수정</a> 
			            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteQnAModal">삭제</button>
			        </div>
			    </c:if>
			    <%-- 관리자의 경우 답변입력창과 답변 작성 버튼이 보임 --%>
				<c:if test="${loginUser.userId eq 'admin'}">
			            <textarea id="writeAnswer" class="form-control" rows="10" placeholder="답변 입력" style="resize: none;"></textarea>
			            <div align="right" style="margin-top:5px;">
			            	<button type="button" class="btn btn-info" onclick="postFormSubmit(3)">작성</button>
			            </div>
	        	</c:if>  
        	</c:when>
        	
        	<%-- 답변완료 상태일 경우 답변 내용 띄우기 --%>
        	<c:otherwise>
	        	<table class="table table-bordered">
		            <thead class="thead-light">
		                <tr>
		                    <th>답변완료</th>
		                </tr>
		            </thead>
		            <tbody>
		                <tr>
		                    <td align="right">작성자:&nbsp;관리자&nbsp;|&nbsp;작성일:&nbsp;${fn:substring(q.answerDate, 0, 16)}</td>
		                </tr>
		                <tr id="showAnswer-area">
		                    <td><p style="min-height:200px;">${fn:replace(q.answer, newLine, '<br/>')}</p></td>
		                </tr>
		                <tr id="updateAnswer-area" style="display:none;">
		                	<td>
	        					<textarea id="updateAnswer" class="form-control" rows="10" placeholder="답변 입력" style="resize: none;">${q.answer}</textarea>
		       				   	<div align="right" style="margin-top:5px;">
		       				   		<button type="button" class="btn btn-info" onclick="updateAnswer();">수정</button>'
		       				   		<button type="button" class="btn btn-secondary" onclick="closeUpdateAnswerArea();">취소</button>
		       				    </div>
	       				  	</td>
		                </tr>
		            </tbody>
	        	</table>
	        	
	        	<%-- 관리자일 경우 QNA 삭제, 답변수정버튼 보임 --%>
				<c:if test="${loginUser.userId eq 'admin'}">
			        <div align="right">
			       		<button type="button" id="showUpdateAnswerAreaBtn" class="btn btn-info" onclick="showUpdateAnswerArea();">답변수정</button>
			            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteQnAModal">삭제</button>
			        </div>
				</c:if>
        	</c:otherwise>
        </c:choose>
        
        <form action="" method="post" id="postForm">
			<input type="hidden" name="qnaNo" value="${q.qnaNo}">
			<input type="hidden" name="answer" value="">
		</form>
		
		<script>
			function postFormSubmit(num){
				if(num == 1){ // 수정 버튼 클릭 시
					$('#postForm').attr('action', 'updateForm.qna').submit();
				}
				else if(num == 2){ // 모달창에서 삭제하기 버튼 클릭 시
					$('#postForm').attr('action', 'delete.qna').submit();
				}
				else{ // 답변 작성 버튼 클릭 시
					$('#postForm input[name="answer"]').attr('value', $('#writeAnswer').val());
					$('#postForm').attr('action', 'insertAnswer.qna').submit();
				}
			}
		</script>
        
        
        <div align="center">
			<a href="list.qna?cpage=1" class="btn btn-secondary">돌아가기</a>
		</div>



    </div>

	<script>
		// 관리자가 답변수정 버튼 클릭할 때 실행되는 함수
		function showUpdateAnswerArea(){
			$("#showAnswer-area").attr("style", "display:none;"); // 기존 답변 내용 숨기기
			$("#updateAnswer-area").attr("style", "display:'';"); // 답변 입력창 보이게 바꿈
			$("#showUpdateAnswerAreaBtn").attr("style", "display:none;"); // 답변수정 버튼 숨기기
		}
		

		// 답변 수정용  ajax
	    function updateAnswer(){
			if($('#updateAnswer').val().trim() != ''){
				
		    	$.ajax({
					url : "updateAnswer.qna",
					data : {
						qnaNo : ${q.qnaNo},
						answer : $('#updateAnswer').val()
					}, success : function(result){
						if(result == 'success'){
							closeUpdateAnswerArea(); // 답변 입력창 숨기기
							showNewAnswer(); // 새로 작성한 답변 띄우기
						}
					}, error : function(){
	    				console.log("답변 수정 실패");
	    			}
				});
			} else { // 공란일 시 수정 불가
				alert("답변 내용을 입력해주세요.");
			}
	    }
		
		// 새로 작성된 답변 출력용 ajax
		function showNewAnswer(){
			$.ajax({
				url : "selectAnswer.qna",
				data : {qno : ${q.qnaNo}},
				success : function(answer){
					result = '<td><p class="content">' + answer.replaceAll("\n", "<br/>") + '</p></td>';
					$("#showAnswer-area").html(result);
				},
    			error : function(){
    				console.log("답변 가져오기 실패");
    			}
			});
		}
		
		// 관리자가 취소 버튼 클릭할 때 실행되는 함수
		function closeUpdateAnswerArea(){
			$("#showAnswer-area").attr("style", "display:'';"); // 기존 답변 내용 다시 띄우기
			$("#updateAnswer-area").attr("style", "display:none;"); // 답변 입력창 숨기기
			$("#showUpdateAnswerAreaBtn").attr("style", "display:'';"); // 답변수정 버튼 다시 띄우기
		}
	</script>
	
    <!-- QnA 삭제 모달 -->
	<div class="modal" id="deleteQnAModal" style="text-align: center;">
		<div class="modal-dialog">
			<div class="modal-content">
                <div class="modal-body">
                    <div style="margin:30px;">
                        <h6>QnA글을 삭제하시겠습니까?</h6>
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