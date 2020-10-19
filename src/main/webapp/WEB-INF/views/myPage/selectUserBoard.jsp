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
<link href="resources/css/mypage03.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/sidebar.css">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 달력JS/CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<script type="text/javascript">


$(document).ready(function(){
	if($("#typeRef").val() === "board")
		$("#pills-tabContentComment").hide();
	else
		$("#pills-tabContentBoard").hide();
		
	$("#orderby1").click(function(){
		$("#pills-tabContentComment").hide();
		$("#pills-tabContentBoard").show();
	});
	$("#orderby2").click(function(){
		$("#pills-tabContentBoard").hide();
		$("#pills-tabContentComment").show();
	});
	
	$("#eventSeq_all_comment").click(function(){
	    if($("#eventSeq_all_comment").prop("checked")){
	        $(".comment").prop("checked",true);
	    }else{
	        $(".comment").prop("checked",false);
	    }
	})
	$("#eventSeq_all").click(function(){
	    if($("#eventSeq_all").prop("checked")){
	        $(".board").prop("checked",true);
	    }else{
	        $(".board").prop("checked",false);
	    }
	})
});



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



	<div class="all-dim"></div>
	<div class="containerNew">
		<div class="board-page">
			<div class="row">
				<div class="col-md-2">
					<div class="sidebar sticky" id="cssmenu">
						<ul>
							<li class="selected"><a href="/selectUserBoard?nickname=${user.nickname}"><span>작성 글 | 댓글</span></a></li>
							<li class="mid"><a href="/selectUserMoney?nickname=${user.nickname}"><span>계좌정보</span></a></li>
						</ul>
					</div>					
				</div>
  			<div class="col-md-10">
				<div class="free-board">
						<div class="drop-nav">
							<h1 class="tit-h1 line">작성 글 | 댓글</h1>
						</div>
						<div class="m-drop-nav">
							<h1 class="m-drop-tit-title line" style="cursor: pointer;">작성 글 | 댓글  <i class="fas fa-angle-down"></i></h1>
						</div>
						<div class="m-drop-down">
							<h1 class="m-drop-tit-body line" style="cursor: pointer;">
								<a href="/myPage03">작성 글 | 댓글</a>
							</h1>
							<h1 class="m-drop-tit-body line" style="cursor: pointer;">
								<a href="/myPage03">계좌정보</a>
							</h1>
						</div>
						<input type="hidden" id="typeRef" value="${type}">
		<div class="board-type">
			<div class="board-free-nav">
					<form id="form" class="board-list-top policy-in" action='/selectUserBoard?nickname=${user.nickname}'>
						<p class="pc-only">
							<input type="radio" class="ordeby" id="orderby1" name="orderby"
								value="userBoard" <c:if test='${type eq "board"}'>checked="checked"</c:if>><label for="orderby1"  class="new-board">작성 글 </label>
							<input type="radio" class="ordeby" id="orderby2" name="orderby"
								value="userComment" <c:if test='${type eq "comment"}'>checked="checked"</c:if>><label for="orderby2" class="hot-board" >작성 댓글 </label>
						</p>
					</form>
		 			 <!-- 
		 			 <c:if test="${loginUser != null}">
						<p class="right"><button class="board-write-btn fantasy" type="button" onclick="deleteBoard();">삭제</button></p>
					 </c:if>
					  -->	
					 		
			</div>
			<div class="tab-content" id="pills-tabContentBoard">
			
			<!-- 1111 -->
			<c:choose>
			<c:when test="${userBoard.size() > 0}">
					<!-- 전체글 -->
					<table class="board-free-table">
 							<colgroup>
								<col width="10%">
								<col width="50%">
								<col width="10%">
								<col width="5%">
								<col width="5%">
								<col width="15%">
							</colgroup>
							<thead>
							<tr>
								<th class="no" scope="col">N0.</th>
								<th class="title" scope="col">제목</th>
								<th class="writer" scope="col">작성자</th>
								<th class="views" scope="col">조회</th>
								<th class="likes" scope="col">추천</th>
								<th class="date" scope="col">작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${userBoard}" var="board">
							
									<tr>
										<td class="board-no">${board.pno}</td>
										<!-- 글번호 -->
										
										<c:choose>
											<c:when test="${board.commentCount ne 0}">
												<td class="board-title"><a href="/board/free/detail?pno=${board.pno}">${board.title}</a><b class="comment-num"><i class="far fa-comment-dots"></i>&nbsp;${board.commentCount}</b></td>
										<!-- 글 제목 -->
											</c:when>
											<c:otherwise>
												<td class="board-title"><a href="/board/free/detail?pno=${board.pno}">${board.title}</a></td>
											</c:otherwise>
										</c:choose>
										
										<td class="board-writer">${board.nickname}</td>
										<!-- 글쓴이 -->
										<td class="board-views"><span>조회 </span>${board.views}</td>
										<!-- 조회수 -->
										<td class="board-likes"><span>추천 </span>${board.likes}</td>
										<!-- 추천수 -->
										<fmt:formatDate value="${board.bdateTime}" var="time" pattern="MM/dd HH:mm"/>
										<td class="board-date">${time}</td>
										<!-- 날짜 -->
									</tr>
							</c:forEach>
							<c:if test="${userBoard.size() == 0}">
							    <tr>
							        <td colspan="7" style="text-align: center;">:::: 글이 없습니다.::::::</td>
							    </tr>
							</c:if>
						</tbody>
					</table>
					
					<!-- 페이징 -->
					<div class="paging">	
					<div class="paging-body">				
					<nav aria-label="..." class="pagination">
					    <ul class="pagination">
					
					<c:if test="${boardPage.nowPage != 1}">
					      <!-- << 버튼 -->
					      <li>
					        <a class="page-link"
					          href="/selectUserBoard?nickname=${user.nickname}&bnowPage=1&type=board&boardKeyword=${boardKeyword}&bSearchStyle=${bSearchStyle}"
					          tabindex="-1" aria-disabled="true">
					          <i class="fas fa-angle-double-left"></i>
					        </a>
					      </li>
					      <!-- 1페이지에서 < 버튼 눌렀을 때 -->
					      <c:if test="${boardPage.nowPage == 1}">
					        <li>
					          <a class="page-link"
					            href="/selectUserBoard?nickname=${user.nickname}&bnowPage=${boardPage.nowPage}&type=board&boardKeyword=${boardKeyword}&bSearchStyle=${bSearchStyle}"
					            tabindex="-1" aria-disabled="true">
					            <i class="fas fa-angle-left"></i>
					          </a>
					        </li>
					      </c:if>
					</c:if>
					      
					      <!-- 1페이지가 아닌 페이지에서 < 버튼 눌렀을 때 -->
					      <c:if test="${boardPage.nowPage != 1}">
					        <li>
					          <a class="page-link"
					            href="/selectUserBoard?nickname=${user.nickname}&bnowPage=${boardPage.nowPage-1}&type=board&boardKeyword=${boardKeyword}&bSearchStyle=${bSearchStyle}"
					            tabindex="-1" aria-disabled="true">
					            <i class="fas fa-angle-left"></i>
					          </a>
					        </li>
					      </c:if>
					      
					      <!-- 한번에 5개 페이지 보여줌 -->
					       <c:forEach begin="${boardPage.startPage }"
					        end="${boardPage.endPage }" var="p">
					        <c:choose>
					          <c:when test="${p == boardPage.nowPage}">
					            <li class="page-item active" aria-current="page">
					              <a class="page-link" href="#">${p}
					                <span class="sr-only">(current)</span>
					              </a>
					            </li>
					          </c:when>
					          <c:when test="${p != boardPage.nowPage}">
					            <li class="page-item">
					              <a class="page-link" href="/selectUserBoard?nickname=${user.nickname}&bnowPage=${p}&type=board&boardKeyword=${boardKeyword}&bSearchStyle=${bSearchStyle}">${p}</a>
					            </li>
					          </c:when>
					        </c:choose>
					      </c:forEach> 
					      
					      
					      
					 	 <c:if test="${boardPage.nowPage != boardPage.lastPage}">    
					      <!-- 현재 페이지가 마지막 페이지일 경우 > 버튼을 눌렀을 때 -->
					      <c:if test="${boardPage.nowPage == boardPage.lastPage}">
					        <li>
					          <a class="page-link"
					            href="/selectUserBoard?nickname=${user.nickname}&bnowPage=${boardPage.nowPage}&type=board&boardKeyword=${boardKeyword}&bSearchStyle=${bSearchStyle}"
					            tabindex="+1" aria-disabled="true">
					            <i class="fas fa-angle-right"></i>
					          </a>
					        </li>
					      </c:if>
					      
					      <!-- 현재 페이지가 마지막 페이지가 아닐 경우에 > 버튼을 눌렀을 때 -->					
					      <c:if test="${boardPage.nowPage != boardPage.lastPage}">
					        <li>
					          <a class="page-link"
					            href="/selectUserBoard?nickname=${user.nickname}&bnowPage=${boardPage.nowPage+1}&type=board&boardKeyword=${boardKeyword}&bSearchStyle=${bSearchStyle}"
					            tabindex="+1" aria-disabled="true" data-ajax="false">
					            <i class="fas fa-angle-right"></i>
					          </a>
					        </li>
					      </c:if> 
					
					      <!-- >> 버튼 -->
					      <li>
					        <a class="page-link"
					        href="/selectUserBoard?nickname=${user.nickname}&bnowPage=${boardPage.lastPage}&type=board&boardKeyword=${boardKeyword}&bSearchStyle=${bSearchStyle}"
					        tabindex="-1" aria-disabled="true">
					          <i class="fas fa-angle-double-right"></i>
					        </a>
					      </li>
					      
					      </c:if>
					    </ul>
					  </nav>
					 </div>


				</div>
				
				<div class="search-area">
					<div  class="search-area-body">
					<form class="form-inline my-2 my-lg-0 underSearchForm" action="/myPage03">
						<!-- <a class="nav-link dropdown-toggle" href="#" id="dropdown01"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">제목</a> -->
						<select class="dropdown-toggle-board" name="bsearchStyle">
							<option class="nav-link dropdown-toggle board-item" id="dropdown01"
								data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" value="" <c:if test='${searchStyle eq ""}'>selected</c:if>>전체</option>							
							<option class="dropdown-item board-item" value="search_title"<c:if test='${searchStyle eq "search_title"}'>selected</c:if>>제목</option> 
							<option class="dropdown-item board-item" value="search_content"<c:if test='${searchStyle eq "search_content"}'>selected</c:if>>내용</option>
						</select>
						<input type="hidden" name="type" value="board">
						<input class="form-control mr-sm-2 board-search" type="search"
							placeholder="검색어 입력" aria-label="Search" name="bSearchKeyword" value="${bSearchKeyword}">
						<button class="btn btn-outline-secondary my-2 my-sm-0 board-search-btn"
							type="submit">
							<i class="fas fa-search"></i>
						</button>
					</form>
					</div>
				</div>
				</c:when>
				
				
				<c:otherwise>
				<!-- 22222 -->
					<div class="message-wrap">
						<div class="message-st-01">
							<p class="big-text">아직 발생한 알림이 없습니다.</p>
							<p>거래 체결과 커뮤니티에서 다양한 이야기를 나누면 알림이 발생합니다!</p>
						</div>
					</div>
				</c:otherwise>
				</c:choose>
			</div>
		</div>
		
			<div class="tab-content" id="pills-tabContentComment">
			
			
			<!-- 3333 -->
				<!-- 전체글 -->
				<c:choose>
					<c:when test="${userComment.size() > 0}">
					<table class="board-free-table">
 							<colgroup>
								<col width="10%">
								<col width="50%">
								<col width="10%">
								<col width="20%">
							</colgroup>
							<thead>
							<tr>
								<th class="no" scope="col">N0.</th>
								<th class="title" scope="col">제목</th>
								<th class="writer" scope="col">작성자</th>
								<th class="date" scope="col">작성일</th>
							</tr>
						</thead>
						
						
						
						
						
						
						<tbody>
							<c:forEach items="${userComment}" var="comment">
							
								<c:if test="true">
									<tr>
										<td class="board-no">${comment.pno}</td>
										<!-- 글번호 -->
										
										<td class="board-title"><a href="/board/free/detail?pno=${comment.pno}">${comment.ccontent}</a></td>
										
										<td class="board-writer">${comment.nickname}</td>
										<!-- 글쓴이 -->
										<fmt:formatDate value="${comment.cdateTime}" var="time" pattern="MM/dd HH:mm"/>
										<td class="board-date">${time}</td>
										<!-- 날짜 -->
									</tr>
								</c:if>
							</c:forEach>
							<c:if test="${userBoard.size() == 0}">
							    <tr>
							        <td colspan="7" style="text-align: center;">:::::댓글이 없습니다.::::::</td>
							    </tr>
							</c:if>
						</tbody>
					</table>
					
					<!-- 페이징 -->
					<div class="paging">	
					<div class="paging-body">				
					<nav aria-label="..." class="pagination">
					    <ul class="pagination">
					
					<c:if test="${commentPage.nowPage != 1}">
					      <!-- << 버튼 -->
					      <li>
					        <a class="page-link"
					          href="/selectUserBoard?nickname=${user.nickname}&cnowPage=1&type=comment&commentKeyword=${commentKeyword}"
					          tabindex="-1" aria-disabled="true">
					          <i class="fas fa-angle-double-left"></i>
					        </a>
					      </li>
					      <!-- 1페이지에서 < 버튼 눌렀을 때 -->
					      <c:if test="${commentPage.nowPage == 1}">
					        <li>
					          <a class="page-link"
					            href="/selectUserBoard?nickname=${user.nickname}&cnowPage=${commentPage.nowPage}&type=comment&commentKeyword=${commentKeyword}"
					            tabindex="-1" aria-disabled="true">
					            <i class="fas fa-angle-left"></i>
					          </a>
					        </li>
					      </c:if>
					</c:if>
					      
					      <!-- 1페이지가 아닌 페이지에서 < 버튼 눌렀을 때 -->
					      <c:if test="${commentPage.nowPage != 1}">
					        <li>
					          <a class="page-link"
					            href="/selectUserBoard?nickname=${user.nickname}&cnowPage=${commentPage.nowPage-1}&type=comment&commentKeyword=${commentKeyword}"
					            tabindex="-1" aria-disabled="true">
					            <i class="fas fa-angle-left"></i>
					          </a>
					        </li>
					      </c:if>
					      
					      <!-- 한번에 5개 페이지 보여줌 -->
					       <c:forEach begin="${commentPage.startPage }"
					        end="${commentPage.endPage }" var="p">
					        <c:choose>
					          <c:when test="${p == commentPage.nowPage}">
					            <li class="page-item active" aria-current="page">
					              <a class="page-link" href="#">${p}
					                <span class="sr-only">(current)</span>
					              </a>
					            </li>
					          </c:when>
					          <c:when test="${p != commentPage.nowPage}">
					            <li class="page-item">
					              <a class="page-link" href="/selectUserBoard?nickname=${user.nickname}&cnowPage=${p}&type=comment&commentKeyword=${commentKeyword}">${p}</a>
					            </li>
					          </c:when>
					        </c:choose>
					      </c:forEach> 
					      
					      
					      
					 	 <c:if test="${commentPage.nowPage != commentPage.lastPage}">    
					      <!-- 현재 페이지가 마지막 페이지일 경우 > 버튼을 눌렀을 때 -->
					      <c:if test="${commentPage.nowPage == commentPage.lastPage}">
					        <li>
					          <a class="page-link"
					            href="/selectUserBoard?nickname=${user.nickname}&cnowPage=${commentPage.nowPage}&type=comment&commentKeyword=${commentKeyword}"
					            tabindex="+1" aria-disabled="true">
					            <i class="fas fa-angle-right"></i>
					          </a>
					        </li>
					      </c:if>
					      
					      <!-- 현재 페이지가 마지막 페이지가 아닐 경우에 > 버튼을 눌렀을 때 -->					
					      <c:if test="${commentPage.nowPage != commentPage.lastPage}">
					        <li>
					          <a class="page-link"
					            href="/selectUserBoard?nickname=${user.nickname}&cnowPage=${commentPage.nowPage+1}&type=comment&commentKeyword=${commentKeyword}"
					            tabindex="+1" aria-disabled="true" data-ajax="false">
					            <i class="fas fa-angle-right"></i>
					          </a>
					        </li>
					      </c:if> 
					
					      <!-- >> 버튼 -->
					      <li>
					        <a class="page-link"
					        href="/selectUserBoard?nickname=${user.nickname}&cnowPage=${commentPage.lastPage}&type=comment&commentKeyword=${commentKeyword}"
					        tabindex="-1" aria-disabled="true">
					          <i class="fas fa-angle-double-right"></i>
					        </a>
					      </li>
					      
					      </c:if>
					    </ul>
					  </nav>
					 </div>


				</div>
				
				<div class="search-area">
					<div  class="search-area-body">
					<form class="form-inline my-2 my-lg-0 underSearchForm" action="/selectUserBoard?nickname=${user.nickname}">
						<!-- <a class="nav-link dropdown-toggle" href="#" id="dropdown01"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">제목</a> -->
						<input class="form-control mr-sm-2 board-search" type="search"
							placeholder="검색어 입력" aria-label="Search">
						<button class="btn btn-outline-secondary my-2 my-sm-0 board-search-btn"
							type="submit">
							<i class="fas fa-search"></i>
						</button>
					</form>
					</div>
				</div>
				</c:when>
				<c:otherwise>
				<!-- 4444 -->
					<div class="message-wrap">
						<div class="message-st-01">
							<p class="big-text">아직 발생한 알림이 없습니다.</p>
							<p>거래 체결과 커뮤니티에서 다양한 이야기를 나누면 알림이 발생합니다!</p>
						</div>
					</div>
				</c:otherwise>
				</c:choose>				
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