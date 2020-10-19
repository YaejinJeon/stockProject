<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>로그인</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>    
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link rel="stylesheet" href="/resources/css/login.css">
</head>
<body>
<div class="wrap">
<%@include file="../mainheader.jsp" %>
<div class="containerNew"> 
<!-- contents -->
<div class="contents member" id="contents">
	<!-- cont-area -->	
	<div class="cont-area log"> 
		<div class="login-wrap"> 
			<div class="logo-log">
				<a href="/"><img src="/resources/img/footerlogo2.png" alt="PAXNet"></a>
			</div>
			 <form action="/signIn" class="form-signin" method="post">
				 <div class="on-area clearfix">
					<span class="stu">
						<%
						    Cookie[] c = request.getCookies();
						    String cookieVal="";
						    if(c!=null){
						        for(Cookie i:c){
						            if(i.getName().equals("saveId")){
						                cookieVal=i.getValue();
						            }
						        }
						    }
						%>
						<input type="checkbox" id="idSaveCheck" class="big" name="saveId" <%=cookieVal!=""?"checked" : ""%>/>
						<label for="idSaveCheck">아이디 저장</label>
					 </span>
				 </div> 
				<fieldset class="login">
					<legend>로그인</legend> 
					<div>
						<span class="input-style">
							<input id="inputEmail" name="id" title="아이디 입력" placeholder="아이디 입력" type="email" value="<%=cookieVal !="" ? cookieVal : "" %>" required autofocus>
						</span> 
						<span class="input-style">
							<input id="inputPassword" name="pw" title="비밀번호 입력" placeholder="비밀번호 입력" type="password" value="" autocomplete="OFF" required>
	
						</span>
					</div>
					<button class="btn-b fantasy" type="submit" value="Submit">로그인</button>
				</fieldset>
			</form>
			<div class="bt-login">
				<a href="/forgetId">아이디 찾기</a>
				<a href="/forgetPassword">비밀번호 찾기</a>
				<a href="/signUpPage/1">회원가입</a>
			</div>
			
			<!-- 소셜 로그인 타입 추가 -->
			<div class="social-login">
				<button type="button" class="naverlogin btn-b naver" onclick="location.href='/naverLogin'">네이버 아이디로 로그인</button>
				<button type="button" class="kakaologin btn-b kakaotalk" onclick="location.href='https://kauth.kakao.com/oauth/authorize?client_id=411ad5d7607a5206006f889840ab2b27&redirect_uri=http://www.fantasystock.shop/kakao&response_type=code'">카카오톡 아이디로 로그인</button>
			</div>
		</div>
	</div><!-- //cont-area -->	 
</div><!-- //contents -->  

<!-- 소셜로그인 요청을 위해 필요한 form 입니다. -->
<form name="snsReqForm" id="snsReqForm" method="POST" target="popupChk">
	<input type="hidden" name="reqType" id="reqType" value="">
	<input type="hidden" name="snsReturnURL" id="snsReturnURL" value="">
	<input type="hidden" name="snsAutoLogin" id="snsAutoLogin" value="N">	<!-- 자동 로그인 여부 -->
</form>

<!-- 소셜로그인 완료 후 회원가입 화면으로 이동할 때 필요한 form 입니다. -->
<form name="snsResForm" id="snsResForm" method="POST">
	<input type="hidden" name="sns_type" id="sns_type" value="">
	<input type="hidden" name="sns_id" id="sns_id" value="">
	<input type="hidden" name="cust_nm" id="cust_nm" value="">
	<input type="hidden" name="email" id="email" value="">
	<input type="hidden" name="profile_image" id="profile_image" value="">
	<input type="hidden" name="nick_nm" id="nick_nm" value="">
	<input type="hidden" name="sns_returnURL" id="sns_returnURL" value=""> <!-- 회원가입 완료 후 이동할 URL -->
</form>
	</div>	
<%@include file="../mainfooter2.jsp" %>
</div>
<script>window.jQuery || document.write('<script src="/docs/4.4/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
<script src="/docs/4.4/dist/js/bootstrap.bundle.min.js" ></script>
<script src="form-validation.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</body>
</html>