<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<script>
<c:set var="socialId" value="${loginUser.id}"/>
<c:choose>
   <c:when test="${fn:contains(socialId,'_naver_')}">
   window.onload = function(){
      swal({
           text: "정말 탈퇴하시겠습니까?",
           icon: "warning",
           buttons: true,
           dangerMode: true,
         }).then((willDelete) => {
            if(willDelete){
               swal({text:'성공적으로 탈퇴되었습니다. 이용해주셔서감사합니다.', 
                    icon:'success',
                   }).then(function(){
                        $.ajax({
                           type : 'GET',
                           url : "${pageContext.request.contextPath}/withdrawalNaverDecision?id=${loginUser.id}",
                           success : function(data) {
                                location.href=data
                                location.href="/signInPage"
                              }
                        })
                      });
            }else{
               swal({
                  text:'회원탈퇴가 취소되었습니다.', 
                  icon:'error',
                  }).then(function(){
                     location.href="/myPage01"
                  });
                  
            }
        });
   }
   </c:when>
   <c:otherwise>
      window.onload = function(){
      swal({
           text: "정말 탈퇴하시겠습니까?",
           icon: "warning",
           buttons: true,
           dangerMode: true,
         }).then((willDelete) => {
            if(willDelete){
               swal({text:'성공적으로 탈퇴되었습니다. 이용해주셔서감사합니다.', 
                    icon:'success',
                   }).then(function(){
                        $.ajax({
                           type : 'GET',
                           url : "${pageContext.request.contextPath}/withdrawalKakaoDecision?id=${loginUser.id}",
                           success : function(data) {}
                        })
                        location.href="/signInPage"
                           self.close()
                      });
               
            }else{
               swal({
                  text:'회원탈퇴가 취소되었습니다.', 
                  icon:'error',
                  }).then(function(){
                     location.href="/myPage01"
                  });
                  
            }
        });
   }
   </c:otherwise>
</c:choose>
</script>
</body>
</html>