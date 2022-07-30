<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WeFun:D</title>
<style>
    /*imageslide*/
    #imageslide{
        position: relative;
        width: 1000px;
        height: 400px;
        text-align: center;
        margin: auto;
        margin-top: 20px;
    }

    .imgSlide{
        width : 1000px; 
        height : 400px;     
    }
    
    /*product*/

    #product{
        width: 1000px;
        height: 1000px;
        margin: auto;
    }
    
    .productList{
            width: 100%;
            height: 30%;
            margin-top: 20px;
            margin-left: 24px;
        }
    .productList > div{float: left;}
    .products{
            width: 23%;
            height: 100%;
            text-align: center;
            margin-right: 10px;
            margin-top: 10px;
            cursor: pointer;
            border: 1px solid black;
            border-radius:10px;
    }
    #countT{
        font-size: 20px;
        margin-left: 40px;
        font-weight: 500;
    }
    #allP{
        text-decoration: none;
        float: right;
        margin-right: 30px;
        font-size: 13px;
        border: 1px solid rgb(247, 217, 58);
        border-radius: 15px;
        border-width: 8px;
        background-color: rgb(247, 217, 58);
        color: black;
        box-shadow: 1px 1px 1px 1px gray;
    }
    #thumeImg{margin-top: 10px; border-radius:10px;}
    #title{
        font-size: 18px; 
        font-weight: 500; 
        overflow:hidden;
        text-overflow:ellipsis;
        white-space:nowrap;
    }
    #seller{
        text-align: left; 
        margin-left: 30px; 
        font-size: 15px;
        margin-bottom: 10px;
        margin-top: 10px;
    }
    #percent{
        float: left;
        margin-left: 30px; 
        margin-top: 5px; 
        color: rgb(247, 217, 58); 
        font-weight: 700;
        margin-bottom: 8px;
    }
    #deadline{
        margin-top: 5px; 
        margin-right: 30px; 
        float:right;
        margin-bottom: 8px;
        font-size: 16px;
    }

    /*프로그래스바*/
    #progress {
        appearance: none;
    }
    #progress::-webkit-progress-bar {
        background:rgb(233, 233, 233);
        border-radius:10px;
        height: 5px;
    }
    #progress::-webkit-progress-value {
        border-radius:10px;
        background-color: rgb(247, 217, 58);
    }
    
    

        
</style>
</head>
<body>
	<%@ include file="../common/header2.jsp" %>
    
	<br><br><br><br><br><br><br><br><br><br>
    
    <%@ include file="../common/footer.jsp" %>
	
</body>
</html>