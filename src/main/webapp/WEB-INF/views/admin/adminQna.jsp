 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
  <meta name="generator" content="Jekyll v4.0.1">
  <title>관리자 페이지</title>




    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
   <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/dashboard/">
<script src="http://code.jquery.com/jquery-latest.min.js" ></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<!-- 데이터테이블스타일 -->
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
 
<!--  스타일-->
  <link href="/resources/css/datatable.css" rel="stylesheet" />
        
<!-- 통합관리자 -->
<link rel="stylesheet" href="/resources/css/free-board.css">	
 <link rel="stylesheet" href="/resources/css/admin.css">


</head>

<body class="sb-nav-fixed">



    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <!--    로고들어감 -->
        			<a href="/" class="navbar-logo">
			<img class="" id="logo"
				src="/resources/img/finalogo.png">
				</a> 
        <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i
                class="fas fa-bars"></i></button>




        <!-- Navbar 모바일 미디어 드롭메뉴- 사람아이콘 누르면 -->
        <ul class="navbar-nav ml-auto mr-md-0">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="/logOut">로그아웃</a>
                </div>
            </li>
        </ul>



    </nav>
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <a class="nav-link" href="/admin/main">
                            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
             			               관리자 페이지
                        </a>

                        <a class="nav-link" href="/admin/qna">
                            <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
         				                   Q&amp;A
                        </a>
                        <a class="nav-link" href="/admin/report">
                            <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                         		   신고
                        </a>
                    </div>
                </div>
                
                
                
                
                
            </nav>
        </div>
        <div id="layoutSidenav_content">
 
 						<div class="free-board" >

 							
<!-- 								<h1 class="tit-h1 line">Q&amp;A</h1>
							
							<div class="qna-desc">
								<strong class="import">서비스 이용중 궁금한 내역이 있으시면, 언제든지 문의해주세요!</strong>
								<span class="time">1:1로 접수 주시면 빠른답변을 받아보실 수 있습니다. 평일 08:30~17:30</span>
								<a href="javascript:pageMove('serviceInqryInsert');" class="inquiry">1:1문의</a>
							</div> -->
							<h2 class="tit-h2 type mopad" style="">Q&amp;A</h2>
						<div class="board-type">
							
							<div class="tab-content" id="pills-tabContent">
								<!-- 전체글 -->
								<table class="board-free-table">
									<colgroup>
										<col width="10%">
										<col width="60%">
										<col width="10%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th class="no" scope="col">종류</th>
											<th class="title" scope="col">제목</th>
											<th class="views" scope="col">처리현황</th>
											<th class="date" scope="col">작성일</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${qnaList}" var="qna">
												<tr>
													<td class="board-no">${qna.qtype}</td>
													<!-- 글번호 -->
															<td class="board-title"><a
																href="/admin/qna/detail?qno=${qna.qno}">${qna.qtitle}</a></td>

													<%-- <td class="board-writer"><a href="/selectUserMoney?nickname=${qna.nickname}">${board.nickname}</a></td> --%>
													<!-- 글쓴이 -->
													<td class="board-views">${qna.qcheck}</td>
													<fmt:formatDate value="${qna.qdateTime}" var="time"
														pattern="yyyy-MM-dd HH:mm" />
													<td class="board-date">${time}</td>
													<!-- 날짜 -->
												</tr>
										</c:forEach>
									</tbody>
								</table>
	
								<!-- 페이징 -->
								<div class="paging">
									<c:if test="${qnaPage.total gt 30}">
										<div class="paging-body">
											<nav aria-label="..." class="pagination">
												<ul class="pagination">

													<c:if test="${qnaPage.nowPage != 1}">
														<!-- << 버튼 -->
														<li><a class="page-link"
															href="/admin/qna?bnowPage=1" tabindex="-1"
															aria-disabled="true"> <i
																class="fas fa-angle-double-left"></i>
														</a></li>
														<!-- 1페이지에서 < 버튼 눌렀을 때 -->
														<c:if test="${qnaPage.nowPage == 1}">
															<li><a class="page-link"
																href="/admin/qna?bnowPage=${qnaPage.nowPage}"
																tabindex="-1" aria-disabled="true"> <i
																	class="fas fa-angle-left"></i>
															</a></li>
														</c:if>
													</c:if>

													<!-- 1페이지가 아닌 페이지에서 < 버튼 눌렀을 때 -->
													<c:if test="${qnaPage.nowPage != 1}">
														<li><a class="page-link"
															href="/admin/qna?bnowPage=${qnaPage.nowPage-1}"
															tabindex="-1" aria-disabled="true"> <i
																class="fas fa-angle-left"></i>
														</a></li>
													</c:if>

													<!-- 한번에 5개 페이지 보여줌 -->
													<c:forEach begin="${qnaPage.startPage }"
														end="${qnaPage.endPage }" var="p">
														<c:choose>
															<c:when test="${p == qnaPage.nowPage}">
																<li class="page-item active" aria-current="page"><a
																	class="page-link" href="#">${p} <span
																		class="sr-only">(current)</span>
																</a></li>
															</c:when>
															<c:when test="${p != qnaPage.nowPage}">
																<li class="page-item"><a class="page-link"
																	href="/admin/qna?bnowPage=${p}">${p}</a></li>
															</c:when>
														</c:choose>
													</c:forEach>



													<c:if test="${qnaPage.nowPage != qnaPage.lastPage}">
														<!-- 현재 페이지가 마지막 페이지일 경우 > 버튼을 눌렀을 때 -->
														<c:if test="${qnaPage.nowPage == qnaPage.lastPage}">
															<li><a class="page-link"
																href="/admin/qna?bnowPage=${qnaPage.nowPage}"
																tabindex="+1" aria-disabled="true"> <i
																	class="fas fa-angle-right"></i>
															</a></li>
														</c:if>

														<!-- 현재 페이지가 마지막 페이지가 아닐 경우에 > 버튼을 눌렀을 때 -->
														<c:if test="${qnaPage.nowPage != qnaPage.lastPage}">
															<li><a class="page-link"
																href="/admin/qna?bnowPage=${qnaPage.nowPage+1}"
																tabindex="+1" aria-disabled="true" data-ajax="false">
																	<i class="fas fa-angle-right"></i>
															</a></li>
														</c:if>

														<!-- >> 버튼 -->
														<li><a class="page-link"
															href="/admin/qna?bnowPage=${qnaPage.lastPage}"
															tabindex="-1" aria-disabled="true"> <i
																class="fas fa-angle-double-right"></i>
														</a></li>

													</c:if>
												</ul>
											</nav>
										</div>
									</c:if>


								</div>

								<div class="search-area">
									<div class="search-area-body">
										<form class="form-inline my-2 my-lg-0 underSearchForm"
											action="/customerClaim/list">
											<!-- <a class="nav-link dropdown-toggle" href="#" id="dropdown01"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">제목</a> -->
											<select class="dropdown-toggle-board" name="searchStyle">
												<option class="nav-link dropdown-toggle board-item"
													id="dropdown01" data-toggle="dropdown" aria-haspopup="true"
													aria-expanded="false" value=""
													<c:if test='${searchStyle eq ""}'>selected</c:if>>전체</option>
												<option class="dropdown-item board-item"
													value="search_title"
													<c:if test='${searchStyle eq "search_title"}'>selected</c:if>>제목</option>
												<option class="dropdown-item board-item"
													value="search_content"
													<c:if test='${searchStyle eq "search_content"}'>selected</c:if>>내용</option>
												<option class="dropdown-item board-item"
													value="search_title_content"
													<c:if test='${searchStyle eq "search_title_content"}'>selected</c:if>>제목
													+ 내용</option>
												<option class="dropdown-item board-item" value="search_nick"
													<c:if test='${searchStyle eq "search_nick"}'>selected</c:if>>글쓴이</option>
											</select> <input class="form-control mr-sm-2 board-search"
												type="search" name="keyword" placeholder="검색어 입력"
												aria-label="Search">
											<button
												class="btn btn-outline-secondary my-2 my-sm-0 board-search-btn"
												type="submit">
												<i class="fas fa-search"></i>
											</button>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>           

            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted">Copyright ⓒ 2020 - 2020 fantasy stock. All rights reserved.</div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js" crossorigin="anonymous">
    </script>
    <script src="/resources/js/scripts.js"></script>
    <script src="/resources/js/datatables-demo.js"></script>    
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>

</body>

</html>