<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer</title>
    <style>
        div{
            box-sizing : border-box;
            /*border : 1px solid red;*/
        }
        .wrap{
            width : 1000px;
            height : 80px;
            margin : auto;
        }
        .warp > div{width : 100%;}
        
        /*footer*/
        #footer{height: 130px; text-align: left;}
        #footer > div{height : 100%; float : left;}
        #footer1{width: 60%; margin-left: 25px; }
        #footer2{ width: 20%; margin-left: 50px;}
        #footer p{font-size: 12px;}
        #footer a{text-decoration: none; color: rgb(63, 74, 224);}
    </style>
</head>
<body>

    <div class="wrap">
    
        <div id="footer">

            <hr>

            <div id="footer1"> 
                <p style="font-size: 15px;">WeFun:D</p>
                <p>주소 : 서울특별시 중구 남대문로 120 대일빌딩 2F</p>
                <p>대표 : 이승철</p>
            </div>
            <div id="footer2"> 
                <p style="font-size: 15px;"><a href="list.not">고객센터</a></p>
                <p>이용약관</p>
                <p>개인정보처리방침</p>
                
            </div>
            <div id="footer3"> 
                <p style="font-size: 15px;">운영시간</p>
                <p>평일 10:00~17:00</p>
                
            </div>

        </div>

        <br>

    </div>
    
</body>
</html>