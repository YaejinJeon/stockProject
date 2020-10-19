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


<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript" src="/resources/se2/js/HuskyEZCreator.js" charset="utf-8" ></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
<link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/dashboard/">
<script src="http://code.jquery.com/jquery-latest.min.js" ></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<!-- 데이터테이블스타일 -->
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
 
<!--  스타일-->
  <link href="/resources/css/free-board-detail.css" rel="stylesheet">
  <link href="/resources/css/datatable.css" rel="stylesheet" />
        
<!-- 통합관리자 -->
 <link rel="stylesheet" href="/resources/css/admin.css">
<style type="text/css">
.bt-area-answer-icon a {
    display: inline-block;
    color: #a7753a;
    font-size: 13px;
    padding: 0 3px 0 4px;
}
.bt-area-answer-icon .modify span {
    background: url(/resources/img/ico_sub.png) no-repeat 0 -260px;
}
.bt-area-answer-icon .del span {
    background: url(/resources/img/ico_sub.png) no-repeat 0 -290px;
}
.bt-area-answer-icon a span {
    display: inline-block;
    width: 20px;
    height: 20px;
    line-height: 20px;
    text-indent: -9999em;
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
					<div class="cont-area">	


		<h2 class="tit-h2 type mopad">Q&amp;A</h2>
		<div class="table-scroll-no">
			<table class="table-row">
				<caption>Q&amp;A 상세내용 : 처리현황, 닉네임, 제목, 내용에 대한 정보</caption>
				<colgroup>
					<col style="width:25%;">
					<col style="width:75%;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">처리현황</th>
						<td><span class="ing">${qna.qcheck}</span></td>
					</tr>
					<tr>
						<th scope="row">작성일</th>
						<fmt:formatDate value="${qna.qdateTime}" var="time"
							pattern="MM/dd HH:mm" />
						<td class="board-date">${time}</td>
					</tr>
					<c:if test="${qna.acontent ne null}">
						<tr>
							<th scope="row">답변완료일</th>
							<fmt:formatDate value="${qna.adateTime}" var="time"
								pattern="MM/dd HH:mm" />
							<td class="board-date">${time}</td>
						</tr>
					</c:if>
					<tr>
						<th scope="row">닉네임</th>
						<td>${qna.nickname}</td>
					</tr>
					<tr>
						<th scope="row">제목</th>
						<td>${qna.qtitle}</td>
					</tr>					
					<tr>
						<th scope="row">내용</th>
						<td><div><p>${qna.qcontent}<br></p></div></td>
					</tr>
				</tbody>
			</table>
			<!-- //table-row -->
		</div>
		<!-- // table-scroll-no -->

		
 			<div class="answer-box">
				<strong class="tit">문의주신 내역에 대한 답변입니다.</strong>
				
					
					<c:if test="${qna.acontent eq null}">
						<div class="answer no-answer">
							죄송합니다. 운영자의 답변이 아직 기재되지 않았습니다.<br>
							24시간이 경과한 이후에도 답변이 없다면, 다시 문의하여 주시기 바랍니다. 빠른 시간안에 답변을 드리겠습니다.
						</div>
					</c:if>
					
					<c:if test="${qna.acontent ne null }">
					<div class="answer answer">
						${qna.acontent}
						
						
					</div>
						 <div class="bt-area-answer">
						<span class="bt-area-answer-icon">
							<c:if test="${qna.qcheck eq '답변완료'}">
								<a href="/admin/qna/answer/update?qno=${qna.qno}" class="modify"><span>수정</span></a>
								<a href="javascript:void(0)" onclick="delAnswer('${qna.ano}')" class="del"><span>삭제</span></a>
							</c:if>
						</span> 
						</div>	
					</c:if>							
			</div>
		
		
		<!-- // answer-box -->

		<div class="bt-area-answer">
		
		<c:if test="${qna.acontent eq null }">
			<a href="/admin/qna/answer/write?qno=${qna.qno}"class="btn-s fantasy anwer-write-btn">답변</a>
		</c:if>
		
			<span>
				<a href="/admin/qna" class="btn-s">목록</a>
				
				<c:if test="${qna.acontent eq null}">
					<a href="javascript:void(0)" onclick="delQuestion('${qna.qno}')" class="btn-s fantasy">삭제</a>
				</c:if>
				<c:if test="${qna.acontent ne null}">
					<a href="javascript:void(0)" onclick="delQna('${qna.qno}', '${qna.ano}')" class="btn-s fantasy">삭제</a>
				</c:if>				
				
			</span> 
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

</body>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
 oAppRef: oEditors,
 elPlaceHolder: "bcontent",
 sSkinURI: "/resources/se2/SmartEditor2Skin.html",
 fCreator: "createSEditor2"
});

</script>
<script>
function delAnswer(ano) {
	/* sweetAlert */
	swal({
		  text: "정말삭제하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
		    swal("성공적으로 삭제되었습니다.", {
		      icon: "success",
		    }).then(function(){
			  location.href = '/admin/answer/delete?ano=${qna.ano}';
		    });
		  } else {
		    swal("삭제가 취소되었습니다.");
		  }
	});
}
function delQna(qno, ano) {
	/* sweetAlert */
	swal({
		  text: "정말삭제하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
		    swal("성공적으로 삭제되었습니다.", {
		      icon: "success",
		    }).then(function(){
			  location.href = '/admin/qna/delete?qno=${qna.qno}&ano=${qna.ano}';
		    });
		  } else {
		    swal("삭제가 취소되었습니다.");
		  }
	});
}


function delQuestion(qno) {
	/* sweetAlert */
	swal({
		  text: "정말삭제하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
		    swal("성공적으로 삭제되었습니다.", {
		      icon: "success",
		    }).then(function(){
			  location.href = '/admin/qna/delete?qno=${qna.qno}';
		    });
		  } else {
		    swal("삭제가 취소되었습니다.");
		  }
	});
}

</script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js" crossorigin="anonymous">
    </script>
    <script src="/resources/js/scripts.js"></script>
    
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="/resources/js/chart-area-demo.js"></script>
    <script src="/resources/js/chart-bar-demo.js"></script>
    <script src="/resources/js/datatables-demo.js"></script>    
    
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>

</html>