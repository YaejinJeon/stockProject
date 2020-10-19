<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<!-- <link href="/resources/css/signup03.css" rel="stylesheet"> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="/resources/css/signup01_02.css" rel="stylesheet">
</head>

<body>

<%@include file="../mainheader.jsp" %>



<!--     <article>
        <div class="allbody2">
            <div class="allbody">
                <i class="fas fa-user-alt"></i>　회원가입을 축하드립니다
            </div>
            <div><button type="button" onclick="location.href='/signInPage'" class="loginbutton" data-text-content="true">로그인</button></div>
        </div>
    </article> -->


<div class="containerNew"> 

		<!-- contents -->
		<div class="contents member" id="contents">
		
			<!-- cont-area -->	
			<div class="cont-area"> 
				<div class="step-mem">
					<ul>
						<li><div><span><i>Step1</i></span><em>약관동의</em></div></li> 
						<li><div><span><i>Step2</i></span><em>기본정보입력</em></div></li>
						<li class="selected"><div><span><i>Step3</i></span><em>가입완료</em></div></li>
					</ul>
				</div>

				<div class="mem-withdrawal">
					<div class="mem-message-02">
						<p class="big-text">
							<span class="color-fantasy">FantasyStock</span>에 오신 것을 환영합니다!
						</p>
						<!-- <p><mark></mark> FantasyStock 회원가입을 축하합니다.</p> -->
						 
					</div>
					<!-- //message-st-01 --> 
					<div class="mem case02">
						<p class="id"><i>아이디</i> <span class="color-fantasy">${login.id}</span></p>
						<p class="name"><i>닉네임</i> <span>${login.nickname}</span></p>
					</div>
					<div class="bt-area">  
						<a href="/signInPage" class="btn-b">로그인</a>
						<a href="/" class="btn-b fantasy">취소</a> 
					</div>
				</div>
				<!-- //info-modify -->

			</div><!-- //cont-area -->
		</div><!-- //contents -->  
	</div>

	
<%@include file="../mainfooter2.jsp" %>

</body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

</html>