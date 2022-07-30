<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰상세페이지</title>
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
        background-color: rgb(35, 45, 182);
    }
	.top-button-area{text-align: right;}
	.top-button-area>a,button{margin-bottom: 5px;}
	.review-area>thead>tr>th{
		text-align: center;
		font-size: 18px;
	}
	.review-title{text-align: center;}
	.review-info{text-align: right;}
	.review-suppport>a{
		color: black;
		text-decoration: underline;
	}
	.review-rate{ color: rgb(63, 74, 224);}
	.content-area{
		margin-top: 10px;
		min-height: 150px;
	}
	.reply-area{
		width: 100%;
		padding: 5px;
	}
	.reply-area>table{
		width: 100%;
		border-collapse:collapse;
	}
	.reply-profileImg{
		width: 50px;
		vertical-align: top;
	}
	.profileImg{
		border-radius: 50%;
		width:100%;
		height:50px;
	}
	.reply-writer{font-weight: bold;}
	.reply-date{
		font-size: 14px;
		color: rgb(117, 116, 116);
	}
	.modalBtn{
		border:none;
		background:none;
		font-weight: bold;
		color: rgb(54, 53, 53);
	}
	.reply-insert-area{
		margin-top: 10px;
		text-align: right;
	}
	.reply-insert-area>button{
		margin-top: 5px;
		margin-bottom: 50px;
	}
	.modal{text-align: center;}
</style>
</head>
<body>

	<jsp:include page="../common/header2.jsp"/>

    <div class="container">
    	<br>
    	<h3 class="page-title">리뷰게시판</h3>
        

		<!-- 돌아가기 / 글수정 / 글삭제  버튼 -->
        <div class="top-button-area">
        	<a href="list.rv?cpage=1" class="btn btn-secondary float-left">돌아가기</a>
        	
	       	<!-- 글 작성자와 관리자에게만 수정/ 삭제 버튼 보임 -->
	       	<c:if test="${(not empty loginUser) and ((loginUser.nickname eq r.reviewWriter) or (loginUser.userId eq 'admin')) }">
	            <a href="updateForm.rv?rno=${r.reviewNo}" class="btn btnBlue">수정</a>
	            <button type="button" data-toggle="modal" data-target="#deleteReviewModal" class="btn btn-danger">삭제</button>
	        </c:if>
        </div>

		<!-- 리뷰글 내용 -->
        <table class="table table-borderless review-area">
            <thead class="thead-light">
            	<tr>
            		<th class="review-title" colspan="2">${r.reviewTitle}</th>
                </tr>
            </thead>
            <tbody>
            	<tr>
            		<td class="review-info" style="padding-top:10px; padding-bottom:0px;">작성자:${r.reviewWriter}&nbsp;|&nbsp;작성일:${fn:substring(r.reviewDate, 0, 16)}&nbsp;(조회수:${r.count})</td>
				</tr>
				<tr style="border-bottom:1px solid lightgray;">
					<td class="review-suppport" style="padding-top:0px; padding-bottom:10px;">후원프로젝트: <a href="detail.pj?pno=${r.projectNo}">${r.projectName}</a>&nbsp;(<span class="review-rate">별점:${r.rate}점</span>)</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="content-area" >
							<div align="center">
							<c:if test="${rat ne null}">
		               			<img src="${rat.filePath}${rat.changeName}" width="400" onclick="window.open(this.src)"><br><br>
		               		</c:if>
		               		</div>
		               		<% pageContext.setAttribute("newLine", "\n"); %>
		               		<p>${fn:replace(r.reviewContent, newLine, '<br/>')}</p>
	               		</div>
               		</td>
                </tr>
			</tbody>
        </table>

       	
		<!-- 댓글 목록 (ajax이용해서 출력) -->
		<div class="reply-area">
        	<table>
     			<thead>
					<tr><th id="replyCount" colspan="2"></th></tr>
				</thead>
				<tbody>
					<!-- 댓글 목록 출력 공간 -->
				</tbody>
        	</table>		
		</div>
       
		<!-- 댓글 입력창 -->
		<div class="reply-insert-area">
			<!-- 로그인한 회원만 댓글 작성 가능 -->
			<c:choose>
				<c:when test="${not empty loginUser}">
					<textarea id="replyContent" class="form-control" rows="3" placeholder="댓글 입력" style="resize: none;"></textarea>
					<button id="replyBtn" class="btn btn-info" onclick="insertReply();">작성</button>
				</c:when>
				<c:otherwise>
					<textarea id="" class="form-control" rows="3" style="resize: none;" readonly>로그인 후 이용 가능합니다.</textarea>
					<button class="btn btn-info disabled">작성</button>
				</c:otherwise>
			</c:choose>
		</div>
		
    </div>
    
    
    <!-- 댓글 목록 관련 함수 -->
    <script>
	 	// 댓글 목록 가져오기
		function selectReplyList(){
			$.ajax({
				url : "rlist.rv",
				data : {rno : ${r.reviewNo}},
				success : function(list){
					// 총 댓글 수 출력
					$("#replyCount").text("댓글 " + list.length + "개");
					
					var loginNickname = "${loginUser.nickname}"; // 로그인한 유저의 닉네임
					
					var result = "";
					for(var i in list){
						result += '<div class="reply" style="margin-top:5px;">'
								+ 	'<tr style="border-top:1px solid lightgray;">'
								+ 		'<td rowspan="2" class="reply-profileImg"><img src="./resources/img/user.png" class="profileImg"></td>'
								+ 		'<td class="reply-writer">' + list[i].replyWriter + '</td>'
								+ 	'</tr>'
								+ 	'<tr><td class="reply-content"><p>' + list[i].replyContent.replaceAll("\n", "<br/>") + '</p></td></tr>'
								+ 	'<tr>'
								+ 		'<td></td>'
								+ 		'<td class="reply-date">' + list[i].replyDate.substring(0,16);
									
						if(list[i].replyWriter == loginNickname){
							result += 		'<input type="button" class="modalBtn" data-toggle="modal"  data-target="#updateReplyModal" data-id="'+list[i].replyNo + ',' +list[i].replyContent+'" value="수정"/>|'
									+ 		'<input type="button" class="modalBtn" data-toggle="modal" data-target="#deleteReplyModal" data-id="'+list[i].replyNo + '" value="삭제"/>';
						} else if(loginNickname != "") {
							result += 		'<input type="button" class="modalBtn" data-toggle="modal" data-target="#reportModal" data-id="'+list[i].replyNo+',' + loginNickname +'" value="신고"/>'
						}
						result += 		'</td>'
								+	'</tr>'
								+ '</div>';
					}
					
					// 댓글목록에 댓글들 출력
					$('.reply-area tbody').html(result);
					
					// 모달창으로 넘길 값 세팅
					$('.modalBtn').click(function(){
						var data = $(this).attr('data-id');
		   				var dataList = data.split(','); // 댓글번호,댓글내용
		   				
		   				$('.replyNo').val(dataList[0]);
		   				$('#update-modal').html('<textarea id="upReplyContent" class="form-control" rows="5" style="resize: none;">' + dataList[1] + '</textarea>');
		   			});
				},
	   			error : function(){
	   				console.log('댓글 읽어오기 실패');
	   			}
	   		});
	    }
    	
 		// 댓글 목록 출력
    	$(function(){
    		selectReplyList();
    		
    	});

    	// 댓글 작성
    	function insertReply(){
    		if($('#replyContent').val().trim() != ''){
	    		$.ajax({
	    			url : 'rinsert.rv',
	    			data : {
	   					reviewNo : ${r.reviewNo}, // 리뷰글 번호
	   					replyContent : $('#replyContent').val(), // 작성한 댓글 내용
	   					replyWriter : '${loginUser.userNo}' // 작성자
	    			}, success : function(result){
	    				if(result == 'success'){
	    					selectReplyList();
	    					
	    					$('#replyContent').val(''); // 댓글 작성창 내용 초기화
	    				}
	    			}, error : function(){
	    				console.log('댓글 작성 실패');
	    			}
	    		});
    		}
    		else{
    			alert('댓글 공백으로 작성 불가');
    		}
    	}

    </script>
	
    <!-- 리뷰글 삭제 모달 -->
	<div class="modal" id="deleteReviewModal" style="text-align: center;">
		<div class="modal-dialog">
			<div class="modal-content">
                <div class="modal-body">
                    <div style="margin:30px;">
                		<h6>게시글을 삭제하시겠습니까?</h6>
                	</div>
                    <div align="center">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <a href="delete.rv?rno=${r.reviewNo}" class="btn btn-danger">삭제하기</a>
                    </div>
                </div>
		
			</div>
		</div>
	</div>

    <!-- 댓글 수정 모달창 -->
	<div class="modal updateReplyModal" id="updateReplyModal">
		<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title w-100 text-center">댓글 수정</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
                </div>
        
                <div class="modal-body">
                   	<input type="hidden" id="upReplyNo" class="replyNo">
                       <div id="update-modal">
                               <!-- <textarea id="upReplyContent" class="form-control" rows="5" style="resize: none;">기존댓글내용</textarea> -->
                       </div>
                       <br>
                       <div align="center">
                           <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                           <button type="button" class="btn btn-primary" onclick="updateReply();" data-dismiss="modal">수정</button>
                       </div>
                </div>
            </div>
		</div>
	</div>

	<script>
		function updateReply(){
			$.ajax({
				url : 'rupdate.rv',
				data : {
					replyNo : $('#upReplyNo').val(),
					replyContent : $('#upReplyContent').val()
				}, success : function(result){
					if(result == 'success'){
						selectReplyList();
					}
				}, error : function(){
					console.log('댓글 수정 실패');
				}
			});
		}

	</script>

    <!-- 댓글 삭제 모달 -->
	<div class="modal" id="deleteReplyModal">
		<div class="modal-dialog">
			<div class="modal-content">
                <div class="modal-body">
                    <div style="margin:30px;">
                		<h6>댓글을 삭제하시겠습니까?</h6>
                	</div>
                    <input type="hidden" id="delReplyNo" class="replyNo">
                    <div align="center">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" onclick="deleteReply();" data-dismiss="modal">삭제</button>
                    </div>
                </div>
			</div>
		</div>
	</div>

	<script>
		function deleteReply(){
			$.ajax({
				url : 'rdelete.rv',
				data : {replyNo : $('#delReplyNo').val()},
				success : function(result){
					if(result == "success"){
						selectReplyList();
					}
				}, error : function(){
					console.log('댓글 삭제 실패');
				}
			});
		}
	</script>

    <!-- 사용자 신고 모달 -->
	<div class="modal" id="reportModal">
		<div class="modal-dialog">
			<div class="modal-content">
                <div class="modal-body">
                	<div style="margin:30px;">
                		<h6>사용자를 신고하시겠습니까?</h6>
                	</div>
                    <input type="hidden" id="reportReplyNo" class="replyNo">
                    <div align="center">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-danger" onclick="reportReply();" data-dismiss="modal">신고하기</button>
                    </div>
                </div>
			</div>
		</div>
	</div>
	
	<script>
		function reportReply(){
			$.ajax({
				url : 'rreport.rv',
				data : {
						replyNo : $('#reportReplyNo').val(),
						replyReporter : ${loginUser.userNo}
				}, success(result){
					if(result == 'success'){
						alert('댓글 신고가 접수되었습니다.')
						selectReplyList();
					}
					else {
						alert('이미 신고한 댓글입니다.');
					}
				}, error : function(){
					console.log('댓글 신고 실패');
				}
			});
		}
	</script>
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>