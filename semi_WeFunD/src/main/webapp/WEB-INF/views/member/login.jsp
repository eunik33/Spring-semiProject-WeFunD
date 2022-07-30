<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String errorMsg = (String)request.getAttribute("errorMsg");
    System.out.println(errorMsg);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <style>
        div{
            box-sizing : border-box;
            /*border : 1px solid red;*/
        }
        
        /*login*/
        #loginP{
            font-size: 32px;
            font-weight: 500;
        }

        #outer{
            width : 1000px;
            height : 800px;
            margin : auto;
            
        }
        #login{
            width: 350px;
            height: 400px;
            text-align: center;
            margin: auto;
            margin-top: 100px;
        }
        #userId, #userPwd{
            border-top: 0;
            border-left: 0;
            border-right: 0;
            margin-top: 10px;
        }
        #userId, #userPwd, #loginBtn{
            width: 230px;
            height: 30px;
        }
        #userPwd{
            margin-top: 20px;
            margin-bottom: 10px;
        }
        #idSaveP, #searchIdPwd{
            font-size: 15px;
        }
        #searchIdPwd{
            text-decoration: none; 
            cursor: pointer; 
            color: black;
        }
        #loginBtn{
            background-color: rgb(247, 217, 58);
            border: none;
            cursor: pointer;
        }
        #loginBtn:hover{
            opacity: 0.8;
        }
        #signUp{
            color: rgb(63, 74, 224);
            font-size: 15px;
            text-decoration : none;
        }
        #hr{
            width: 250px;
        }

    </style>
</head>
<body>


	<%@ include file="../common/header2.jsp" %>
	
    <div id="outer">

        <div id="login">

            <form id="login-form" method="post" action="login.me">

                <p id="loginP">로그인</p>

                <input type="text" name="userId" id="userId" placeholder="아이디" required>
                <input type="password" name="userPwd" id="userPwd" placeholder="비밀번호" required><br><br>
                <input type="checkbox" name="idSave" id="idSave"><span id="idSaveP">아이디 저장</span> &nbsp;&nbsp;
                <a id="searchIdPwd" href="">아이디/비밀번호 찾기</a><br><br>

                <button id="loginBtn" onclick="login()">로그인</button><br><br>

            </form>
            
            <hr id="hr">
            <br>
            <span style="font-size: 15px;">WeFun:D 계정이 없다면</span>&nbsp;&nbsp;
            <a id="signUp" href="">회원가입</a>
        </div>
        
    </div>
    
    <script>

        /*쿠키값저장코드*/   
        function setCookie(cookieName, value, exdays){
            var exdate = new Date();
            exdate.setDate(exdate.getDate() + exdays);
            var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
            document.cookie = cookieName + "=" + cookieValue;
        }
        
        function deleteCookie(cookieName){
            var expireDate = new Date();
            expireDate.setDate(expireDate.getDate() - 1);
            document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
        }
        
        function getCookie(cookieName) {
            cookieName = cookieName + '=';
            var cookieData = document.cookie;
            var start = cookieData.indexOf(cookieName);
            var cookieValue = '';
            if(start != -1){
                start += cookieName.length;
                var end = cookieData.indexOf(';', start);
                if(end == -1)end = cookieData.length;
                cookieValue = cookieData.substring(start, end);
            }
            return unescape(cookieValue);
        }

        var userId = getCookie("userId");//저장된 쿠기값 가져오기
        $("input[name='userId']").val(userId); 
        
        if($("input[name='userId']").val() != ""){ 
            $("#idSave").attr("checked", true); 
        }
        
        $("#idSave").change(function(){ 
            if($("#idSave").is(":checked")){ 
                var userId = $("input[name='userId']").val();
                setCookie("userId", userId, 7); 
            }else{ 
                deleteCookie("userId");
            }
        });
        
        $("input[name='userId']").keyup(function(){ 
            if($("#idSave").is(":checked")){ 
                var userId = $("input[name='userId']").val();
                setCookie("userId", userId, 7); 
            }
        });

        /*로그인 실패*/
        function login(){
            var errorMsg = "<%= errorMsg %>";
        
            console.log(errorMsg);
        
            if(errorMsg != "null"){
                alert(errorMsg);
            }

    	}

	</script>

        <%@ include file="../common/footer.jsp" %>
</body>
</html>