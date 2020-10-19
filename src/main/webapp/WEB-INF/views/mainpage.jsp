<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>FantasyStock</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link rel="stylesheet" href="/resources/css/mainpage.css">
	
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="http://code.jquery.com/jquery-latest.min.js" ></script>
</head>
<body>
	<%@include file="mainheader.jsp"%>
	<!-- 전체메뉴 백그라운드-->
	<div class="all-dim"></div>

	<div class="containerNew">
		
		<div class="row">
			<div class="col-md-9">
			<!-- 현재 코스피 주가지수 -->
			<div class="graph-area">
					<div class="g-box">
						<div class="graph-title-left graph_off" style="display:block;">
							<div class="graph-title">
								<span><a href="https://finance.com/sise/sise_index.nhn?code=KOSPI" target="_blank">코스피</a></span>

									<c:if test="${kospi eq '+'}">
										<p id="KRI001000000_updownColor_n" class="color-red">
		
											<a href="">
												<span id="KRI001000000_close_n">${current_kospi/100 }</span>
												<mark id="KRI001000000_updownState_n" class="color-red"><i class="hidden"></i><em id="KRI001000000_diffPrice_n">▲${(kospi_lastprice[0]-kospi_lastprice[1])/100}</em> <span id="KRI001000000_diffRate_n">(<fmt:formatNumber value="${(kospi_lastprice[0]-kospi_lastprice[1])/kospi_lastprice[1]*100}" pattern="0.00"/>%)</span></mark>
											</a>
										</p>
									</c:if>
									<c:if test="${kospi eq '-'}">
										<p id="KRI001000000_updownColor_n" class="color-blue">
		
											<a href="">
												<span id="KRI001000000_close_n">${current_kospi/100 }</span>
												<mark id="KRI001000000_updownState_n" class="color-blue"><i class="hidden"></i><em id="KRI001000000_diffPrice_n">▼${fn:substring((kospi_lastprice[0]-kospi_lastprice[1])/100,1,6)}</em> <span id="KRI001000000_diffRate_n">(<fmt:formatNumber value="${fn:substring((kospi_lastprice[0]-kospi_lastprice[1])/kospi_lastprice[1]*100,1,6)}" pattern="0.00"/>%)</span></mark>
											</a>
										</p>
									</c:if>
									<c:if test="${kospi eq '0'}">
										<p id="KRI001000000_updownColor_n" class="color-black" >
											<a href="">
												<span id="KRI001000000_close_n">${current_kospi/100 }</span>
												<mark id="KRI001000000_updownState_n" class="color-black"><i class="hidden"></i><em id="KRI001000000_diffPrice_n">${(kospi_lastprice[0]-kospi_lastprice[1])/100}</em> <span id="KRI001000000_diffRate_n">(<fmt:formatNumber value="${(kospi_lastprice[0]-kospi_lastprice[1])/kospi_lastprice[1]*100}" pattern="0.00"/>%)</span></mark>
											</a>
										</p>
									</c:if>
							</div>
						</div>
						
						<div class="graph-title-right graph_off" style="display:block;">
							<div class="graph-title">
								<span><a href="">코스닥</a></span>
									
									<c:if test="${kosdaq eq '+'}">
										<p id="KRI501000000_updownColor_n" class="color-red">
											<a href="">
												<span id="KRI501000000_close_n">${current_kosdaq/100 } </span>
												<mark id="KRI501000000_updownState_n" class="color-red"><i class="hidden"></i><em id="KRI501000000_diffPrice_n">▲${(kosdaq_lastprice[0]-kosdaq_lastprice[1])/100}</em> <span id="KRI501000000_diffRate_n"> (<fmt:formatNumber value="${(kosdaq_lastprice[0]-kosdaq_lastprice[1])/kosdaq_lastprice[1]*100}" pattern="0.00"/>%)</span></mark>
											</a>
										</p>
									</c:if>
									<c:if test="${kosdaq eq '-'}">
										<p id="KRI501000000_updownColor_n" class="color-blue">
											<a href="">
												<span id="KRI501000000_close_n">${current_kosdaq/100 } </span>
												<mark id="KRI501000000_updownState_n" class="color-blue"><i class="hidden"></i><em id="KRI501000000_diffPrice_n">▼${fn:substring((kosdaq_lastprice[0]-kosdaq_lastprice[1])/100,1,6)}</em> <span id="KRI501000000_diffRate_n"> (<fmt:formatNumber value="${fn:substring((kosdaq_lastprice[0]-kosdaq_lastprice[1])/kosdaq_lastprice[1]*100,1,6)}" pattern="0.00"/>%)</span></mark>
											</a>
										</p>
									</c:if>
									<c:if test="${kosdaq eq '0'}">
										<p id="KRI501000000_updownColor_n" class="color-black">
											<a href="">
												<span id="KRI501000000_close_n">${current_kosdaq/100 } </span>
												<mark id="KRI501000000_updownState_n" class="color-black"><i class="hidden"></i><em id="KRI501000000_diffPrice_n">${(kosdaq_lastprice[0]-kosdaq_lastprice[1])/100}</em> <span id="KRI501000000_diffRate_n"> (<fmt:formatNumber value="${(kosdaq_lastprice[0]-kosdaq_lastprice[1])/kosdaq_lastprice[1]*100}" pattern="0.00"/>%)</span></mark>
											</a>
										</p>
									</c:if>
							</div>
						</div>
						
						<div class="graph-body-left graph_on has-chart">
							
								<a href="https://finance.naver.com/sise/sise_index.nhn?code=KOSPI" target="_blank">
									<div id="chartcontainer"></div>
								</a>
							
						</div>
						<div class="boder"></div>
						<div class="graph-body-right graph_on has-chart" style=" border-left: 1px solid #dee2e6;>
">
							<a href="https://finance.naver.com/sise/sise_index.nhn?code=KOSDAQ" target="_blank">
								<div id="chartcontainer2"></div>
							</a>
						</div>
					</div>
				</div>
				
				<c:choose>
					<c:when test="${loginUser eq null}">
						<div class="login-box login-box-m">
							<div class="div-login-box">
								<form method='post' action="/signIn">
									<fieldset>
										<div class="chk">
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
										</div>
										<p>
											<input type="text" name="id" value="<%=cookieVal !="" ? cookieVal : "" %>" id="user_id" title="아이디 입력" placeholder="아이디">
											<input type="password" name="pw" value="" id="user_pw" title="비밀번호 입력" placeholder="비밀번호"> 
											<input type="submit" value="로그인" onclick="">	
										</p>
									</fieldset>
								</form>
								<p>
									<a href="/signUpPage/1">회원가입</a>
									<span><a href="/forgetId" class="idforgot">아이디 찾기</a>
									<a href="/forgetPassword">비밀번호 찾기</a></span>
								    <span class="social-login"> 
								    <a href="/naverLogin" class="social-type naver">네이버 로그인</a>
									<a href="https://kauth.kakao.com/oauth/authorize?client_id=411ad5d7607a5206006f889840ab2b27&redirect_uri=http://www.fantasystock.shop/kakao&response_type=code" class="social-type kakaotalk">카카오톡 로그인</a>
									</span>
								</p>
							</div>
						</div>
					</c:when>

					<c:when test="${loginUser.point >= 0}">
						<div class="login-box login-box-m">
							<div class="div-login-box-after" style class="login-out">
								<p class="proimg_div-after">
									<a href="/myPage01"><img class="" cust_id="" id="_myhomeId"
										src="/resources/img/pi_08.png"></a> <span id="_gnbBadge"><img
										class="current_badge_s"
										src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="></span>
								</p>
								<dl>
									<dt>
										<strong>${loginUser.nickname}</strong>　님
										<button type="button" class="logout"
											onclick="location.href='/logOut';">로그아웃</button>
									</dt>
									<dd>
										<c:set var="socialId" value="${loginUser.id}"/>
										<c:choose>
											<c:when test="${fn:contains(socialId,'_')}">
												<a class="socialLogin" href="/myPagePwCheck01">내정보</a>
											</c:when>
											<c:otherwise>
												<a id="leftLogin" href="/myPagePwCheck01">내정보</a>
												<a href="mypageUpdatePassword">비밀번호 변경</a>
											</c:otherwise>
										</c:choose>
									</dd>
								</dl>
								<ul class="dot-list02 color-rightgray">
									<li id="_liBall">자산 <a href="/myPagePwCheck01">${money}원</a></li>
									<li id="_liCyber">포인트 <a href="/myPagePwCheck02">${loginUser.point}점</a></li>
								</ul>
							</div>
								<div class="login-after-btn">
									<a id="leftLogin" href="/myPagePwCheck01">마이페이지</a> <a href="/myPage04">알림<span id="noticeMain"></span></a>
								</div>
						</div>
					</c:when>
					
					<c:otherwise>
						<div class="login-box login-box-m">
							<div class="div-login-box-after" style class="login-out">
								<p class="proimg_div-after">
									<a href="/myPage01"><img class="" cust_id="" id="_myhomeId"
										src="/resources/img/pi_08.png"></a> <span id="_gnbBadge"><img
										class="current_badge_s"
										src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="></span>
								</p>
								<dl>
									<dt>
										<strong>관리자</strong>　님
										<button type="button" class="logout"
											onclick="location.href='/logOut';">로그아웃</button>
									</dt>
									<dd>
									</dd>
								</dl>
							</div>
								<div class="admin-login-after-btn">
									<a id="admin-leftLogin" href="/admin/main">관리자 페이지</a>
								</div>
						</div>
					
					</c:otherwise>
				</c:choose>				
				
				
<%-- 					<div class="chartdata-1">
						<div class="chartdata-body">
						<div class="chartdate-nav">
							<h3 class="btnOverInfo" id="h3_stockName">KOSPI<span id="nowStock">${current_kospi/100 } ${(kospi_lastprice[0]-kospi_lastprice[1])/100} ${fn:substring((kospi_lastprice[0]-kospi_lastprice[1])/kospi_lastprice[1]*100,0,5) }%</span></h3>
							
						</div>
						<div id="chartcontainer"></div>
						</div>
					</div>
					<div class="chartdata-2">
						<div class="chartdata-body">
						<div class="chartdate-nav">
							
							<h3 class="btnOverInfo" id="h3_stockName">KOSDAQ<span id="nowStock">${current_kosdaq/100 } ${(kosdaq_lastprice[0]-kosdaq_lastprice[1])/100} ${fn:substring((kosdaq_lastprice[0]-kosdaq_lastprice[1])/kosdaq_lastprice[1]*100,0,5) }%</span></h3>
							
						</div>
						<div id="chartcontainer2"></div>
						</div>
					</div> --%>

				<div class="stock-ranking">
					<nav>
						<div class="nav nav-tabs" role="tablist">
							<a class="nav-item">TOP 종목</a> <a class="nav-item">인기 검색 종목</a>
						</div>
					</nav>
					<div class="tab-content">

						<div class=".tab-pane" id="tab1">
							<table class="tbl_home_left">
								<colgroup>
									<col width="34%">
									<col width="25%">
									<col width="22%">
									<col width="19%">
								</colgroup>
								<tbody class="rank-table" id="topRank">

								</tbody>


							</table>

						</div>

						<div class=".tab-pane" id="tab2">
							<table class="tbl_home_right">
								<colgroup>
									<col width="34%">
									<col width="25%">
									<col width="22%">
									<col width="19%">
								</colgroup>
								<tbody class="rank-table" id="searchRank">

								</tbody>


							</table>

						</div>




					</div>
				</div>

				<div class="community">
						<nav>
							<div class="nav nav-tabs" role="tablist">
								<a class="nav-item">커뮤니티 베스트</a>
								<!-- <button type="button" class="plus" onclick="location.href='/board/free?orderby=best'">더보기</button> -->
								<a href="/board/free?orderby=best" class="link-btn">더보기 <i class="fas fa-angle-right"></i></a>
							</div>
							<div class="nav nav-tabs" role="tablist">
								<a class="nav-item">신규 글</a>
								<!-- <button type="button" class="plus" onclick="location.href='/board/free'">더보기</button> -->
								<a href="/board/free" class="link-btn">더보기 <i class="fas fa-angle-right"></i></a>
							</div>
						</nav>
					<div class="community-best">
						<div class="tab-content">
							<div class=".tab-pane" id="tab1">
								<ul class="step1">
									<c:forEach var="bestBoardList" items="${bestBoardList}">
										<li id="test_1"><a href="/board/free/detail?pno=${bestBoardList.pno}">${bestBoardList.title}</a>
											<p class="nickname">${bestBoardList.nickname}</p></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
								


					<div class="community-new">

						<div class="tab-content">
							<div class=".tab-pane" id="tab1">
								<ul class="step1">
									<c:forEach var="newBoardList" items="${newBoardList}">
										<li id="test_1"><a href="/board/free/detail?pno=${newBoardList.pno}">${newBoardList.title}</a>
											<p class="nickname">${newBoardList.nickname}</p></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
								
				</div>

				<div class="news-ranking">
					<span class="news-tab">
						<a class="selected" id="news-real-time" style="cursor:pointer;">실시간 속보</a>
						<a id="new-market-conditions" style="cursor:pointer;">시황 전망</a>
						<a id="new-event" style="cursor:pointer;">기업 종목분석</a>
					<a href="/news" class="link-btn">더보기 <i class="fas fa-angle-right"></i></a>
					</span>
					<!-- <button type="button" class="news-plus" onclick="location.href='/news'">더보기</button> -->

					<div class="tab-content" id="pills-tabContent">
						<div class="news-body" id="realTimeHtml">
							<div class="headline" id="mainNews1head">
								
							</div>
							<ul id="mainNews1">
							
							</ul>
							
						</div>
						<div class="news-body" id="marketConditionsHtml" style="display:none;">
							<div class="headline" id="mainNews2head">
								
							</div>
							<ul id="mainNews2">
								
							</ul>
						</div>
						<div class="news-body" id="eventHtml" style="display:none;">
							<div class="headline" id="mainNews3head">

							</div>
							<ul id="mainNews3">
							</ul>
						</div>
					</div>
				</div>

			</div>

			<div class="col-md-3">

				<c:choose>
					<c:when test="${loginUser eq null}">
						<div class="login-box login-box-web">
							<div class="div-login-box">
								<form method='post' action="/signIn">
									<fieldset>
										<div class="chk">
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
										</div>
										<p>
											<input type="text" name="id" value="<%=cookieVal !="" ? cookieVal : "" %>" id="user_id" title="아이디 입력" placeholder="아이디">
											<input type="password" name="pw" value="" id="user_pw" title="비밀번호 입력" placeholder="비밀번호"> 
											<input type="submit" value="로그인" onclick="">	
										</p>
									</fieldset>
								</form>
								<p>
									<a href="/signUpPage/1">회원가입</a>
									<span><a href="/forgetId" class="idforgot">아이디 찾기</a>
									<a href="/forgetPassword">비밀번호 찾기</a></span>
								    <span class="social-login"> 
								    <a href="/naverLogin" class="social-type naver">네이버 로그인</a>
									<a href="https://kauth.kakao.com/oauth/authorize?client_id=411ad5d7607a5206006f889840ab2b27&redirect_uri=http://www.fantasystock.shop/kakao&response_type=code" class="social-type kakaotalk">카카오톡 로그인</a>
									</span>
								</p>
							</div>
						</div>
					</c:when>

					<c:when test="${loginUser.point >= 0}">
						<div class="login-box login-box-web">
							<div class="div-login-box-after" style class="login-out">
								<p class="proimg_div-after">
									<a href="/myPage01"><img class="" cust_id="" id="_myhomeId"
										src="/resources/img/pi_08.png"></a> <span id="_gnbBadge"><img
										class="current_badge_s"
										src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="></span>
								</p>
								<dl>
									<dt>
										<strong>${loginUser.nickname}</strong>　님
										<button type="button" class="logout"
											onclick="location.href='/logOut';">로그아웃</button>
									</dt>
									<dd>
										<c:set var="socialId" value="${loginUser.id}"/>
										<c:choose>
											<c:when test="${fn:contains(socialId,'_')}">
												<a class="socialLogin" href="/myPagePwCheck01">내정보</a>
											</c:when>
											<c:otherwise>
												<a id="leftLogin" href="/myPagePwCheck01">내정보</a>
												<a href="mypageUpdatePassword">비밀번호 변경</a>
											</c:otherwise>
										</c:choose>
									</dd>
								</dl>
								<ul class="dot-list02 color-rightgray">
									<li id="_liBall">자산 <a href="/myPagePwCheck01">${money}원</a></li>
									<li id="_liCyber">포인트 <a href="/myPagePwCheck02">${loginUser.point}점</a></li>
								</ul>
							</div>
								<div class="login-after-btn">
									<a id="leftLogin" href="/myPagePwCheck01">마이페이지</a> <a href="/myPage04">알림<span id="noticeMain"></span></a>
								</div>
						</div>
					</c:when>
					
					<c:otherwise>
						<div class="login-box login-box-web">
							<div class="div-login-box-after" style class="login-out">
								<p class="proimg_div-after">
									<a href="/myPage01"><img class="" cust_id="" id="_myhomeId"
										src="/resources/img/pi_08.png"></a> <span id="_gnbBadge"><img
										class="current_badge_s"
										src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="></span>
								</p>
								<dl>
									<dt>
										<strong>관리자</strong>　님
										<button type="button" class="logout"
											onclick="location.href='/logOut';">로그아웃</button>
									</dt>
									<dd>
									</dd>
								</dl>
							</div>
								<div class="admin-login-after-btn">
									<a id="admin-leftLogin" href="/admin/main">관리자 페이지</a>
								</div>
						</div>
					
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
						$('#noticeMain').text('NEW');
					else $('#noticeMain').text('');
					}	
				}); 
			}, 1000); // SET INTERVAL5
		});
		</script>


				<div class="ranking">
					<span class="ranking-tab">
						<a class="selected" id="srchRanking" style="cursor:pointer;">주간 랭킹</a>
						<a id="toronRanking" style="cursor:pointer;">누적 랭킹</a>
					</span>
					<div class="ranking-body" id="searchHtml" style="cursor:pointer;">
						<ul>
						
						<c:forEach items="${currentRevenue}" var="list" varStatus="vs">
	                        <c:if test="${list.nickname ne 'stock관리자'}">
	                           <li class="first"><a href="/selectUserBoard?nickname=${list.nickname}"><i> ${vs.count}</i> <span>${list.nickname}</span>
	                                 <p class="color-red">
	                                    ${list.revenue}%
	                                 </p></a></li>
	                        </c:if>
                   		</c:forEach>
						</ul>
					</div>
					<div class="ranking-body" id="discHtml" style="display:none;">
						<!-- <ul>
						
							<c:forEach items="${currentRevenue}" var="list" varStatus="vs">
								<li class="first"><a><i> <c:out value="${vs.count}"/></i> <span><c:out
												value="${list.nickname}" /></span>
										<p class="color-red">
											<c:out value="${list.revenue}%" />
										</p></a></li>
							</c:forEach>
						</ul>
						 -->
					</div>
				</div>
				
				
				<div class="faq">
				<div class="sectionBox2">



					<a href="/customerQna" id="cBoxa" class="cBox">
						<p class="cBoxTitle">도움말</p>
						<svg class="bi bi-chat-dots" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor"
							xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd"
								d="M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z" />
							<path
								d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
						</svg>
					</a>






					<a href="/customerClaim/write" id="cBoxb" class="cBox">
						<p class="cBoxTitle">1:1 문의</p>
						<svg class="bi bi-people-fill" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor"
							xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd"
								d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216zM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5z" />
						</svg>
					</a>





				</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="mainfooter2.jsp"%>

	<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
	<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	<script>
	$(document).ready(function(){
		showAccumRanking();
		
		$.ajax({
			type : 'GET',
			url : '${pageContext.request.contextPath}/newsAjax',
			dataType : 'json',
			contentType : "application/x-www-form-urlencoded;chartset=UTF-8",
			success : function(data){ 
				console.log(data)
				
				
					var mainNews1head = "";
					mainNews1head += '<a href="https://finance.naver.com'+data.news1.url[0]+'" target="_blank">' 
					/* if(data.news1.img[0] != null){
						
						mainNews1head += 		'<span class="news-img"><img src="'+data.news1.img[0]+'"></span>'
					} */
					mainNews1head += 	'<p>'
					mainNews1head += 		'<strong>'+data.news1.title[0]+'</strong> <span>'+data.news1.content[0]+'</span>'
					mainNews1head += 		'<mark>'+data.news1.writer[0]+'</mark>'
					mainNews1head += 			'<em>'+data.news1.time[0]+'</em>'
					mainNews1head += 		'</p>'
					mainNews1head += 	'</a>'
					
					$("#mainNews1head").html(mainNews1head);
					
					
					
					var mainNews2head = "";
					mainNews2head += '<a href="https://finance.naver.com'+data.news2.url[0]+'" target="_blank">' 
					/* if(data.news2.img[0] != null){
						
						mainNews2head += 		'<span class="news-img"><img src="'+data.news2.img[0]+'"></span>' 
					} */
					mainNews2head += 	'<p>'
					mainNews2head += 		'<strong>'+data.news2.title[0]+'</strong> <span>'+data.news2.content[0]+'</span>'
					mainNews2head += 		'<mark>'+data.news2.writer[0]+'</mark>'
					mainNews2head += 			'<em>'+data.news2.time[0]+'</em>'
					mainNews2head += 		'</p>'
					mainNews2head += 	'</a>'
					
					$("#mainNews2head").html(mainNews2head);
					
					
					var mainNews3head = "";
					mainNews3head += '<a href="https://finance.naver.com'+data.news3.url[0]+'" target="_blank">' 
					/* if(data.news3.img[0] != null){
						
						mainNews3head += 		'<span class="news-img"><img src="'+data.news3.img[0]+'"></span>'
					} */
					mainNews3head += 	'<p>'
					mainNews3head += 		'<strong>'+data.news3.title[0]+'</strong> <span>'+data.news3.content[0]+'</span>'
					mainNews3head += 		'<mark>'+data.news3.writer[0]+'</mark>'
					mainNews3head += 			'<em>'+data.news3.time[0]+'</em>'
					mainNews3head += 		'</p>'
					mainNews3head += 	'</a>'
					
					$("#mainNews3head").html(mainNews3head);
					
					var mainNews1 = "";
					for(var i=1; i<=5; i++){
						
						mainNews1 += '<li id="test_1">'
						mainNews1 += '<a href="https://finance.naver.com'+data.news1.url[i]+'" target="_blank>">'+data.news1.title[i]
						mainNews1 += 	"</a> <mark>"+data.news1.writer[i]+"</mark> <em>"+data.news1.time[i]+"</em></li>"
					}
					$("#mainNews1").html(mainNews1);
					
					var mainNews2 = "";
					for(var i=1; i<=5; i++){
						
						mainNews2 += '<li id="test_1">'
						mainNews2 += '<a href="https://finance.naver.com'+data.news2.url[i]+'" target="_blank>">'+data.news2.title[i]
						mainNews2 += 	"</a> <mark>"+data.news2.writer[i]+"</mark> <em>"+data.news2.time[i]+"</em></li>"
					}
					$("#mainNews2").html(mainNews2);
					
					var mainNews3 = "";
					for(var i=1; i<=5; i++){
						
						mainNews3 += '<li id="test_1">'
						mainNews3 += '<a href="https://finance.naver.com'+data.news3.url[i]+'" target="_blank>">'+data.news3.title[i]
						mainNews3 += 	"</a> <mark>"+data.news3.writer[i]+"</mark> <em>"+data.news3.time[i]+"</em></li>"
					}
					$("#mainNews3").html(mainNews3);
			}
		})
		
		
		
		
		
		
		
		
		function stockRanking(){
			$.ajax({
				type : "GET",
				url : '${pageContext.request.contextPath}/mainPage/stockRankAjax',
				datatype : "JSON",
				success : function(data) {
				
					console.log(data)
					// top 종목(상한가) 5개
					var topRank = "";
					var a = 1;
					
					for(var i=0; i<data.topName.length; i++){
						if(data.topName[i] != null){
							topRank += '<tr class="up">'
							topRank += '<th scope="row"><em>'+a+'</em>'
							topRank += 	'<a href="/trade?stockName='+data.topName[i]+'"'
							topRank += 	'onclick="clickcr(this, &quot;boa.list&quot;, &quot;007570&quot;, &quot;1&quot;, event);">'+data.topName[i]+'</a></th>'
							topRank += '<td>'+data.topCurrentPrice[i]+'</td>'
							topRank += '<td><em class="bu_p bu_pup2"><span class="blind">상한가</span></em>'
							topRank += 	'<span>'+data.topBefore[i]+'</span></td>'
							topRank += 	'<td><span class="tah p11 red02">'+data.topUpDown[i].substring(1)+'</span></td>'
							topRank += '</tr>'
							a++
						}
					}
					$("#topRank").html(topRank);
					
					
					
					//인기검색종목 5개
					var searchRank = "";
					var a = 1;
					
					 for(var i=0; i<data.searchName.length; i++){
					     if(data.searchSangHa[i]=="up"){
					       searchRank += '<tr class="up">'
					     }
					     
					     else if(data.searchSangHa[i]=="down"){
					       searchRank += '<tr class="down">'
					     }
					     else if(data.searchSangHa[i]=='0'){
					       searchRank += '<tr class="same">'
					     }
					     searchRank += '<th scope="row"><em>'+a+'</em>'
					     
					     searchRank += 	'<a href="/trade?stockName='+data.searchName[i]+'">'+data.searchName[i]+'</a></th>'
					     searchRank += '<td>'+data.searchCurrentPrice[i]+'</td>'
					       
					     if(data.searchSangHa[i]=="up"){
					       searchRank += '<td><em class="bu_p bu_pup2"><span class="blind">상한가</span></em>'
					       searchRank += 	'<span>'+data.searchBefore[i]+'</span></td>'
					       searchRank += 	'<td><span class="tah p11 red02">'+data.searchUpDown[i].substring(1)+'</span></td>'
					     }
					             
					     else if(data.searchSangHa[i]=="down"){
					       searchRank +=   '<td><em class="bu_p bu_pdn"><span class="blind">하락</span></em>'
					       searchRank += 	'<span>'+data.searchBefore[i]+'</span></td>'
					       searchRank +=     '<td><span class="tah p11 nv01">'+data.searchUpDown[i].substring(1)+'</span></td>'
					     }
					     else if(data.searchSangHa[i]=='0'){
					       searchRank += '<td><span class="tah p11"> 0 </span></td>'
					       searchRank += 	'<td><span>'+data.searchBefore[i]+'</span></td>'
					     }
							searchRank += '</tr>'
						a++
					}
					$("#searchRank").html(searchRank);
					
					}
				})
		
			}stockRanking();
			
			
			timer = setInterval(function () {
				stockRanking();
			},5000)
			
			
			
			
			
			
//			<!-- 차트 자리 -->
			var kospi_d = [${kospi_d[0]}, ${kospi_d[1]}, ${kospi_d[2]}, ${kospi_d[3]}, ${kospi_d[4]}, ${kospi_d[5]}, ${kospi_d[6]}, ${kospi_d[7]}, ${kospi_d[8]}, ${kospi_d[9]}, ${kospi_d[10]}, ${kospi_d[11]}, ${kospi_d[12]}, ${kospi_d[13]}, ${kospi_d[14]}, ${kospi_d[15]}, ${kospi_d[16]}, ${kospi_d[17]}, ${kospi_d[18]}, ${kospi_d[19]}, ${kospi_d[20]}, ${kospi_d[21]}, ${kospi_d[22]}, ${kospi_d[23]}, ${kospi_d[24]}, ${kospi_d[25]}, ${kospi_d[26]}, ${kospi_d[27]}, ${kospi_d[28]}, ${kospi_d[29]}, ${kospi_d[30]}, ${kospi_d[31]}, ${kospi_d[32]}, ${kospi_d[33]}, ${kospi_d[34]}, ${kospi_d[35]}, ${kospi_d[36]}, ${kospi_d[37]}, ${kospi_d[38]}, ${kospi_d[39]}, ${kospi_d[40]}, ${kospi_d[41]}, ${kospi_d[42]}, ${kospi_d[43]}, ${kospi_d[44]}, ${kospi_d[45]}, ${kospi_d[46]}, ${kospi_d[47]}, ${kospi_d[48]}, ${kospi_d[49]}, ${kospi_d[50]}, ${kospi_d[51]}, ${kospi_d[52]}, ${kospi_d[53]}, ${kospi_d[54]}, ${kospi_d[55]}, ${kospi_d[56]}, ${kospi_d[57]}, ${kospi_d[58]}, ${kospi_d[59]}]; 
			var kospi_startprice = [${kospi_startprice[0]}, ${kospi_startprice[1]}, ${kospi_startprice[2]}, ${kospi_startprice[3]}, ${kospi_startprice[4]}, ${kospi_startprice[5]}, ${kospi_startprice[6]}, ${kospi_startprice[7]}, ${kospi_startprice[8]}, ${kospi_startprice[9]}, ${kospi_startprice[10]}, ${kospi_startprice[11]}, ${kospi_startprice[12]}, ${kospi_startprice[13]}, ${kospi_startprice[14]}, ${kospi_startprice[15]}, ${kospi_startprice[16]}, ${kospi_startprice[17]}, ${kospi_startprice[18]}, ${kospi_startprice[19]}, ${kospi_startprice[20]}, ${kospi_startprice[21]}, ${kospi_startprice[22]}, ${kospi_startprice[23]}, ${kospi_startprice[24]}, ${kospi_startprice[25]}, ${kospi_startprice[26]}, ${kospi_startprice[27]}, ${kospi_startprice[28]}, ${kospi_startprice[29]}, ${kospi_startprice[30]}, ${kospi_startprice[31]}, ${kospi_startprice[32]}, ${kospi_startprice[33]}, ${kospi_startprice[34]}, ${kospi_startprice[35]}, ${kospi_startprice[36]}, ${kospi_startprice[37]}, ${kospi_startprice[38]}, ${kospi_startprice[39]}, ${kospi_startprice[40]}, ${kospi_startprice[41]}, ${kospi_startprice[42]}, ${kospi_startprice[43]}, ${kospi_startprice[44]}, ${kospi_startprice[45]}, ${kospi_startprice[46]}, ${kospi_startprice[47]}, ${kospi_startprice[48]}, ${kospi_startprice[49]}, ${kospi_startprice[50]}, ${kospi_startprice[51]}, ${kospi_startprice[52]}, ${kospi_startprice[53]}, ${kospi_startprice[54]}, ${kospi_startprice[55]}, ${kospi_startprice[56]}, ${kospi_startprice[57]}, ${kospi_startprice[58]}, ${kospi_startprice[59]}];
   			var kospi_highprice = [${kospi_highprice[0]}, ${kospi_highprice[1]}, ${kospi_highprice[2]}, ${kospi_highprice[3]}, ${kospi_highprice[4]}, ${kospi_highprice[5]}, ${kospi_highprice[6]}, ${kospi_highprice[7]}, ${kospi_highprice[8]}, ${kospi_highprice[9]}, ${kospi_highprice[10]}, ${kospi_highprice[11]}, ${kospi_highprice[12]}, ${kospi_highprice[13]}, ${kospi_highprice[14]}, ${kospi_highprice[15]}, ${kospi_highprice[16]}, ${kospi_highprice[17]}, ${kospi_highprice[18]}, ${kospi_highprice[19]}, ${kospi_highprice[20]}, ${kospi_highprice[21]}, ${kospi_highprice[22]}, ${kospi_highprice[23]}, ${kospi_highprice[24]}, ${kospi_highprice[25]}, ${kospi_highprice[26]}, ${kospi_highprice[27]}, ${kospi_highprice[28]}, ${kospi_highprice[29]}, ${kospi_highprice[30]}, ${kospi_highprice[31]}, ${kospi_highprice[32]}, ${kospi_highprice[33]}, ${kospi_highprice[34]}, ${kospi_highprice[35]}, ${kospi_highprice[36]}, ${kospi_highprice[37]}, ${kospi_highprice[38]}, ${kospi_highprice[39]}, ${kospi_highprice[40]}, ${kospi_highprice[41]}, ${kospi_highprice[42]}, ${kospi_highprice[43]}, ${kospi_highprice[44]}, ${kospi_highprice[45]}, ${kospi_highprice[46]}, ${kospi_highprice[47]}, ${kospi_highprice[48]}, ${kospi_highprice[49]}, ${kospi_highprice[50]}, ${kospi_highprice[51]}, ${kospi_highprice[52]}, ${kospi_highprice[53]}, ${kospi_highprice[54]}, ${kospi_highprice[55]}, ${kospi_highprice[56]}, ${kospi_highprice[57]}, ${kospi_highprice[58]}, ${kospi_highprice[59]}];
   			var kospi_lowprice = [${kospi_lowprice[0]}, ${kospi_lowprice[1]}, ${kospi_lowprice[2]}, ${kospi_lowprice[3]}, ${kospi_lowprice[4]}, ${kospi_lowprice[5]}, ${kospi_lowprice[6]}, ${kospi_lowprice[7]}, ${kospi_lowprice[8]}, ${kospi_lowprice[9]}, ${kospi_lowprice[10]}, ${kospi_lowprice[11]}, ${kospi_lowprice[12]}, ${kospi_lowprice[13]}, ${kospi_lowprice[14]}, ${kospi_lowprice[15]}, ${kospi_lowprice[16]}, ${kospi_lowprice[17]}, ${kospi_lowprice[18]}, ${kospi_lowprice[19]}, ${kospi_lowprice[20]}, ${kospi_lowprice[21]}, ${kospi_lowprice[22]}, ${kospi_lowprice[23]}, ${kospi_lowprice[24]}, ${kospi_lowprice[25]}, ${kospi_lowprice[26]}, ${kospi_lowprice[27]}, ${kospi_lowprice[28]}, ${kospi_lowprice[29]}, ${kospi_lowprice[30]}, ${kospi_lowprice[31]}, ${kospi_lowprice[32]}, ${kospi_lowprice[33]}, ${kospi_lowprice[34]}, ${kospi_lowprice[35]}, ${kospi_lowprice[36]}, ${kospi_lowprice[37]}, ${kospi_lowprice[38]}, ${kospi_lowprice[39]}, ${kospi_lowprice[40]}, ${kospi_lowprice[41]}, ${kospi_lowprice[42]}, ${kospi_lowprice[43]}, ${kospi_lowprice[44]}, ${kospi_lowprice[45]}, ${kospi_lowprice[46]}, ${kospi_lowprice[47]}, ${kospi_lowprice[48]}, ${kospi_lowprice[49]}, ${kospi_lowprice[50]}, ${kospi_lowprice[51]}, ${kospi_lowprice[52]}, ${kospi_lowprice[53]}, ${kospi_lowprice[54]}, ${kospi_lowprice[55]}, ${kospi_lowprice[56]}, ${kospi_lowprice[57]}, ${kospi_lowprice[58]}, ${kospi_lowprice[59]}];
   			var kospi_lastprice = [${kospi_lastprice[0]}, ${kospi_lastprice[1]}, ${kospi_lastprice[2]}, ${kospi_lastprice[3]}, ${kospi_lastprice[4]}, ${kospi_lastprice[5]}, ${kospi_lastprice[6]}, ${kospi_lastprice[7]}, ${kospi_lastprice[8]}, ${kospi_lastprice[9]}, ${kospi_lastprice[10]}, ${kospi_lastprice[11]}, ${kospi_lastprice[12]}, ${kospi_lastprice[13]}, ${kospi_lastprice[14]}, ${kospi_lastprice[15]}, ${kospi_lastprice[16]}, ${kospi_lastprice[17]}, ${kospi_lastprice[18]}, ${kospi_lastprice[19]}, ${kospi_lastprice[20]}, ${kospi_lastprice[21]}, ${kospi_lastprice[22]}, ${kospi_lastprice[23]}, ${kospi_lastprice[24]}, ${kospi_lastprice[25]}, ${kospi_lastprice[26]}, ${kospi_lastprice[27]}, ${kospi_lastprice[28]}, ${kospi_lastprice[29]}, ${kospi_lastprice[30]}, ${kospi_lastprice[31]}, ${kospi_lastprice[32]}, ${kospi_lastprice[33]}, ${kospi_lastprice[34]}, ${kospi_lastprice[35]}, ${kospi_lastprice[36]}, ${kospi_lastprice[37]}, ${kospi_lastprice[38]}, ${kospi_lastprice[39]}, ${kospi_lastprice[40]}, ${kospi_lastprice[41]}, ${kospi_lastprice[42]}, ${kospi_lastprice[43]}, ${kospi_lastprice[44]}, ${kospi_lastprice[45]}, ${kospi_lastprice[46]}, ${kospi_lastprice[47]}, ${kospi_lastprice[48]}, ${kospi_lastprice[49]}, ${kospi_lastprice[50]}, ${kospi_lastprice[51]}, ${kospi_lastprice[52]}, ${kospi_lastprice[53]}, ${kospi_lastprice[54]}, ${kospi_lastprice[55]}, ${kospi_lastprice[56]}, ${kospi_lastprice[57]}, ${kospi_lastprice[58]}, ${kospi_lastprice[59]}];
   			var mainData = [];
   			for (var i = 0; i < 60; i++) {
   				mainData.push({
   			         x: new Date(
   			        		 parseInt(kospi_d[i]/10000),
   			                  parseInt(kospi_d[i]%10000/100)-1,
   			               kospi_d[i]%100+1
   			                  ),
   			         y:  [ parseFloat(kospi_startprice[i]), parseFloat(kospi_highprice[i]),
   		                parseFloat(kospi_lowprice[i]),
   		                parseFloat(kospi_lastprice[i])/100 ]
   			     });
   			 }
   		    
   		    var options = {
   		   		
   		        series: [{
   		        	data: mainData
   		        }],
   		        chart: {
   		            type: 'candlestick',
   		            redrawOnParentResize: true,
   		        	 height: '300px',
   		            zoom: {
   		                enabled: false}
   		        },
   		        xaxis: {
   		            type: 'datetime',
   		            labels: {
   		                datetimeFormatter: {
   		                    year: 'yyyy',
   		                    month: 'MM/dd',
   		                    day: 'dd',
   		                    hour: 'HH:mm'
   		                }
   		            },
   		            tooltip: {
   		                formatter: function(val, opts) {
   		                  var st = new Date(val);
   		                  var mon = st.getMonth()+1;
   		                  var day = st.getDate()-1;
   		                  if(day == 0 ){
   		               	   day = 31;
   		               	   mon = mon-1;
   		                  }
   		                  var text = mon + "/" +day;
   		                  return text
   		                }
   		              }
   		        },
   		        yaxis: {labels: {
   				    formatter: function (value) {
   		  		      	value = parseInt(value);
   				    	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
   		  		    }
   		  		  },
   		            tooltip: {
   		                enabled: true
   		            }
   		        },
   		        
   		        plotOptions: {
   		       	 candlestick: {
   		       	        colors: {
   		       	          upward: '#FF0000',
   		       	          downward: '#5B5AFF'
   		       	        },
   		       	        wick: {
   		       	          useFillColor: true
   		       	        }
   		       	      }, 
   		       	 bar: {
   				          horizontal: false,
   				          startingShape: 'flat',
   				          endingShape: 'flat',
   				          columnWidth: '12%',
   				          barHeight: '80%',
   				          distributed: false,
   				          rangeBarOverlap: true,
   				          colors: {
   				              ranges: [{
   				                  from: 0,
   				                  to: 0,
   				                  color: undefined
   				              }],
   				              backgroundBarColors: [],
   				              backgroundBarOpacity: 1,
   				              backgroundBarRadius: 0,
   				          }
   				      }
   				  },
   				  tooltip: {
   					  custom: function({series, seriesIndex, dataPointIndex, w}) {
   		               
   					    return '<DIV style="height: auto; width: auto; padding:15px; /* background-color: rgba(249, 249, 249, 0.85); */ font-size: 16px;"><p>● 시가: '+mainData[dataPointIndex].y[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '</p><p>● 종가: ' + mainData[dataPointIndex].y[3].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+ '</p><p style="color: #5B5AFF;">▼ 저가: ' + mainData[dataPointIndex].y[2].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+ '</p><p style="color: #FF0000;">▲ 고가: ' + mainData[dataPointIndex].y[1].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+ '</p></DIV>'
   					  }
   					}
   				 
   		    };

   		    var chart = new ApexCharts(document.querySelector("#chartcontainer"), options);
   		    chart.render();
   		    
   		    
   		 var kosdaq_d = [${kosdaq_d[0]}, ${kosdaq_d[1]}, ${kosdaq_d[2]}, ${kosdaq_d[3]}, ${kosdaq_d[4]}, ${kosdaq_d[5]}, ${kosdaq_d[6]}, ${kosdaq_d[7]}, ${kosdaq_d[8]}, ${kosdaq_d[9]}, ${kosdaq_d[10]}, ${kosdaq_d[11]}, ${kosdaq_d[12]}, ${kosdaq_d[13]}, ${kosdaq_d[14]}, ${kosdaq_d[15]}, ${kosdaq_d[16]}, ${kosdaq_d[17]}, ${kosdaq_d[18]}, ${kosdaq_d[19]}, ${kosdaq_d[20]}, ${kosdaq_d[21]}, ${kosdaq_d[22]}, ${kosdaq_d[23]}, ${kosdaq_d[24]}, ${kosdaq_d[25]}, ${kosdaq_d[26]}, ${kosdaq_d[27]}, ${kosdaq_d[28]}, ${kosdaq_d[29]}, ${kosdaq_d[30]}, ${kosdaq_d[31]}, ${kosdaq_d[32]}, ${kosdaq_d[33]}, ${kosdaq_d[34]}, ${kosdaq_d[35]}, ${kosdaq_d[36]}, ${kosdaq_d[37]}, ${kosdaq_d[38]}, ${kosdaq_d[39]}, ${kosdaq_d[40]}, ${kosdaq_d[41]}, ${kosdaq_d[42]}, ${kosdaq_d[43]}, ${kosdaq_d[44]}, ${kosdaq_d[45]}, ${kosdaq_d[46]}, ${kosdaq_d[47]}, ${kosdaq_d[48]}, ${kosdaq_d[49]}, ${kosdaq_d[50]}, ${kosdaq_d[51]}, ${kosdaq_d[52]}, ${kosdaq_d[53]}, ${kosdaq_d[54]}, ${kosdaq_d[55]}, ${kosdaq_d[56]}, ${kosdaq_d[57]}, ${kosdaq_d[58]}, ${kosdaq_d[59]}]; 
			var kosdaq_startprice = [${kosdaq_startprice[0]}, ${kosdaq_startprice[1]}, ${kosdaq_startprice[2]}, ${kosdaq_startprice[3]}, ${kosdaq_startprice[4]}, ${kosdaq_startprice[5]}, ${kosdaq_startprice[6]}, ${kosdaq_startprice[7]}, ${kosdaq_startprice[8]}, ${kosdaq_startprice[9]}, ${kosdaq_startprice[10]}, ${kosdaq_startprice[11]}, ${kosdaq_startprice[12]}, ${kosdaq_startprice[13]}, ${kosdaq_startprice[14]}, ${kosdaq_startprice[15]}, ${kosdaq_startprice[16]}, ${kosdaq_startprice[17]}, ${kosdaq_startprice[18]}, ${kosdaq_startprice[19]}, ${kosdaq_startprice[20]}, ${kosdaq_startprice[21]}, ${kosdaq_startprice[22]}, ${kosdaq_startprice[23]}, ${kosdaq_startprice[24]}, ${kosdaq_startprice[25]}, ${kosdaq_startprice[26]}, ${kosdaq_startprice[27]}, ${kosdaq_startprice[28]}, ${kosdaq_startprice[29]}, ${kosdaq_startprice[30]}, ${kosdaq_startprice[31]}, ${kosdaq_startprice[32]}, ${kosdaq_startprice[33]}, ${kosdaq_startprice[34]}, ${kosdaq_startprice[35]}, ${kosdaq_startprice[36]}, ${kosdaq_startprice[37]}, ${kosdaq_startprice[38]}, ${kosdaq_startprice[39]}, ${kosdaq_startprice[40]}, ${kosdaq_startprice[41]}, ${kosdaq_startprice[42]}, ${kosdaq_startprice[43]}, ${kosdaq_startprice[44]}, ${kosdaq_startprice[45]}, ${kosdaq_startprice[46]}, ${kosdaq_startprice[47]}, ${kosdaq_startprice[48]}, ${kosdaq_startprice[49]}, ${kosdaq_startprice[50]}, ${kosdaq_startprice[51]}, ${kosdaq_startprice[52]}, ${kosdaq_startprice[53]}, ${kosdaq_startprice[54]}, ${kosdaq_startprice[55]}, ${kosdaq_startprice[56]}, ${kosdaq_startprice[57]}, ${kosdaq_startprice[58]}, ${kosdaq_startprice[59]}];
			var kosdaq_highprice = [${kosdaq_highprice[0]}, ${kosdaq_highprice[1]}, ${kosdaq_highprice[2]}, ${kosdaq_highprice[3]}, ${kosdaq_highprice[4]}, ${kosdaq_highprice[5]}, ${kosdaq_highprice[6]}, ${kosdaq_highprice[7]}, ${kosdaq_highprice[8]}, ${kosdaq_highprice[9]}, ${kosdaq_highprice[10]}, ${kosdaq_highprice[11]}, ${kosdaq_highprice[12]}, ${kosdaq_highprice[13]}, ${kosdaq_highprice[14]}, ${kosdaq_highprice[15]}, ${kosdaq_highprice[16]}, ${kosdaq_highprice[17]}, ${kosdaq_highprice[18]}, ${kosdaq_highprice[19]}, ${kosdaq_highprice[20]}, ${kosdaq_highprice[21]}, ${kosdaq_highprice[22]}, ${kosdaq_highprice[23]}, ${kosdaq_highprice[24]}, ${kosdaq_highprice[25]}, ${kosdaq_highprice[26]}, ${kosdaq_highprice[27]}, ${kosdaq_highprice[28]}, ${kosdaq_highprice[29]}, ${kosdaq_highprice[30]}, ${kosdaq_highprice[31]}, ${kosdaq_highprice[32]}, ${kosdaq_highprice[33]}, ${kosdaq_highprice[34]}, ${kosdaq_highprice[35]}, ${kosdaq_highprice[36]}, ${kosdaq_highprice[37]}, ${kosdaq_highprice[38]}, ${kosdaq_highprice[39]}, ${kosdaq_highprice[40]}, ${kosdaq_highprice[41]}, ${kosdaq_highprice[42]}, ${kosdaq_highprice[43]}, ${kosdaq_highprice[44]}, ${kosdaq_highprice[45]}, ${kosdaq_highprice[46]}, ${kosdaq_highprice[47]}, ${kosdaq_highprice[48]}, ${kosdaq_highprice[49]}, ${kosdaq_highprice[50]}, ${kosdaq_highprice[51]}, ${kosdaq_highprice[52]}, ${kosdaq_highprice[53]}, ${kosdaq_highprice[54]}, ${kosdaq_highprice[55]}, ${kosdaq_highprice[56]}, ${kosdaq_highprice[57]}, ${kosdaq_highprice[58]}, ${kosdaq_highprice[59]}];
			var kosdaq_lowprice = [${kosdaq_lowprice[0]}, ${kosdaq_lowprice[1]}, ${kosdaq_lowprice[2]}, ${kosdaq_lowprice[3]}, ${kosdaq_lowprice[4]}, ${kosdaq_lowprice[5]}, ${kosdaq_lowprice[6]}, ${kosdaq_lowprice[7]}, ${kosdaq_lowprice[8]}, ${kosdaq_lowprice[9]}, ${kosdaq_lowprice[10]}, ${kosdaq_lowprice[11]}, ${kosdaq_lowprice[12]}, ${kosdaq_lowprice[13]}, ${kosdaq_lowprice[14]}, ${kosdaq_lowprice[15]}, ${kosdaq_lowprice[16]}, ${kosdaq_lowprice[17]}, ${kosdaq_lowprice[18]}, ${kosdaq_lowprice[19]}, ${kosdaq_lowprice[20]}, ${kosdaq_lowprice[21]}, ${kosdaq_lowprice[22]}, ${kosdaq_lowprice[23]}, ${kosdaq_lowprice[24]}, ${kosdaq_lowprice[25]}, ${kosdaq_lowprice[26]}, ${kosdaq_lowprice[27]}, ${kosdaq_lowprice[28]}, ${kosdaq_lowprice[29]}, ${kosdaq_lowprice[30]}, ${kosdaq_lowprice[31]}, ${kosdaq_lowprice[32]}, ${kosdaq_lowprice[33]}, ${kosdaq_lowprice[34]}, ${kosdaq_lowprice[35]}, ${kosdaq_lowprice[36]}, ${kosdaq_lowprice[37]}, ${kosdaq_lowprice[38]}, ${kosdaq_lowprice[39]}, ${kosdaq_lowprice[40]}, ${kosdaq_lowprice[41]}, ${kosdaq_lowprice[42]}, ${kosdaq_lowprice[43]}, ${kosdaq_lowprice[44]}, ${kosdaq_lowprice[45]}, ${kosdaq_lowprice[46]}, ${kosdaq_lowprice[47]}, ${kosdaq_lowprice[48]}, ${kosdaq_lowprice[49]}, ${kosdaq_lowprice[50]}, ${kosdaq_lowprice[51]}, ${kosdaq_lowprice[52]}, ${kosdaq_lowprice[53]}, ${kosdaq_lowprice[54]}, ${kosdaq_lowprice[55]}, ${kosdaq_lowprice[56]}, ${kosdaq_lowprice[57]}, ${kosdaq_lowprice[58]}, ${kosdaq_lowprice[59]}];
			var kosdaq_lastprice = [${kosdaq_lastprice[0]}, ${kosdaq_lastprice[1]}, ${kosdaq_lastprice[2]}, ${kosdaq_lastprice[3]}, ${kosdaq_lastprice[4]}, ${kosdaq_lastprice[5]}, ${kosdaq_lastprice[6]}, ${kosdaq_lastprice[7]}, ${kosdaq_lastprice[8]}, ${kosdaq_lastprice[9]}, ${kosdaq_lastprice[10]}, ${kosdaq_lastprice[11]}, ${kosdaq_lastprice[12]}, ${kosdaq_lastprice[13]}, ${kosdaq_lastprice[14]}, ${kosdaq_lastprice[15]}, ${kosdaq_lastprice[16]}, ${kosdaq_lastprice[17]}, ${kosdaq_lastprice[18]}, ${kosdaq_lastprice[19]}, ${kosdaq_lastprice[20]}, ${kosdaq_lastprice[21]}, ${kosdaq_lastprice[22]}, ${kosdaq_lastprice[23]}, ${kosdaq_lastprice[24]}, ${kosdaq_lastprice[25]}, ${kosdaq_lastprice[26]}, ${kosdaq_lastprice[27]}, ${kosdaq_lastprice[28]}, ${kosdaq_lastprice[29]}, ${kosdaq_lastprice[30]}, ${kosdaq_lastprice[31]}, ${kosdaq_lastprice[32]}, ${kosdaq_lastprice[33]}, ${kosdaq_lastprice[34]}, ${kosdaq_lastprice[35]}, ${kosdaq_lastprice[36]}, ${kosdaq_lastprice[37]}, ${kosdaq_lastprice[38]}, ${kosdaq_lastprice[39]}, ${kosdaq_lastprice[40]}, ${kosdaq_lastprice[41]}, ${kosdaq_lastprice[42]}, ${kosdaq_lastprice[43]}, ${kosdaq_lastprice[44]}, ${kosdaq_lastprice[45]}, ${kosdaq_lastprice[46]}, ${kosdaq_lastprice[47]}, ${kosdaq_lastprice[48]}, ${kosdaq_lastprice[49]}, ${kosdaq_lastprice[50]}, ${kosdaq_lastprice[51]}, ${kosdaq_lastprice[52]}, ${kosdaq_lastprice[53]}, ${kosdaq_lastprice[54]}, ${kosdaq_lastprice[55]}, ${kosdaq_lastprice[56]}, ${kosdaq_lastprice[57]}, ${kosdaq_lastprice[58]}, ${kosdaq_lastprice[59]}];
			var mainData = [];
			for (var i = 0; i < 60; i++) {
				mainData.push({
			         x: new Date(
			        		 parseInt(kosdaq_d[i]/10000),
			                  parseInt(kosdaq_d[i]%10000/100)-1,
			               kosdaq_d[i]%100+1
			                  ),
			         y:  [ parseFloat(kosdaq_startprice[i]), parseFloat(kosdaq_highprice[i]),
		                parseFloat(kosdaq_lowprice[i]),
		                parseFloat(kosdaq_lastprice[i])/100 ]
			     });
			 }
		    
		    var options = {
		   		
		        series: [{
		        	data: mainData
		        }],
		        chart: {
		            type: 'candlestick',
		            redrawOnParentResize: true,
		        	 height: '300px',
		            zoom: {
		                enabled: false}
		        },
		        xaxis: {
		            type: 'datetime',
		            labels: {
		                datetimeFormatter: {
		                    year: 'yyyy',
		                    month: 'MM/dd',
		                    day: 'dd',
		                    hour: 'HH:mm'
		                }
		            },
		            tooltip: {
		                formatter: function(val, opts) {
		                  var st = new Date(val);
		                  var mon = st.getMonth()+1;
		                  var day = st.getDate()-1;
		                  if(day == 0 ){
		               	   day = 31;
		               	   mon = mon-1;
		                  }
		                  var text = mon + "/" +day;
		                  return text
		                }
		              }
		        },
		        yaxis: {labels: {
				    formatter: function (value) {
		  		      	value = parseInt(value);
				    	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		  		    }
		  		  },
		            tooltip: {
		                enabled: true
		            }
		        },
		        
		        plotOptions: {
		       	 candlestick: {
		       	        colors: {
		       	          upward: '#FF0000',
		       	          downward: '#5B5AFF'
		       	        },
		       	        wick: {
		       	          useFillColor: true
		       	        }
		       	      }, 
		       	 bar: {
				          horizontal: false,
				          startingShape: 'flat',
				          endingShape: 'flat',
				          columnWidth: '12%',
				          barHeight: '80%',
				          distributed: false,
				          rangeBarOverlap: true,
				          colors: {
				              ranges: [{
				                  from: 0,
				                  to: 0,
				                  color: undefined
				              }],
				              backgroundBarColors: [],
				              backgroundBarOpacity: 1,
				              backgroundBarRadius: 0,
				          }
				      }
				  },
				  tooltip: {
					  custom: function({series, seriesIndex, dataPointIndex, w}) {
		               
					    return '<DIV style="height: auto; width: auto; padding:15px; /* background-color: rgba(249, 249, 249, 0.85); */ font-size: 16px;"><p>● 시가: '+mainData[dataPointIndex].y[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '</p><p>● 종가: ' + mainData[dataPointIndex].y[3].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+ '</p><p style="color: #5B5AFF;">▼ 저가: ' + mainData[dataPointIndex].y[2].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+ '</p><p style="color: #FF0000;">▲ 고가: ' + mainData[dataPointIndex].y[1].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+ '</p></DIV>'
					  }
					}
				 
		    };

		    var chart_kosdaq = new ApexCharts(document.querySelector("#chartcontainer2"), options);
		    chart_kosdaq.render();
		    
   		
		})
		
		function notLocal(){
			swal({text:"접속하신 해당 홈페이지에서 변경가능합니다.", icon:"warning"})
		}
		

</script>

<script>


	$(document).ready(function(){
		initDefaultRanking();
		initDefaultNews();
	});

	function initDefaultRanking(){
		$("#srchRanking").click(function(){
			$(this).addClass("selected");
			$("#toronRanking").removeClass("selected");
			$("#searchHtml").show();
			$("#discHtml").hide();
		});

		$("#toronRanking").click(function(){
			$(this).addClass("selected");
			$("#srchRanking").removeClass("selected");
			$("#searchHtml").hide();
			$("#discHtml").show();
		});
	}
 	function initDefaultNews(){
		$("#news-real-time").click(function(){
			$(this).addClass("selected");
			$("#new-market-conditions").removeClass("selected");
			$("#new-event").removeClass("selected");
			$("#realTimeHtml").show();
			$("#marketConditionsHtml").hide();
			$("#eventHtml").hide();
		});
		$("#new-market-conditions").click(function(){
			$(this).addClass("selected");
			$("#news-real-time").removeClass("selected");
			$("#new-event").removeClass("selected");
			$("#marketConditionsHtml").show();
			$("#realTimeHtml").hide();
			$("#eventHtml").hide();
		});
		$("#new-event").click(function(){
			$(this).addClass("selected");
			$("#news-real-time").removeClass("selected");
			$("#new-market-conditions").removeClass("selected");
			
			$("#eventHtml").show();
			$("#realTimeHtml").hide();
			$("#marketConditionsHtml").hide();
		});
	}
 	
 	function showAccumRanking() {
 		$.ajax({
 			type : 'POST',
 			url : '${pageContext.request.contextPath}/accumRanking',
 			dataType : 'json',
 			contentType : "application/x-www-form-urlencoded;chartset=UTF-8",
 			success : function(data){
 				var HTMLForAccumRanking = "<ul>";
 				for(var i = 0; i < data.accumRankingNicknameList.length; ++i) {
 					if(data.accumRankingNicknameList[i] !== 'stock관리자'){
	 					HTMLForAccumRanking +=
	
	 					'<li class="first"><a href="/selectUserBoard?nickname='+data.accumRankingNicknameList[i]+'"><i> '+(i+1)+'</i> <span>'+data.accumRankingNicknameList[i]+'</span>'+
	 					'<p class="color-red">'+
	 					((data.accumRankingAssetList[i]-10000000)/100000)+'%'+
	 					'</p></a></li>';
 					}
 				}
 				HTMLForAccumRanking += "</ul>";
 				$("#discHtml").html(HTMLForAccumRanking);
 			}
 		});
 	}
</script>

<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
	if(!wcs_add) var wcs_add = {};
	wcs_add["wa"] = "7a21168adc713c";
	if(window.wcs) {
	wcs_do();
	}
</script>

</body>
</html>
