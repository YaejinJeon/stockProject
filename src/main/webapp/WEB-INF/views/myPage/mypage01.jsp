<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link href="/resources/css/mypage01.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/sidebar.css">
<script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
<script>
function notLocal(){swal({text:"접속하신 해당 홈페이지에서 변경가능합니다.", icon:"warning"})}
</script>
<style>
A:link, A:visited, A:hover, A:active{cursor: pointer;}
</style>
</head>
<body>
	<%@include file="../mainheader.jsp"%>
	<!-- article start -->
	<div class="containerNew">
		<!-- contents -->
		<div class="contents member" id="contents">
			<div class="row">
				<div class="col-md-2">
					<div class="sidebar sticky" id="cssmenu" style="position: relative;">
						<ul>
							<li class="selected mid"><a href="/myPage01"><span>내 정보 관리</span></a></li>
							<c:set var="socialId" value="${loginUser.id}"/>
									<c:choose>
										<c:when test="${fn:contains(socialId,'_')}">
										</c:when>
										<c:otherwise>
							<li class="mid"><a href="/mypageUpdatePassword"><span>비밀번호 재설정</span></a></li>
										</c:otherwise>
									</c:choose>
							<li class="mid"><a href="/myPage02"><span>계좌정보</span></a></li>
							<li class="mid"><a href="/myPage03"><span>작성 글 | 댓글</span></a></li>
							<li><a href="/myPage04"><span>알림</span></a></li>
						</ul>
					</div>				
				</div>
				

				<div class="col-md-10">
					<div class="cont-area">
						<div class="drop-nav">
							<h1 class="tit-h1 line">내 정보 관리</h1>
						</div>
						<div class="m-drop-nav">
							<h1 class="m-drop-tit-title line" style="cursor: pointer;">내 정보 관리 <i class="fas fa-angle-down"></i></h1>
						</div>
						<div class="m-drop-down">
							<h1 class="m-drop-tit-body first line" style="cursor: pointer;">
								<a href="/myPage01">내 정보 관리</a>
							</h1>
							<h1 class="m-drop-tit-body line" style="cursor: pointer;">
								<a href="/mypageUpdatePassword">비밀번호 재설정</a>
							</h1>							
							<h1 class="m-drop-tit-body line" style="cursor: pointer;">
								<a href="/myPage02">계좌정보</a>
							</h1>
							<h1 class="m-drop-tit-body line" style="cursor: pointer;">
								<a href="/myPage03">작성 글 | 댓글</a>
							</h1>
							<h1 class="m-drop-tit-body line" style="cursor: pointer;">
								<a href="/myPage04">알림</a>
							</h1>
						</div>
							<div class="modify-mem">
						<form action="/updateUser" name="frm" id="frm" method="POST" novalidate>
								<input type="hidden" name="ar_concern" id="ar_concern" value="">
								<input type="hidden" name="sns_cust" id="sns_cust" value="">
								<input type="hidden" name="sns_id" id="sns_id" value="">
								<input type="hidden" name="naver_link" id="naver_link" value="">
								<input type="hidden" name="facebook_link" id="facebook_link" value="">
								<input type="hidden" name="google_link" id="google_link" value="">
								<input type="hidden" name="kakao_link" id="kakao_link" value="">
								<input type="hidden" name="linkUrl" value="">
								<h2 class="tit-h2">기본정보</h2>
								<div class="form-table">
									<table>
										<caption>기본정보 : 아이디,성명,생년월일,이메일,휴대폰인증,필명 정보 입력 및 선택</caption>
										<tbody>
												<tr>
													<th scope="row"><label for="userEmail">이메일</label></th>
													<td>
													<span class="input-style-case02"> 
														<input type="text" id="userEmail" value="${loginUser.id}" readonly>
															<button type="button" class="delete">삭제</button>
													</span></td>
												</tr>
												<tr>
													<th scope="row"><label for="cc-name">휴대전화</label></th>
													<td>
														<span class="input-style-case02">
														<input type="text" id="mobile_no" name="mobile_no" placeholder="휴대폰 번호는 대시(-)없이 숫자만 입력해주세요."
															   value="${loginUser.tel}" class="_onlyNumber" maxlength="11" readonly>
														<button type="button" class="delete">삭제</button>
													</span>
														<div class="text-wrap">
															<p class="td-text color-black">이메일과 휴대폰은 아이디/비밀번호찾기시 본인확인을 위해 사용됩니다.</p>
															<p class="td-text">본인의 정보가 타인에게 전달되지 않도록 정확하게 입력 해주시기 바랍니다.</p>
														</div>
													</td>
												</tr>
												<tr>
													<th scope="row"><label for="userNickname">닉네임</label></th>
													<td>
														<div class="sell-wrap">
															<span class="input-style-nick"> <input type="text"
																id="userNickname" placeholder="닉네임을 입력하세요"
																title="닉네임을 입력하세요" name="nickname"
																value="${loginUser.nickname}">
																<button type="button" class="delete">삭제</button> <span
																class="byte"><b id="maxText">12</b>/12byte</span>
															</span>
															<div id="nickNameResult"></div>
															<button type="button"  class="btn-t gray" id="nickCheck">중복확인</button>
														</div>
													</td>
												</tr>
										</tbody>
									</table>
								</div>

								<h2 class="tit-h2">선택정보</h2>
								<div class="form-table">
									<table>
										<caption>선택정보 : 관심분야,지역,유선전화,주소 정보입력</caption>
										<tbody>
											<tr>
												<th scope="row"><label for="addr_post_no">주소</label></th>
												<td class="address">
													<p class="tit-mob">주소</p>
													<div class="sell-wrap">
														<span class="input-style-address"> 
															<input type="text" id="addr_post_no" name="address"
																value="${loginUser.address}" placeholder="우편번호" readonly>
															<button type="button" class="delete">삭제</button>
														</span>
														<button type="button" class="btn-t gray" onclick="goPopup();">주소번경</button>
															
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="ask-form">
								<p class="text-muted">다른 사용자에게 보유 자산 및 수익률과 거래내역을 노출 하시겠습니까?</p>
									<div class="custom-control custom-radio">
										<input type="radio" name="showEsetSetting" id="ask-radio-1" class="custom-control-input" value="1">
										<label class="custom-control-label" id="ask-radio-1-answer" for="ask-radio-1">예</label>
									</div>
									<div class="custom-control custom-radio">
										<input type="radio" name="showEsetSetting" id="ask-radio-2"class="custom-control-input" value="0">
										<label class="custom-control-label" for="ask-radio-2">아니오</label>
									</div>
								
								
							</div>
							<div class="bt-area">
								<button class="btn-b fantasy" type="button" id="submit">정보수정</button>
							</div>
						</form>
						</div>
							<div class="find-info1">
								<span class="txt">판타지스탁 서비스 이용을 더 이상 원치 않으시면 클릭해주세요.</span> <span
									class="bt-area"> 
									<a href="/withdrawal/check?id=${loginUser.id}" class="btn-s bodrb">회원탈퇴</a>
								</span>
							</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="../mainfooter2.jsp"%>

	
</body>
<script>window.jQuery || document.write('<script src="/docs/4.4/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	//정보공개만으로도 수정되게
	if (${loginUser.showEsetSetting} === 0){
		if ($("#ask-radio-1").click(function(){
			$("#submit").removeAttr("disabled");$("#submit").removeAttr("style");
		}));
		}else if (${loginUser.showEsetSetting} === 1){
		if ($("#ask-radio-2").click(function(){
			$("#submit").removeAttr("disabled");$("#submit").removeAttr("style");
		}));
	}

    $(document).ready(function () {
    	$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
    	textLenCheck("userNickname","닉네임",{max:12,currentLenId:"maxText"});
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
    function textLenCheck(id,label,condObj){

		var trueYn = true;
		var id = "#"+id;
		var idObj = $(id);

		idObj.keyup(function(event){
			var keyCode = event.keyCode;
			if(keyCode != 38 && keyCode != 37 && keyCode != 39 &&keyCode != 40 )

			if(condObj.max != undefined && getTextLength(idObj.val()) > condObj.max){
				swal({text:label + "은 " + condObj.max + "byte 이하만가능합니다.", icon:"error"});
				var cnt_byte = 0;
				var sub_cnt = 0;
				var chk_letter = "";
				for (var i=0; i<idObj.val().length; i++)
				{
					chk_letter = idObj.val().charAt(i);
					if (escape(chk_letter).length > 4) {
						cnt_byte += 2;
					}else{
						cnt_byte++;
					}
					if (cnt_byte <= condObj.max) {
						sub_cnt = i + 1;
					}
				}
				idObj.val(idObj.val().substr(0, sub_cnt));
				idObj.focus();
				return ;
			}
			$("#"+condObj.currentLenId).html(getTextLength(idObj.val()));
		});
		$("#"+condObj.currentLenId).html(getTextLength(idObj.val()));
	}
	/**
	 * 한글포함 문자열 길이를 구한다
	 */
	function getTextLength(str) {
		var str = str+"";
		var len = 0;
		for (var i = 0; i < str.length; i++) {
			if (escape(str.charAt(i)).length == 6) {
				len++;
			}
			len++;
		}
		return len;
	}
    
    
    function submitDoit(){
    	$.ajax({
	        type:'POST',
	        url : "${pageContext.request.contextPath}/updateUser",
	        data:{ "nickname" : $('#userNickname').val(), 
	        		"address" : $('#addr_post_no').val(),
	        		"showEsetSetting" : $('input[name="showEsetSetting"]:checked').val() }
	        ,
	        success : function(data){
	        	console.log(data)
	        },
	        error:function(){
				alert("서버에러");
	       }
    	});
    }
    $('#submit').on('click', function(){
    	swal({
			  text: "정말 수정하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willUpdate) => {
			  if (willUpdate) {
			    swal("성공적으로 수정되었습니다.", {
			      icon: "success",
			    }).then(function(){
			    	submitDoit();
			    });
			  } else {
			    swal("수정이 취소되었습니다.");
			  }		        		
  		})
    });
    
    
    $('#nickCheck').on('click', function(){
    	
		$.ajax({ 
			type: 'GET', 
			url: '${pageContext.request.contextPath}/nickCheck', 
			data: { "nickname" : $('#userNickname').val() }, 
			success: function(data){
				console.log(data)
				if($.trim($('#userNickname').val()) == ""){
					var html="<p id='cust_id-error' class='error-text'>공백은 불가능합니다.</p>";
					$('#nickNameResult').empty();
					$('#nickNameResult').append(html);
					document.getElementById("userNickname").value="";
					$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
				}else if(data == 0 && $.trim($('#userNickname').val()) != ""){
					idx= true;
					var html="<p id='err_cust_id' class='ok-text'>사용 가능합니다.</p>"; 
					$('#nickNameResult').empty();
					$('#nickNameResult').append(html);
					$("#submit").removeAttr("disabled");$("#submit").removeAttr("style");
				}else if(data == 2 && $.trim($('#userNickname').val()) != ""){
					$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
					idx= true;
					var html="<p id='err_cust_id' class='ok-text'>현재 닉네임입니다.</p>"; 
					$('#nickNameResult').empty();
					$('#nickNameResult').append(html);
					document.getElementById("userNickname").value=${loginUser.nickname};
				}
				else{
					var html="<p id='cust_id-error' class='error-text'>중복된 닉네임입니다.</p>";
					$('#nickNameResult').empty();
					$('#nickNameResult').append(html);
					document.getElementById("userNickname").value="";
					$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
				}
			},
			error: function(){
				alert("서버에러");
			}
			
		});  
	});
    
    function goPopup() {
        // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
        var width = "570";
        var height = "420";
        var top = (window.screen.height - height) / 2;
        var left = (window.screen.width - width) / 2;
        var url = "/signUpPage/jusoPopup";
        var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=" + width + ",height=" + height + ",top=" + top + ",left=" + left;
        var pop = window.open(url, "pop", status);
    }
    //}
    /** API 서비스 제공항목 확대 (2017.02) **/
    function notLocal() {
        swal({ text: "접속하신 해당 홈페이지에서 변경가능합니다.", icon: "warning" })
    }
    function jusoCallBack(roadFullAddr) {
        // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
        console.log(roadFullAddr);
        document.getElementById("addr_post_no").value = null;
        document.getElementById("addr_post_no").value = roadFullAddr;
        $("#submit").removeAttr("disabled");$("#submit").removeAttr("style");
    }
    
    if (${ loginUser.showEsetSetting } === 0)
    $("#ask-radio-2").prop("checked", true);
	else
    $("#ask-radio-1").prop("checked", true);
</script>

</html>