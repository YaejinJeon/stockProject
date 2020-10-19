<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>유저 정보</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/f
	ont-awesome/5.8.2/css/all.min.css">
<!-- CSS파일 -->
<link href="/resources/css/mypage02.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/sidebar.css">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 달력JS/CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<script type="text/javascript">
	$(document).ready(function() {
		$(".newsboard-nav-item").each(function() {
			$(this).click(function() {
				$(this).addClass("selected"); //클릭된 부분을 상단에 정의된 CCS인 selected클래스로 적용
				$(this).siblings().removeClass("selected"); //siblings:형제요소들,    removeClass:선택된 클래스의 특성을 없앰
			});
		});
	});
</script>
</head>
<body>

	<%@include file="../mainheader.jsp"%>

	<div class="containerNew">
		<div class="contents">
			<div class="row">
				<div class="col-md-2">
					<div class="sidebar sticky" id="cssmenu">
						<ul>
							<li class="mid"><a href="/selectUserBoard?nickname=${user.nickname}"><span>작성 글 | 댓글</span></a></li>
							<li class="selected"><a href="/selectUserMoney?nickname=${user.nickname}"><span>계좌정보</span></a></li>
						</ul>
					</div>					
				</div>
				<div class="col-md-10">

					<div class="newsboard-area">
						<div class="drop-nav">
							<h1 class="tit-h1 line">계좌정보</h1>
						</div>
						<div class="m-drop-nav">
							<h1 class="m-drop-tit-title line" style="cursor: pointer;">계좌정보 <i class="fas fa-angle-down"></i></h1>
						</div>
						<div class="m-drop-down">
							<h1 class="m-drop-tit-body line" style="cursor: pointer;">
								<a href="/board/free">작성 글 | 댓글</a>
							</h1>
							<h1 class="m-drop-tit-body line" style="cursor: pointer;">
								<a href="/board/free">계좌정보</a>
							</h1>
						</div>
						<div class="newsboard-nav">
							<ul class="nav newsboard-nav-tab" id="pills-tab" role="tablist">
								<li class="newsboard-nav-item <c:if test='${type eq "rate"}'>selected</c:if>" role="presentation"><a
									class="nav-link <c:if test='${type eq "rate"}'>active</c:if>" id="top-nav-font" data-toggle="pill"
									href="#pills-home" role="tab" aria-controls="pills-home"
									aria-selected="false">수익률</a></li>
								<li class="newsboard-nav-item <c:if test='${type eq "account"}'>selected</c:if>" role="presentation"><a
									class="nav-link <c:if test='${type eq "account"}'>active</c:if>" id="top-nav-font" data-toggle="pill"
									href="#pills-profile" role="tab" aria-controls="pills-profile"
									aria-selected="false">계좌</a></li>
								<li class="newsboard-nav-item <c:if test='${type eq "trade"}'>selected</c:if>" role="presentation"><a
									class="nav-link <c:if test='${type eq "trade"}'>active</c:if>" id="top-nav-font" data-toggle="pill"
									href="#pills-contact" role="tab" aria-controls="pills-contact"
									aria-selected="true" style="border-right: none;">거래내역</a></li>
							</ul>
						</div>

<!-- 						<div class="board-calendar">

							<div class="week ">
								<p class="date">
									<button onclick="setYesterday();" class="prev-week">어제</button>
									<strong id="test-date" value="setToday();">2020.06.18</strong>
									<span class="input-group-addon">
										<button type="button" class="calendar add-on">달력보기</button>
									</span>
									<button type="button" onclick="setToday();" class="btn-s">오늘</button>
									<button onclick="setTomorrow();" class="next-week"
										id="btn-tomorrow" style="display: none;">내일</button>
								</p>
							</div>
							//week
						</div>
						//board-calendar -->

				<div class="tab-content" id="pills-tabContent">
					<div class="tab-pane fade <c:if test='${type eq "rate"}'>show active</c:if>" id="pills-home"
						role="tabpanel" aria-labelledby="pills-home-tab">
						<div class="noticeBox">
							<p class="notice">
								<em>${user.nickname}</em>님의 수익률
							</p>
						</div>
						<div class="form-table">					
							<table>
								<caption>수익률 : 누적 순위, 누적 수익률, 손익금액, 투자원금</caption>
								<tbody>
									<tr>
										<th scope="row">
											<label for="ranking">누적 순위</label>
										</th>
										<td>
											<span class="input-style-case02">${ranking+1}등</span>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="revenue">누적수익률</label>
										</th>
										<td>
											<span class="input-style-case02"><fmt:formatNumber value="${(accumAsset - 10000000)/100000}" type="number"/>%</span>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="profitloss">손익금액</label>
										</th>
										<td>
											<span class="input-style-case02"><fmt:formatNumber value="${accumAsset - 10000000}" type="number"/>원</span>
										</td>
									</tr>
									<tr>
										<th scope="row">
											<label for="profitloss">투자원금</label>
										</th>
										<td>
											<span class="input-style-case02">10,000,000원</span>
										</td>
									</tr>
									<tr>	
										<th scope="row">
											<label for="total-amount">보유금액</label>
										</th>
										<td>
										<div class="sell-wrap">
											<div class="money-my">
											<span class="input-style-case02"><fmt:formatNumber value="${user.money}" type="number"/>원</span>
											</div>
											
										</div>	
										</td>
									</tr>													
								</tbody>
							</table>
						</div>
					</div>
					<div class="tab-pane fade <c:if test='${type eq "account"}'>show active</c:if>" id="pills-profile" role="tabpanel"
						aria-labelledby="pills-profile-tab">
						<div class="noticeBox">
							<p class="notice">
								<em>${user.nickname}</em>님의 계좌
							</p>
						</div>
						<div class="form-table">
							<div class="table-scroll">
								<table class="table-col">
									<caption>계좌정보</caption>
									<thead>
										<tr>
											<th scope="col" class="a-center">종목코드</th>
											<th scope="col" style="width: 300px;">종목명</th>
											<th scope="col" style="width: 150px;">평균매입가</th>
											<th scope="col" class="a-right">현재가</th>
											<th scope="col" class="a-center">보유주</th>
											<th scope="col" class="a-center">평가금액</th>
											<th scope="col" class="a-center">평가손익</th>
										</tr>
									</thead>
									<tbody>
									
									<c:if test="${holdingStockList.size() == 0}">
									    <tr>
									        <td colspan="7" style="text-align: center;">:::::보유 주식이 없습니다.::::::</td>
									    </tr>
									</c:if>
									    <c:forEach items="${holdingStockList}" var="stock">
											<tr>
												<td scope="col" class="a-center">${stock.stockCode}</td>
												<td scope="col" style="width: 300px;">${stock.stockName}</td>
												<td scope="col" style="width: 150px;"><fmt:formatNumber value="${stock.avgPrice}" type="number"/></td>
												<td scope="col" class="a-right"><fmt:formatNumber value="${stock.currentPrice}" type="number"/></td>
												<td scope="col" class="a-center">${stock.quantity}</td>
												<td scope="col" class="a-center"><fmt:formatNumber value="${stock.quantity*stock.currentPrice}" type="number"/></td>
												<td scope="col" class="a-center"><fmt:formatNumber value="${(stock.currentPrice-stock.avgPrice)*stock.quantity}" type="number"/></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<!-- //table-col -->
							</div>
						</div>						
						<!-- 페이징 -->
						<div class="paging">
						
							<div class="paging-body">
								<nav aria-label="..." class="pagination">
									<ul class="pagination">


										<c:if test="${pv1.nowPage != 1}">
											<!-- << 버튼 -->
											<li>
												<a class="page-link"
													href="/selectUserMoney?nickname=${user.nickname}&nowPage1=1&accountSearch=${accountSearch}&type=account"
													tabindex="-1" aria-disabled="true">
													<i class="fas fa-angle-double-left"></i>
												</a>
											</li>
											<!-- 1페이지에서 < 버튼 눌렀을 때 -->
											<c:if test="${pv1.nowPage == 1}">
												<li>
													<a class="page-link"
														href="/selectUserMoney?nickname=${user.nickname}&nowPage1=${pv1.nowPage}&accountSearch=${accountSearch}&type=account"
														tabindex="-1" aria-disabled="true">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											</c:if>
										</c:if>
										<!-- 1페이지가 아닌 페이지에서 < 버튼 눌렀을 때 -->
										<c:if test="${pv1.nowPage != 1}">
											<li>
												<a class="page-link"
													href="/selectUserMoney?nickname=${user.nickname}&nowPage1=${pv1.nowPage-1}&accountSearch=${accountSearch}&type=account"
													tabindex="-1" aria-disabled="true">
													<i class="fas fa-angle-left"></i>
												</a>
											</li>
										</c:if>
										
										<!-- 한번에 5개 페이지 보여줌 -->
										<c:forEach begin="${pv1.startPage }" end="${pv1.endPage }" var="p">
											<c:choose>
												<c:when test="${p == pv1.nowPage}">
													<li class="page-item active" aria-current="page">
														<a class="page-link" href="#">${p}
															<span class="sr-only">(current)</span>
														</a>
													</li>
												</c:when>
												<c:when test="${p != pv1.nowPage}">
													<li class="page-item">
														<a class="page-link" href="/selectUserMoney?nickname=${user.nickname}&nowPage1=${p}&accountSearch=${accountSearch}&type=account">${p}</a>
													</li>
												</c:when>
											</c:choose>
										</c:forEach> 
										
										
										<c:if test="!${holdingStockList.size() == 0}">
											<c:if test="${pv1.nowPage != pv1.lastPage}">    
											<!-- 현재 페이지가 마지막 페이지일 경우 > 버튼을 눌렀을 때 -->
												<c:if test="${pv1.nowPage == pv1.lastPage}">
													<li>
														<a class="page-link"
															href="/selectUserMoney?nickname=${user.nickname}&nowPage1=${pv1.nowPage}&accountSearch=${accountSearch}&type=account"
															tabindex="+1" aria-disabled="true">
															<i class="fas fa-angle-right"></i>
														</a>
													</li>
												</c:if>
												
												<!-- 현재 페이지가 마지막 페이지가 아닐 경우에 > 버튼을 눌렀을 때 -->					
												<c:if test="${pv1.nowPage != pv1.lastPage}">
													<li>
														<a class="page-link"
															href="/selectUserMoney?nickname=${user.nickname}&nowPage1=${pv1.nowPage+1}&accountSearch=${accountSearch}&type=account"
															tabindex="+1" aria-disabled="true" data-ajax="false">
															<i class="fas fa-angle-right"></i>
														</a>
													</li>
												</c:if> 
												
												<!-- >> 버튼 -->
												<li>
													<a class="page-link"
														href="/selectUserMoney?nickname=${user.nickname}&nowPage1=${pv1.lastPage}&accountSearch=${accountSearch}&type=account"
														tabindex="-1" aria-disabled="true">
														<i class="fas fa-angle-double-right"></i>
													</a>
												</li>
											</c:if>
										</c:if>
									</ul>
								</nav>
							</div>
						</div>

						<div class="search-area">
							<div class="search-area-body">
								<form class="form-inline my-2 my-lg-0 underSearchForm" action="/selectUserMoney">
									<input class="form-control mr-sm-2 board-search" type="search" placeholder="검색어 입력" name="accountSearch" value="${accountSearch}" aria-label="Search">
									<input type="hidden" name="nickname" value="${user.nickname}">
									<input type="hidden" name="type" value="account">
									<button class="btn btn-outline-secondary my-2 my-sm-0 board-search-btn" type="submit">
										<i class="fas fa-search"></i>
									</button>
								</form>
							</div>
						</div>
					</div>
					<div class="tab-pane fade <c:if test='${type eq "trade"}'>show active</c:if>" id="pills-contact" role="tabpanel"
						aria-labelledby="pills-contact-tab">
						<div class="noticeBox">
							<p class="notice">
								<em>${user.nickname}</em>님의 거래내역
							</p>
						</div>						
<!-- 						<div class="board-free-nav">
							<form id="form" class="board-list-top policy-in" action="/board/free">
								<p class="pc-only">
									<input type="radio" class="ordeby" id="orderby1" name="orderby" value="new" checked=""><label for="orderby1" class="new-board">날짜순</label>
									<input type="radio" class="ordeby" id="orderby2" name="orderby" value="best"><label for="orderby2" class="hot-board">종목별</label>
								</p>
							</form>			 
						</div> -->
						
						<div class="form-table">
							<div class="table-scroll">
								<table class="table-col">
									<caption>거래 내역</caption>
									<thead>
										<tr>
											<th scope="col" style="width: 150px;"class="a-center">거래일자</th>
											<th scope="col" style="width: 300px;">종목명</th>
											<th scope="col" class="a-center">수량</th>
											<th scope="col" class="a-right">거래금액</th>
											<th scope="col" class="a-center">단가</th>
											<th scope="col" class="a-center">세금</th>
										</tr>
									</thead>
									<tbody>
									
									<c:if test="${stockHistoryList.size() == 0}">
									    <tr>
									        <td colspan="6" style="text-align: center;">:::::거래 내역이 없습니다.::::::</td>
									    </tr>
									</c:if>
									    <c:forEach items="${stockHistoryList}" var="stock">
											<tr>
												<td scope="col" style="width: 150px;" class="a-right">${stock.tdatetime}</td>
												<td scope="col" style="width: 300px;">${stock.stockName}</td>
												<td scope="col" class="a-center"><fmt:formatNumber value="${stock.quantity}" type="number"/></td>
												<td scope="col" class="a-right"><fmt:formatNumber value="${stock.tprice*stock.quantity}" type="number"/></td>
												<td scope="col" class="a-center">${stock.tprice}</td>
												<td scope="col" class="a-center"><fmt:formatNumber value="${stock.tprice*stock.quantity*0.0025}" type="number"/></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<!-- //table-col -->
							</div>
						</div>						
						<!-- 페이징 -->
						<div class="paging">
						
							<div class="paging-body">
								<nav aria-label="..." class="pagination">
									<ul class="pagination">


										<c:if test="${pv1.nowPage != 1}">
											<!-- << 버튼 -->
											<li>
												<a class="page-link"
													href="/selectUserMoney?nickname=${user.nickname}&nowPage2=1&tradeSearch=${tradeSearch}&type=trade&startDate=${startDate}&endDate=${endDate}"
													tabindex="-1" aria-disabled="true">
													<i class="fas fa-angle-double-left"></i>
												</a>
											</li>
											<!-- 1페이지에서 < 버튼 눌렀을 때 -->
											<c:if test="${pv2.nowPage == 1}">
												<li>
													<a class="page-link"
														href="/selectUserMoney?nickname=${user.nickname}&nowPage2=${pv2.nowPage}&tradeSearch=${tradeSearch}&type=trade&startDate=${startDate}&endDate=${endDate}"
														tabindex="-1" aria-disabled="true">
														<i class="fas fa-angle-left"></i>
													</a>
												</li>
											</c:if>
										</c:if>
										<!-- 1페이지가 아닌 페이지에서 < 버튼 눌렀을 때 -->
										<c:if test="${pv2.nowPage != 1}">
											<li>
												<a class="page-link"
													href="/selectUserMoney?nickname=${user.nickname}&nowPage2=${pv2.nowPage-1}&tradeSearch=${tradeSearch}&type=trade&startDate=${startDate}&endDate=${endDate}"
													tabindex="-1" aria-disabled="true">
													<i class="fas fa-angle-left"></i>
												</a>
											</li>
										</c:if>
										
										<!-- 한번에 5개 페이지 보여줌 -->
										<c:forEach begin="${pv2.startPage }" end="${pv2.endPage }" var="p">
											<c:choose>
												<c:when test="${p == pv2.nowPage}">
													<li class="page-item active" aria-current="page">
														<a class="page-link" href="#">${p}
															<span class="sr-only">(current)</span>
														</a>
													</li>
												</c:when>
												<c:when test="${p != pv2.nowPage}">
													<li class="page-item">
														<a class="page-link" href="/selectUserMoney?nickname=${user.nickname}&nowPage2=${p}&tradeSearch=${tradeSearch}&type=trade&startDate=${startDate}&endDate=${endDate}">${p}</a>
													</li>
												</c:when>
											</c:choose>
										</c:forEach>
										
										<c:if test="!${stockHistoryList.size() == 0}">
											<c:if test="${pv2.nowPage != pv2.lastPage}">    
												<!-- 현재 페이지가 마지막 페이지일 경우 > 버튼을 눌렀을 때 -->
												<c:if test="${pv2.nowPage == pv2.lastPage}">
													<li>
														<a class="page-link"
															href="/selectUserMoney?nickname=${user.nickname}&nowPage2=${pv2.nowPage}&tradeSearch=${tradeSearch}&type=trade&startDate=${startDate}&endDate=${endDate}"
															tabindex="+1" aria-disabled="true">
															<i class="fas fa-angle-right"></i>
														</a>
													</li>
												</c:if>
											
												<!-- 현재 페이지가 마지막 페이지가 아닐 경우에 > 버튼을 눌렀을 때 -->					
												<c:if test="${pv2.nowPage != pv2.lastPage}">
													<li>
														<a class="page-link"
															href="/selectUserMoney?nickname=${user.nickname}&nowPage2=${pv2.nowPage+1}&tradeSearch=${tradeSearch}&type=trade&startDate=${startDate}&endDate=${endDate}"
															tabindex="+1" aria-disabled="true" data-ajax="false">
															<i class="fas fa-angle-right"></i>
														</a>
													</li>
												</c:if> 
												
												<!-- >> 버튼 -->
												<li>
													<a class="page-link"
														href="/selectUserMoney?nickname=${user.nickname}&nowPage2=${pv2.lastPage}&tradeSearch=${tradeSearch}&type=trade&startDate=${startDate}&endDate=${endDate}"
														tabindex="-1" aria-disabled="true">
														<i class="fas fa-angle-double-right"></i>
													</a>
												</li>
											
											</c:if>
										</c:if>
									</ul>
								</nav>
							</div>
						</div>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
						<div class="search-area"> 
							<div class="search-area-body">
								<form class="form-inline my-2 my-lg-0 underSearchForm" action="/selectUserMoney">
									<div class="balance-h2" id="sandbox-container">
					                     <div class="input-daterange input-group" id="datepicker">
					                     <input type="hidden" value="${user.nickname}" name="nickname">
					                     <p>
					                        <span class="input-style-cal start">
					                           <input type="text" name="startDate" class="startDate" id="test-date" placeholder="날짜선택" value="${startDate}" readonly>
					                           <button type="button" id="btnStartDate" class="calendar" onclick="$('.startDate').datepicker('show');">검색</button>
					                        </span>
					                        <i class="input-group-addon">~</i>
					                        <span class="input-style-cal end">
					                           <input type="text" name="endDate" class="endDate" id="test-date" placeholder="날짜선택" value="${endDate}" readonly>
					                           <button type="button" id="btnEndDate" class="calendar" onclick="$('.endDate').datepicker('show');">검색</button>
					                        </span>
					                       <!--  <span class="submit-button"><button type="submit" class="btn-s gray">검색</button></span> -->
					                    </p>
					                    </div>
					                </div>
									<div class="search-box">
										<input class="form-control mr-sm-2 board-search" type="search" name="tradeSearch" value="${tradeSearch}" placeholder="검색어 입력" aria-label="Search">
										<input type="hidden" name="type" value="trade">
										<button class="btn btn-outline-secondary my-2 my-sm-0 board-search-btn" type="submit">
											<i class="fas fa-search"></i>
										</button>
									</div>
			               		</form>
			
					        <script type="text/javascript">
					        $(document).ready(function() {
						        $('.startDate').datepicker({
						            todayBtn : "linked",
						            clearBtn: true,
						            language: "ko",
						            autoclose: true,
						            toggleActive: true
						        });
						        
						        $('.endDate').datepicker({
						            todayBtn : "linked",
						            clearBtn: true,
						            language: "ko",
						            autoclose: true,
						            toggleActive: true
						        });
					        });
					        </script>  
							</div>
						</div>
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>
</div>
	



<%@include file="../mainfooter.jsp"%>
		<script type="text/javascript">
			$(document).ready(
					function() {
						console.log("document ready!");

						var $sticky = $('.sticky');
						var $stickyrStopper = $('.footer_content	');
						if (!!$sticky.offset()) { // make sure ".sticky" element exists

							var generalSidebarHeight = $sticky.innerHeight();
							var stickyTop = $sticky.offset().top;
							var stickOffset = 0;
							var stickyStopperPosition = $stickyrStopper
									.offset().top;
							var stopPoint = stickyStopperPosition
									- generalSidebarHeight - stickOffset;
							var diff = stopPoint + stickOffset;

							$(window).scroll(
									function() { // scroll event
										var windowTop = $(window).scrollTop(); // returns number

										if (stopPoint < windowTop) {
											$sticky.css({
												position : 'relative',
												top : diff
											});
										} else if (stickyTop < windowTop
												+ stickOffset) {
											$sticky.css({
												position : 'fixed',
												top : stickOffset
											});
										} else {
											$sticky.css({
												position : 'relative',
												top : 'initial'
											});
										}
									});

						}
						$(".m-drop-nav").click(function() {
							$(".m-drop-down").slideToggle("slow");
						});
					});
		</script>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
<script src="resources/js/bootstrap-datepicker.ko.min.js"></script>
<script src="/resources/jpaginate/jquery.twbsPagination.js"
	type="text/javascript"></script>
</html>