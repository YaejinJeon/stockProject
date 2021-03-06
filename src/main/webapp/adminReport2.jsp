 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
  <meta name="generator" content="Jekyll v4.0.1">
  <title>관리자페이지</title>




    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
   <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/dashboard/">
<script src="http://code.jquery.com/jquery-latest.min.js" ></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<!-- 데이터테이블스타일 -->
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
 
<!--  스타일-->
  <link href="/resources/css/datatable.css" rel="stylesheet" />
        
<!-- 통합관리자s -->
 <link rel="stylesheet" href="/resources/css/admin.css">


  <style type="text/css">

  </style>

</head>

<body class="sb-nav-fixed">



    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <!--    로고들어감 -->
        			<a href="/mainPage" class="navbar-logo">
			<img class="" id="logo"
				src="/resources/img/finalogo.png">
				</a> 
        <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i
                class="fas fa-bars"></i></button>




        <!-- Navbar 모바일 미디어 드롭메뉴- 사람아이콘 누르면 -->
        <ul class="navbar-nav ml-auto ml-md-0">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="/mainPage">로그아웃</a>
                </div>
            </li>
        </ul>



    </nav>
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark"">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <div class="sb-sidenav-menu-heading">메인</div>
                        <a class="nav-link" href="/mainPage">
                            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
             			               대시보드
                        </a>
                        <div class="sb-sidenav-menu-heading">사이트관리</div>
                        <a class="nav-link" href="/adminQna">
                            <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
         				                   문의
                        </a>
                        <a class="nav-link" href="/adminReport">
                            <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                         		   신고
                        </a>
                    </div>
                </div>
                
                
             <!--    페이지 하단에 ~로 로그인 하셨습니다 -->
                <div class="sb-sidenav-footer">
                    <div class="small">Logged in as:</div>
                    
                </div>
                
                
                
            </nav>
        </div>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">

						<div class="container-box">
 							<h4 class="mt-4">신고</h4>
                                <table class="adminTable" width="100%" cellspacing="0">
                                    <!-- 테이블 데이터 헤더 -->
                                    <thead>
                                        <tr>
                                            <th class="class center" style="width: 8%;">종류</th>
                                            <th class="status center"style="width: 8%">처리현황</th>
                                            <th class="title tleft" style="width: 23%">제목</th>
                                            <th class="content tleft" style="width: 30%">내용</th>                                           
                                            <th class="writer tleft" style="width: 8%">아이디</th>
                                            <th class="date center" style="width: 8%">일시</th>
                                        </tr>
                                    </thead>
                                    <!--  데이터값 들어가는 곳 -->
                                    <tbody>
                                       <tr>
                                            <td class="tClass center">종류</td>
                                            <td class="tStatus center">처리현황</td>
                                            <td class="tTitle tleft"> <a href="">메시지 요청uut용ij656635하지 않습니다.ioiuoiuouioghfhfghfguio</a></td>
                                            <td class="tContent tleft"> <a href="">소리나게 하다, 꽝 치다, 찰싹 때리다, (술병 등을)따서 마koljklhkyhjghj다, 설명하다</a></td>
                                            <td class="tWriter tleft">아이디</td>
                                            <td class="tDate center">05/22/2022</td>
                                        </tr>
                                        
                                        
                                       <tr>
                                            <td class="tClass center">종류</td>
                                            <td class="tStatus center">처리현황</td>
                                            <td class="tTitle tleft"> <a href="">메시지 요청된 tyuioiutryrtyrtytryrtoiu6534654ouiouio</a></td>
                                            <td class="tContent tleft"> <a href="">소리나게 하다, 꽝 치다, 찰싹 때리다, (술병 등을)따서 마koljklhkyhjghj다, 설명하다</a></td>
                                            <td class="tWriter tleft">아이디</td>
                                            <td class="tDate center">05/22/2022</td>
                                        </tr>
                                        

                                    </tbody>
                                </table>
                                </div>





                </div>
            </main>
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
    
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="/resources/js/chart-area-demo.js"></script>
    <script src="/resources/js/chart-bar-demo.js"></script>
    <script src="/resources/js/datatables-demo.js"></script>    
    
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>

</body>

</html>