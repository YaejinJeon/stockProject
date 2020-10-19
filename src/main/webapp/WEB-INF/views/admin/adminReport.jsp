 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" />
 
<!--  스타일-->
  <link href="/resources/css/datatable.css" rel="stylesheet" />
        
<!-- 통합관리자 -->
<link rel="stylesheet" href="/resources/css/free-board.css">
<link rel="stylesheet" href="/resources/css/sidebar.css">
<link rel="stylesheet" href="/resources/css/popup.css">
<link rel="stylesheet" href="/resources/css/admin.css">

<style type="text/css">
.free-board {
	margin-bottom: 0 !important;
	box-shadow:none !important;
	border: none !important;
}
</style>

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
            <nav class="sb-sidenav accordion sb-sidenav-dark"">
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
							<h2 class="tit-h2 type mopad">신고</h2>
						<div class="board-type">
							<div class="tab-content" id="pills-tabContent">
								<!-- 전체글 -->
								<table class="board-free-table">
									<colgroup>
										<col width="15%">
										<col width="40%">
										<col width="10%">
										<col width="15%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
                                            <th class="no" scope="col">신고사항</th>
                                            <th class="title" scope="col">제목</th>
                                            <th class="writer" scope="col">작성자</th>
                                            <th class="views" scope="col">처리현황</th>
                                            <th class="date" scope="col">신고 일시</th>
                                        </tr>
									</thead>
									<tbody>
										<c:forEach items="${reportList}" var="re" varStatus="status">
	                                       <tr>	
	                                       		<td><p class="board-no">${re.rtype}</p></td>
	                                            <td class="board-title" onclick="findRno('${re.rno}');">
	                                            <a class="content" id="popup-btn" style="cursor: pointer;">${re.title}</a>
	                                            </td>
	                                            <td class="board-writer">${re.nickname}</td>
	                                            <td class="board-views">${re.rcheck}</td>
	                                            <td class="board-date"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${re.rdatetime}"/></td>
	                                        </tr>
                                        </c:forEach>
									</tbody>
								</table>
	
								<!-- 페이징 -->
								<div class="paging">
									<c:if test="${reportPage.total gt 10}">
										<div class="paging-body">
											<nav aria-label="..." class="pagination">
												<ul class="pagination">

													<c:if test="${reportPage.nowPage != 1}">
														<!-- << 버튼 -->
														<li><a class="page-link"
															href="/admin/report?bnowPage=1" tabindex="-1"
															aria-disabled="true"> <i
																class="fas fa-angle-double-left"></i>
														</a></li>
														<!-- 1페이지에서 < 버튼 눌렀을 때 -->
														<c:if test="${reportPage.nowPage == 1}">
															<li><a class="page-link"
																href="/admin/report?bnowPage=${reportPage.nowPage}"
																tabindex="-1" aria-disabled="true"> <i
																	class="fas fa-angle-left"></i>
															</a></li>
														</c:if>
													</c:if>

													<!-- 1페이지가 아닌 페이지에서 < 버튼 눌렀을 때 -->
													<c:if test="${reportPage.nowPage != 1}">
														<li><a class="page-link"
															href="/admin/report?bnowPage=${reportPage.nowPage-1}"
															tabindex="-1" aria-disabled="true"> <i
																class="fas fa-angle-left"></i>
														</a></li>
													</c:if>

													<!-- 한번에 5개 페이지 보여줌 -->
													<c:forEach begin="${reportPage.startPage }"
														end="${reportPage.endPage }" var="p">
														<c:choose>
															<c:when test="${p == reportPage.nowPage}">
																<li class="page-item active" aria-current="page"><a
																	class="page-link" href="#">${p} <span
																		class="sr-only">(current)</span>
																</a></li>
															</c:when>
															<c:when test="${p != reportPage.nowPage}">
																<li class="page-item"><a class="page-link"
																	href="/admin/report?bnowPage=${p}">${p}</a></li>
															</c:when>
														</c:choose>
													</c:forEach>



													<c:if test="${reportPage.nowPage != reportPage.lastPage}">
														<!-- 현재 페이지가 마지막 페이지일 경우 > 버튼을 눌렀을 때 -->
														<c:if test="${reportPage.nowPage == reportPage.lastPage}">
															<li><a class="page-link"
																href="/admin/report?bnowPage=${reportPage.nowPage}"
																tabindex="+1" aria-disabled="true"> <i
																	class="fas fa-angle-right"></i>
															</a></li>
														</c:if>

														<!-- 현재 페이지가 마지막 페이지가 아닐 경우에 > 버튼을 눌렀을 때 -->
														<c:if test="${reportPage.nowPage != reportPage.lastPage}">
															<li><a class="page-link"
																href="/admin/report?bnowPage=${reportPage.nowPage+1}"
																tabindex="+1" aria-disabled="true" data-ajax="false">
																	<i class="fas fa-angle-right"></i>
															</a></li>
														</c:if>

														<!-- >> 버튼 -->
														<li><a class="page-link"
															href="/admin/report?bnowPage=${reportPage.lastPage}"
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
											action="/admin/report">
											<select class="dropdown-toggle-board" name="searchStyle">
												<option class="nav-link dropdown-toggle board-item"
													id="dropdown01" data-toggle="dropdown" aria-haspopup="true"
													aria-expanded="false" value=""
													<c:if test='${searchStyle eq ""}'>selected</c:if>>전체</option> 
												<option class="dropdown-item board-item" value="search_title"
													<c:if test='${searchStyle eq "search_title"}'>selected</c:if>>제목</option>
												<option class="dropdown-item board-item" value="search_content"
													<c:if test='${searchStyle eq "search_content"}'>selected</c:if>>내용</option>
												<option class="dropdown-item board-item" value="search_title_content"
													<c:if test='${searchStyle eq "search_title_content"}'>selected</c:if>>제목 + 내용</option>
												<option class="dropdown-item board-item" value="search_rtype"
													<c:if test='${searchStyle eq "search_rtype"}'>selected</c:if>>신고사항</option>
											</select> 
											<input class="form-control mr-sm-2 board-search" type="search" name="keyword" placeholder="검색어 입력" aria-label="Search">
											<button class="btn btn-outline-secondary my-2 my-sm-0 board-search-btn" type="submit"><i class="fas fa-search"></i></button> 
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
    
<div id="reportPopup" class="pop-layer" style="display:none">
		<div class="pop-inner">
			<div class="popup-wrap">
				<form id="reportBoard" action="/reportBoard" method="POST">
					<div class="pop-tit"><span>게시물 신고 내역</span></div>
					<div class="pop-cont">
						<div class="pop-clean">
							<table>
								<colgroup><col style="width: 100px;"><col style=""></colgroup>
								<tbody id="reportSelectList">
								</tbody>
							</table>
						</div>
							<div class="pop-btn" id="pageLocation">
							</div>
					</div>
					<button type="button" onclick="hidePopup()" class="cla-close e-reportPopupClose">닫기</button>
				</form> 
			</div>
		</div>
	</div>
	<script>
	function changeDate(date){
        var date = new Date(date);
        year = date.getFullYear();
        month = date.getMonth() + 1;
        if(month < 10) {
        	month = "0" + month
        }
        day = date.getDate();
        hour = date.getHours();
        if(hour < 10) {
        	hour = "0"+hour;
        }
        if(hour > 24) {
        	hour -= 24;
        	if(hour < 10) {
        	hour = "0"+hour
        	}
        }
        if(hour == 24){
        	hour = "00";
        }
        minute = date.getMinutes();
        if(minute < 10) {
        	minute = "0" + minute;
        }
        second = date.getSeconds();
        strDate = year+"-"+month+"-"+day+" "+hour+":"+minute;
        return strDate;
    }
	
		
	 function findRno(rno){
     	$.ajax({
				type : "POST",
				url : '${pageContext.request.contextPath}/admin/findRno',
				data : { "rno" : rno },
				success : function(data) {
					var reportSelectList = "";
					reportSelectList += '<tr>'
					reportSelectList += 	'<th scope="col">처리현황</th>'
					reportSelectList += 	'<td id="re.rcheck">'+data.reportSelectList.rcheck+'</td>'
					reportSelectList += '</tr>'
					reportSelectList += '<tr>'
					reportSelectList += 	'<th scope="col">신고날짜</th>'
					reportSelectList += 	'<td>'+changeDate(data.reportSelectList.rdatetime)+'</td>'
					reportSelectList += '</tr>'
					reportSelectList += '<tr>'
					reportSelectList += 	'<th scope="col">신고사항</th>'
					reportSelectList += 	'<td>'+data.reportSelectList.rtype+'</td>'
					reportSelectList += '</tr>'
					reportSelectList += 	'<th scope="col">게시판 명</th>'
					if(data.reportSelectList.bno === 'free')data.reportSelectList.bno = '자유게시판'
					if(data.reportSelectList.bno === 'portfolio')data.reportSelectList.bno = '포트폴리오 게시판'
					reportSelectList += 	'<td>'+data.reportSelectList.bno+'</td>'
					reportSelectList += '</tr>'
					reportSelectList += '<tr>'
					reportSelectList += 	'<th scope="col">작성자</th>'
					reportSelectList += 	'<td>'+data.reportSelectList.nickname+'</td>'
					reportSelectList += '</tr>'
					reportSelectList += '<tr>'
					reportSelectList += 	'<th scope="col">제목</th>'
					reportSelectList += 	'<td>'+data.reportSelectList.title+'</td>'
					reportSelectList += '</tr>'
					reportSelectList += '<tr>'
					$("#reportSelectList").html(reportSelectList);
					var pageLocation=""
					if(data.reportSelectList.rcheck === '처리대기중'){
						if(data.reportSelectList.bno === '자유게시판'){
							pageLocation += '<button type="button" class="btn-m fantasy" onclick="location.href=\'/board/free/detail?pno='+data.reportSelectList.pno+'\'">게시물 이동</button>'
							pageLocation += '<span class="close-btn"><button type="button" class="btn-m fantasy" onclick="location.href=\'/admin/report/delete?pno='+data.reportSelectList.pno+'\'">게시물 삭제</button>'
						}
						else if(data.reportSelectList.bno === '포트폴리오 게시판'){
							pageLocation += '<button type="button" class="btn-m fantasy" onclick="location.href=\'/board/portfolio/detail?pno='+data.reportSelectList.pno+'\'">게시물 이동</button>'
							pageLocation += '<span><button type="button" class="btn-m" onclick="location.href=\'/admin/report/delete?pno='+data.reportSelectList.pno+'\'">게시물 삭제</button>'
						}
					}
					pageLocation += '<button type="button"  onclick="hidePopup()" class="btn-m e-reportPopupClose">취소</button></span>'
					$("#pageLocation").html(pageLocation);
				},
				error: function(){
				}
			});
     }
	
	
        /** 신고 기능들 모음 Report */
        var Report = (function($) {
            var root = this;
            var Module;
            if (typeof exports !== 'undefined') {
                Module = exports;
            } else {
                Module = root.Module = {};
            }
            Module.version = '1.0';
            Module.discript = '신고'

            Module.ajaxSubmitReport = function (bbsWrtRprtVO) {
                var bbsSuveInfoVO = Module.bbsSuveInfoVO;

                if(Module.vaildateSubmitReport(bbsWrtRprtVO)){
                    return;
                }                
                
                if(confirm("신고하시겠습니까?")){
                	
                }                
            }
            Module.vaildateSubmitReport = function (bbsWrtRprtVO) {
                return false;
            }
            return Module;
        }(jQuery));
        (function start() {
            var bbsWrtVO = {"seq":150357583578728,"id":"N10841","regDate":"2020-06-16 09:29:16.0","regmnId":"tsbaki22","regmnNicknm":"콰지콰지","regmnIp":"192.168.112.102","regmnImgPath":"//www.paxnet.co.kr/my/files/badge/like4S.png","title":"펌)첫 출근 후 울었습니다. ","wrtCntnSmry":null,"itemCode":null,"tabInfo":null,"hdwr":null,"wrtGrad":null,"wrtStat":null,"pstn":null,"ottpTarget":null,"wrtePath":"web","fileAttaYn":"N","recmUseYn":"Y","comtUseYn":"Y","orgnId":null,"pswd":null,"uusrId":null,"updtDate":null,"blidYn":"N","suveYn":"N","applyBbsName":null,"hitsNum":0,"recmNum":0,"comtNum":0,"totalCnt":0,"nextKey":null,"wrtNo":395965,"popYn":null,"bestYn":null,"bbsTypeId":null,"itemName":null,"orignBbsName":null,"realNmChk":"N","preSeq":0,"nextSeq":0,"preTitle":null,"nextTitle":null,"specWrtNo":null,"specRegDate":null,"keyId":null,"specId":null,"orgnSpecBbsId":null,"movebbsTypeId":null,"movePstn":null,"notices":[],"bbsVO":{"id":"N10841","ooId":null,"bbsName":null,"bbsTypeId":null,"bbsPstn":null,"expl":null,"mngrCode":null,"delYn":null,"note":null,"pstnName":null,"wrtRegCode":null,"bbsFunction":null,"viewType":null,"areas":null,"bbsInfos":null,"view":null,"bbsContentFunctionDetailMap":null,"paging":null,"bbsWrts":null,"bbsList":null,"fn002Yn":false,"fn003Yn":false,"fn004Yn":false,"fn005Yn":false,"fn006Yn":false,"fn011Yn":false,"fn012Yn":false,"fn015Yn":false,"fn018Yn":false,"fn021Yn":false,"fn022Yn":false,"fn023Yn":false,"fn024Yn":false,"fn025Yn":false,"fn028Yn":false,"fn029Yn":false,"fn030Yn":false,"fn031Yn":false,"fn032Yn":false,"fn033Yn":false,"fn034Yn":false,"fn035Yn":false,"fn036Yn":false,"fn037Yn":false,"fn038Yn":false,"fn039Yn":false,"fn040Yn":false,"fn041Yn":false,"fn042Yn":false,"adminFlag":null,"level":0,"wrtFlag":null,"listLabelList":null,"sortLabelList":null,"pageLabelList":null,"searchLabelList":null,"contheadLabelList":null,"classLabelList":null,"pstnLabelList":null,"adminLabelList":null,"viewLabelList":null,"wrtLabelList":null,"uptLabelList":null,"bbsWrtVO":null,"jsonBbsWrtVO":null,"preNextBbsWrtVOs":null,"bbsWrtRecentInfoVO":null,"loginCustVO":null,"bbsTypeAndViewKey":"null_null"},"orignBbsVO":null,"bbsWrtRecentInfoVO":{"seq":150357583578728,"id":null,"seeCount":24,"recommendCount":0,"commentCount":0},"bbsWrtCntnVO":{"seq":150357583578728,"cntn":"<p><img class=\"lazy\" style=\"max-width: 100%;\" alt=\"88dc1af2-62a1-423a-a20e-21fdd1c9ffa1.png\" src=\"http://www.paxnet.co.kr/tbbs/files/N10841/20200616/88dc1af2-62a1-423a-a20e-21fdd1c9ffa1.png\"><br></p>","regDate":null},"bbsSuveInfoVO":null,"bbsWrtAttaFileVOs":[],"bbsWrtBlidVO":null,"specBbsWrtVO":{"id":null,"seq":null,"orgnId":null,"regDate":null,"updtDate":null,"uusrId":null,"delYn":null,"delResnCode":null,"delDate":null,"dusrId":null,"wrtNo":0,"regmnId":"tsbaki22","regmnNicknm":"콰지콰지"},"editorPickBbsWrtVO":null,"fileList":null,"delFileList":null,"notiList":null,"delNotiList":null,"pageNo":0,"rn":0,"dealAmt":0,"ddSeq":0,"earnRate":0.0,"dealDt":null};
            var custId = "${loginUser.nickname}";
            
            var bbsTitle = '자유게시판';

            jQuery('.e-reportPopupClose').on('click',function(){
            	$(".wrap").show();
                jQuery('#reportPopup').hide();
                
                initInput();
            });

            if(custId !== '') { //로그인 로직
                jQuery(document).on('click', '#popup-btn', function () {
                	$("#rprtResn").val("");
                	closeLayerPop();
                	
                	 if("${loginUser.nickname}" != bbsWrtVO.regmnId){
                		if(checkWrtRprt(bbsWrtVO.seq)){
                            jQuery('#reportPopup').show();
                            
                            if($('html').hasClass('mobile-size')){
        						$('html, body').scrollTop(0);					
        						$(".wrap").hide();
        					}
                    	}                		
                	}else{
                		alert("본인의 글은 신고 할 수 없습니다.");
                	} 
                	
                });

            }
        }());
        
         function initInput(){
        	//초기화
            $(".selectpicker").val('');
            $(".selectpicker").selectpicker('refresh');
            $("#rtype").val("");
            $("#rprtResn").val("");
        } 
         
         function checkWrtRprt(wrtSeq){
         	var result = true;
         	$.ajax({
 				type : "POST",
 				url : "checkWrtRprt.json",
 				data : {wrtSeq : wrtSeq},
 				dataType : "json",
 				async : false,
 				success : function(data) {
 					if(data.result){
 						alert("이미 신고하셨습니다.");
 						result = false;
 					}
 				},beforeSend: function(){
 				},
 				complete: function(){
 				},
 				error : function(e, textStatus) {
 				}
 			});
         	return result;
         } 
        
    	function closeLayerPop() {
    		$(".scrap-box").css("display", "none");
    		$(".sns").css("display", "none");
    		$(".layer_pop").remove();
    		$(".reply-area").remove();
    		$(".file-box").css("display", "none");
    		$("#zoom_layer").css("display", "none");
    	}
	</script>
	<script>
$('.e-reportComtPopupClose').on('click',function(){	
	$(".wrap").show();
    $('#reportComtPopup').remove();
});

function submitReportComt(){
	if( $('#comtRprtCode').val() == "" ){
    	alert("신고항목을 선택하세요.");
    	return false;                	
    	
    } else if( $.trim($('#comtRprtResn').val()) == "" ){
    	alert("내용을 입력해주세요.");
    	return false;                	
    	
    } else{
        $("#rprtCode").val($('#comtRprtCode').val());
        $("#rprtResn").val($('#comtRprtResn').val());
        
        $("#comtRprtCd").val($('#comtRprtCode').val());
        $("#comtRprtRe").val($('#comtRprtResn').val());
        
    }
}
		// 취소버튼 눌렀을 때 내용 초기화, 팝업 hide
		function hidePopup(){
            jQuery('#reportPopup').hide();
            initInput()
		}

</script>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js" ></script>
    <script src="/resources/js/scripts.js"></script>
    <script src="/resources/js/datatables-demo.js"></script>    
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
</body>

</html>