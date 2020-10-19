<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/resources/css/mainheader2.css">
<title></title>
</head>
<body>
	<div class="header">
	<div class="top-nav">
		<!-- 상단  nav -->
		<c:choose>
			<c:when test="${loginUser eq null}">
				<ul class="nav justify-content-end top-nav">
					<li class="breadcrumb-item"><a id="top-nav-font" href="/signInPage">로그인</a></li>
					<li class="breadcrumb-item"><a id="top-nav-font" href="/signUpPage/1">회원가입</a></li>
				</ul>
			</c:when>
			<c:when test="${loginUser.point < 0 }">
				<ul class="nav justify-content-end top-nav">
					<a href="#"><img class="" cust_id="" id="_myhomeId" src="/resources/img/pi_08.png"></a>
					<dl>
						<dt>
							<strong>관리자</strong>　님
						</dt>
					</dl>
					<li class="breadcrumb-item"><a id="top-nav-font" href="/logOut">로그아웃</a></li>
					<li class="breadcrumb-item"><a id="top-nav-font" href="/admin/main">관리자 페이지</a></li>
				</ul>
			</c:when>
			
			
			
			<c:otherwise>
				<ul class="nav justify-content-end top-nav">
					<a href="#"><img class="" cust_id="" id="_myhomeId" src="/resources/img/pi_08.png"></a>
					<dl>
						<dt>
							<strong>${loginUser.nickname}</strong>　님
						</dt>
					</dl>
					<li class="breadcrumb-item"><a id="top-nav-font" href="/logOut">로그아웃</a></li>
					<li class="breadcrumb-item"><a id="top-nav-font" href="/myPagePwCheck01">마이페이지</a></li>
					<li class="breadcrumb-item"><a id="top-nav-font" href="/myPage04">알림<span id="notice"></span></a></li>
				</ul>
			</c:otherwise>
		</c:choose>
		<script type="text/javascript">
		$(function() {
		var obj = new Object();
		var jsonData = JSON.stringify(obj);
		timer = setInterval( function () {
			$.ajax({
				type : "POST",
				url : '${pageContext.request.contextPath}/notice/json',
			 	/* data : JSON.stringify(jsonData),  */
				datatype : "JSON",
				success : function(data) {
					if(data=='NOTICE')
						$('#notice').text('NEW');
					else $('#notice').text('');
					}	
				}); 
			}, 1000); // SET INTERVAL5
		});
		</script>
		</div>
		<!-- 상단  nav end -->
		<!-- 메인  nav -->
		<div class="main-nav">
		<nav
			class="navbar navbar-expand-lg navbar-light navbar-custom">
			
			<!-- 
			로고들어가는곳 -->
			
			
			<a href="/" class="navbar-logo">
			<img class="" id="logo"
				src="/resources/img/finalogo.png">
				</a> 
<!-- 				<a class="navbar-brand" href="/">Fantasy Stock</a>
 -->				
				
				
				
				
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<i class="fas fa-bars"></i>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav search">
					<form class="form-inline my-2 my-lg-0" method='GET' action="/total-search">
						<input class="form-control mr-sm-2 searchArea" type="search"
							placeholder="통합검색" aria-label="Search" name="keyword">
						<button class="btn btn-outline-secondary my-2 my-sm-0 searchBttn"
							type="submit">
							<i class="fas fa-search"></i>
						</button>
					</form>
				</ul>
				<ul class="navbar-nav ml-auto">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle toggle-btn" href="#"
						id="navbarDropdown" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 커뮤니티 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="/board/free">자유게시판</a> <a
								class="dropdown-item" href="/board/portfolio">포트폴리오</a>
							
							<a class="dropdown-item" href="/news">오늘의 뉴스</a>
						</div></li>
					<li class="nav-item"><a class="nav-link" href="/trade">거래</a></li>
					<li class="nav-item"><a class="nav-link" href="/customer">고객센터<span
							class="sr-only">(current)</span></a></li>
				</ul>
			</div>
		</nav>
	</div>
		<!-- 메인 nav end -->
	</div>
</body>
</html>