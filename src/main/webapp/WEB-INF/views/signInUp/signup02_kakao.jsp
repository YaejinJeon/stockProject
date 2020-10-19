<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>카카오톡으로 회원가입</title>
<script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link href="/resources/css/signup01_02.css" rel="stylesheet">
<script src="//image.paxnet.co.kr/rpan/common/js/validation/validation.custom.js"></script>
<script src="//image.paxnet.co.kr/rpan/common/js/validation/validation.methods.js"></script>
<script src="//image.paxnet.co.kr/rpan/common/js/validation/validation.messages.js"></script>
<script>
function numkeyCheck(e) { var keyValue = event.keyCode; if( ((keyValue >= 48) && (keyValue <= 57)) ) return true; else return false; }
function spaceCheck(e) { var keyValue = event.keyCode; if( (keyValue > 31) && (keyValue < 33) ) return false; else return true; }
window.onkeydown = function() { 
	var kcode = event.keyCode; 
	if(kcode == 116 || event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82) ) event.returnValue = false;
}
</script>
<style>.removeButton{display: none;}</style>
</head>
<body>
	<div class="wrap">
<%@include file="../mainheader.jsp" %>
	<div class="containerNew"> 
			<!-- contents -->
			<div class="contents member" id="contents">
				<div class="cont-area">  
					<div class="step-mem">
						<ul>
							<li><div><span><i>Step1</i></span><em>약관동의</em></div></li> 
							<li class="selected"><div><span><i>Step2</i></span><em>기본정보입력</em></div></li>
							<li><div><span><i>Step3</i></span><em>가입완료</em></div></li>
						</ul>
					</div> 
					<div class="pad-area men-step">
						<h1>기본정보입력</h1>
						<form action="/signUp/kakao" name="form" id="form" method="POST">
							<fieldset>
								<legend>기본정보입력</legend>  
								<ul>
										<span class="input-style-mail">
											<label for="inputCemail"></label>
											<input placeholder="인증받으실 이메일을 입력해주세요" value="${kakaoID}" type="text" id="inputEmail" name="id"  style="display: none;">
										</span>
									<li>
										<span class="input-style-nick">
											<label for="inputNickname"></label>
											<input placeholder="닉네임을 입력해주세요." type="text"  name="nickname" id="inputNickname" maxlength="24" onKeyPress="return spaceCheck(event)">
										</span>  
										<div id="nickNameResult"></div>
										<span class="byte"><b id="maxText">0</b>/12byte</span>
										<button type="button" class="btn-s gray" id="nickCheck">중복확인</button>
										<button type="button" class="btn-s fantasy removeButton" id="nickCheckAgain">다시입력</button>
									</li> 
									<li>
										<span class="input-style-nick">
											<label for="inputFriend"></label>
											<input placeholder="추천인을 입력해주세요" type="text" name="friend" id="inputFriend"  maxlength="24" onKeyPress="return spaceCheck(event)">
										</span>  
										<div id="friendResult"></div>
										<span class="byte"><b id="maxText1">0</b>/12byte</span>
										<button type="button" class="btn-s gray" id="friendCheck">추천하기</button>
										<button type="button" class="btn-s fantasy removeButton" id="friendCheckAgain">다시입력</button>
									</li> 
								</ul>
								<ul>
									<li>
										<span class="input-style-address">
											<input type="text" name="address" id="inputAddress" class="_onlyNumber" placeholder="우편번호"  required="true" readonly>
										</span>
										<button type="button" class="btn-s" onclick="goPopup();">검색</button>
									</li>
									<li>
										<span class="input-style-phone">
											<label for="inputPhone"></label>
											<input placeholder="휴대폰번호('-'없이)" type="text" name="tel" id="inputPhone" class="_onlyNumber" maxlength="11" onKeyPress="return numkeyCheck(event)">
											<!-- <button type="button" class="delete">삭제</button> -->
										</span>
										<div id=telResult></div>
										<button type="button" class="btn-s" id="telCheck">인증받기</button>
							<!-- 추가 -->	<button type="button" class="btn-s fantasy removeButton" id="telCheckAgain">다시입력</button>
									</li>
									<li id="_liPhoneNum" style="display: none;">
										<span class="input-style-certif">
											<label for="inputCtel"></label>
											<input placeholder="인증번호를 입력해주세요" type="text" name="cTel" id="inputCtel" onKeyPress="return numkeyCheck(event)">
										</span>
										<div id=cTelResult></div>
										<button type="button" class="btn-s" id="cTelCheck">인증확인</button>
									</li>
								</ul> 
								<ul>
									<li>
										<span class="radio-style-dormant">거래내역 공개 설정</span>
							               <div class="ask-form">
							               	  <p class="guide-text"><span>다른 사용자에게 보유 자산 및 수익률과 거래내역을 공개 하시겠습니까?</span></p>
							                  <div class="dormant-radio">
							                  <input type="radio" name="showEsetSetting" id="ask-radio-1"  value="1">
							                  <label  id="ask-radio-1-answer" for="ask-radio-1">예</label>
							                  <input type="radio" name="showEsetSetting" id="ask-radio-2"  value="0" checked="checked">
							                  <label  for="ask-radio-2">아니오</label>
							                  </div>
							               </div>															
									</li> 							
								</ul>
							</fieldset>
							<div class="bt-area"> 
								<button type="submit" class="btn-b fantasy" data-text-content="true" id="submit">가입하기</button> 
								<button type="button" class="btn-b" onclick="location.href='/'">취소</button>
							</div>
						</form>
						<dl class="guide-text03">
							<dt>이용안내</dt>
							<dd>
								<ul>
									<li>입력된 내용은 내정보 관리에서 변경 할 수 있습니다.</li>
									<li>허위정보는 본인확인에 대한 도움을 드릴 수 없습니다.</li>
								</ul>
							</dd>
						</dl> 
					
					</div> 
				</div>
			</div>
		</div>
			<%@include file="../mainfooter2.jsp" %>
	</div>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script>

	
	function goPopup(){
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		
		// 가운데 띄우기
		var width = "570"; 
		var height = "420"; 
		var top = (window.screen.height-height)/2; 
		var left = (window.screen.width-width)/2; 
		var url = "/signUpPage/jusoPopup"; 
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width="+width+",height="+height+",top="+top+",left="+left; 
		var pop = window.open(url , "pop", status);
		
		// 왼쪽 상단에 띄우기		
		//var pop = window.open("/signUpPage/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	    
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	//}
	/** API 서비스 제공항목 확대 (2017.02) **/
	function jusoCallBack(roadFullAddr){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		console.log(roadFullAddr);
		document.form.inputAddress.value = roadFullAddr;
	}


	
	$(document).ready(function(e){
		$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
		textLenCheck("inputNickname","닉네임",{max:12,currentLenId:"maxText"});
		textLenCheck("inputFriend","추천인",{max:12,currentLenId:"maxText1"});
		var checkflag = 0;
	
		$("#submit").on("click", function(){
			if($("#inputNickname").val()==""){
				swal({text:"닉네임을 입력해주세요.", icon:"error"})
				$("#inputNickname").focus();
				return false;
			}
			if($("#inputPhone").val()==""){
				swal({text:"휴대폰번호를 입력해주세요.", icon:"error"})
				$("#inputPhone").focus();
				return false;
			}
			if($("#inputCtel").val()==""){
				swal({text:"휴대폰번호 인증번호를 입력해주세요.", icon:"error"})
				$("#inputCtel").focus();
				return false;
			}
			
		});
		// 휴대폰 중복확인
		$('#telCheck').on('click', function(){ 
			$.ajax({ 
				type: 'GET', 
				url: '${pageContext.request.contextPath}/telCheck', 
				data: { "tel" : $('#inputPhone').val() }, 
				success: function(data){ 
					if(data == 0 && $.trim($('#inputPhone').val()) != ''){
						$("#telCheck").toggleClass("removeButton");/* 추가 */
						$("#telCheckAgain").toggleClass("removeButton");/* 추가 */
						$("#_liPhoneNum").css('display',"block");
						idx= true;
						$('#inputPhone').attr("readonly", true);
						
 						var html="<p id='err_cust_id' class='ok-text'>문자메세지를 확인해주세요.</p>"; 
						$('#telResult').empty();
						$('#telResult').append(html);
						$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
					}else if(data == 2 || $.trim($('#inputPhone').val()) == ""){
						var html="<p id='cust_id-error' class='error-text'>11자리를 입력해주세요.[ ex)01012345678 ]</td></tr>";
						$('#telResult').empty();
						$('#telResult').append(html);
						document.getElementById("inputPhone").value="";
						$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
					}
					else{
						var html="<p id='cust_id-error' class='error-text'>이미 등록된 번호입니다.</p>";
						$('#telResult').empty();
						$('#telResult').append(html);
						document.getElementById("inputPhone").value="";
						$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
					}
				},
				error: function(){
					alert("서버에러");
				}
				
			});  
		});
	
		//휴대폰 실수로 다른거 입력시 수정버튼 활성화
		$("#telCheckAgain").on("click", function(){
			document.getElementById("inputPhone").value="";
			$('#inputPhone').attr("readonly", false);
			$("#telCheck").toggleClass("removeButton");
			$("#telCheckAgain").toggleClass("removeButton");
			$('#telResult').empty();
			$('#cTelResult').empty();
			document.getElementById("inputCtel").value="";
			$("#inputCtel").removeAttr("disabled");$("#inputCtel").removeAttr("style");$("#inputCtel").removeAttr("readonly");
			$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
		})
			
		// 휴대폰 인증번호확인
		$('#cTelCheck').on('click', function(){ 
			$.ajax({ 
				type: 'GET', 
				url: '${pageContext.request.contextPath}/cTelCheck', 
				data: { "cTel" : $('#inputCtel').val() }, 
				success: function(data){ 
					if(data == 0 && $.trim($('#inputCtel').val()) != ''){
						idx= true;
						$('#inputCtel').attr("readonly", true);
						
 						var html="<p id='err_cust_id' class='ok-text'>인증성공</p>"; 
						$('#cTelResult').empty();
						$('#cTelResult').append(html);
						$("#submit").removeAttr("disabled");$("#submit").removeAttr("style");
					}else{
						var html="<p id='cust_id-error' class='error-text'>인증실패(인증번호를 확인해주세요)</p>";
						$('#cTelResult').empty();
						$('#cTelResult').append(html);
						document.getElementById("inputCtel").value="";
						$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
					}
				},
				error: function(){
					alert("서버에러");
				}
				
			});  
		});  		
		
		$('#nickCheck').on('click', function(){ 
			$.ajax({ 
				type: 'GET', 
				url: '${pageContext.request.contextPath}/nickCheck', 
				data: { "nickname" : $('#inputNickname').val() }, 
				success: function(data){ 
					if($.trim($('#inputNickname').val()) == ""){
						var html="<p id='cust_id-error' class='error-text'>공백은 불가능합니다(필수 입력사항은 아닙니다).</p>";
						
						$('#nickNameResult').empty();
						$('#nickNameResult').append(html);
						document.getElementById("inputNickname").value="";
						// 중복체크 실패 시 회원가입 버튼 비활성화
						$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
					}else if(data == 0 && $.trim($('#inputNickname').val()) != ""){
						$("#nickCheck").toggleClass("removeButton");/* 추가 */
						$("#nickCheckAgain").toggleClass("removeButton");/* 추가 */
						idx= true;
						$('#inputNickname').attr("readonly", true);
 						var html="<p id='err_cust_id' class='ok-text'>사용 가능합니다.</p>"; 
						$('#nickNameResult').empty();
						$('#nickNameResult').append(html);
						$("#submit").removeAttr("disabled");$("#submit").removeAttr("style");
					}else if(data == 2 && $.trim($('#inputNickname').val()) != ""){
					}else{
						var html="<p id='cust_id-error' class='error-text'>중복된 닉네임입니다.</p>";
						$('#nickNameResult').empty();
						$('#nickNameResult').append(html);
						document.getElementById("inputNickname").value="";
						// 중복체크 실패 시 회원가입 버튼 비활성화
						$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
					}
				},
				error: function(){
					alert("서버에러");
				}
				
			});  
		});  
		$("#nickCheckAgain").on("click", function(){
			document.getElementById("inputNickname").value="";
			$('#inputNickname').attr("readonly", false);
			$("#nickCheck").toggleClass("removeButton");
			$("#nickCheckAgain").toggleClass("removeButton");
			$('#nickNameResult').empty();
			$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
		})
		
		
	
		$('#friendCheck').on('click', function(){ 
			$.ajax({ 
				type: 'GET', 
				url: '${pageContext.request.contextPath}/friendCheck', 
				data: { "nickname" : $('#inputFriend').val() }, 
				success: function(data){
					if($.trim($('#inputFriend').val()) == ""){
						var html="<p id='cust_id-error' class='error-text'>공백은 불가능합니다.</p>";
						$('#friendResult').empty();
						$('#friendResult').append(html);
						document.getElementById("inputFriend").value="";
					}else if(data == 0 && $.trim($('#inputFriend').val()) != ''){
						var html="<p id='cust_id-error' class='error-text'>존재하지않은 닉네임입니다.</p>";
						$('#friendResult').empty();
						$('#friendResult').append(html);
						document.getElementById("inputFriend").value="";
						/* $("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%"); */
					}else{
						idx= true;
						$('#inputFriend').attr("readonly", true);
						$("#friendCheck").toggleClass("removeButton");/* 추가  */
						$("#friendCheckAgain").toggleClass("removeButton");/* 추가  */
						var html="<p id='err_cust_id' class='ok-text'>사용 가능합니다.</p>"; 
						$('#friendResult').empty();
						$('#friendResult').append(html);
						$("#submit").removeAttr("disabled");$("#submit").removeAttr("style");
					}
				},
				error: function(){
					alert("서버에러");
				}
			});  
		});
		
		$("#friendCheckAgain").on("click", function(){
			document.getElementById("inputFriend").value="";
			$('#inputFriend').attr("readonly", false);
			$("#friendCheck").toggleClass("removeButton");
			$("#friendCheckAgain").toggleClass("removeButton");
			$('#friendResult').empty();
			$("#submit").attr("disabled", "disabled");$("#submit").attr("style", "opacity:20%");
		})
	});
	
	$(document).on('click', 'button.delete', function (e) {
		var _this = $(this);
		var ipt = _this.parent().find('input');
		ipt.val('').focus();
		_this.hide();
		ipt.attr("readonly", false);
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

</script>
</body>
</html>