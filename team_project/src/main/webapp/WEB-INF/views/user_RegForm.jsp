<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>


<h1>회원가입</h1>
<hr>
<section>
<h3>√ 항목은 필수! 입력 항목입니다.</h3>
<form name="frm" action="userRegForm.do" method="post">
   <table border="1">
      <tr>
         <th>아이디 √</th>
         <td><input type="text" name="user_id" placeholder="공백 없는 영문/숫자 포함 6~20자" min="6" maxlength="20">
         <input type="button" value="중복확인" onclick="idCheck()">
         <div id="idOk"></div>
         </td>
      </tr>
      <tr>
         <th>비밀번호  √</th>
         <td><input type="password" name="user_pw" placeholder="공백 없는 영문/숫자 포함 6~20자" min="6" maxlength="20"></td>
      </tr>
      <tr>
         <th>비밀번호 확인 √</th>
         <td><input type="password" name="user_pw_check" >
         <input type="button" value="확인하기" onclick="return pwOk()">
         <div id="pw_check"></div>
         </td>
      </tr>
      <tr>
         <th>이름 √</th>
         <td><input type="text" name="user_name"></td>
      </tr>
      <tr>
         <th>이메일 √</th>
         <td><input type="text" name="user_email">@<input type="text" name="user_email2" >
         <select name="user_email3" id="user_emails" onchange="changeEmail()">
         <option value="0">직접입력</option>
         <option value="naver.com">naver.com</option>
         <option value="nate.com">nate.com</option>
         <option value="gmail.com">gmail.com</option>
         </select>
         <div id="email_susin"><p><input type="checkbox" name="user_email_check" value="Y">
         정보메일을 수신하겠습니다.</p></div>
         <p style="font-size: small;">"이메일 수신에 동의하시면 여러가지 할인혜택과 각종 이벤트 정보를 받아보실 수 있습니다."</p>
         <p style="font-size: small;">"회원거입관련, 주문배송관련 등의 메일은 수신동의와 상관없이 모든 회원에게 발송됩니다."</p>
         </td>
      </tr>
      <tr>
         <th>전화번호 √</th>
         <td><input type="text" name="user_tel" maxlength="3" style="width: 35px;">-
         <input type="text" name="user_tel2" maxlength="4" style="width: 45px;">-
         <input type="text" name="user_tel3" maxlength="4" style="width: 45px;">
         <div id="tel_susin"><p><input type="checkbox" name="user_tel_check" value="Y">
         SMS를 수신하겠습니다.</p></div>
         <p style="font-size: small;">"SMS 수신에 동의하시면 여러가지 할인혜택과 각종 이벤트 정보를 받아보실 수 있습니다."</p>
         <p style="font-size: small;">"회원거입관련, 주문배송관련 등의 SMS은 수신동의와 상관없이 모든 회원에게 발송됩니다."</p>
         </td>
      </tr>
      <tr>
         <th>주소</th>
         <td><input type="text" id="user_post" placeholder="우편번호" name="user_post">
            <input type="button" onclick="post_search()" value="우편번호 찾기"><br>
            <input type="text" id="user_address" placeholder="주소" style="width: 338px;" name="user_address"><br>
            <input type="text" id="user_address_detail" placeholder="상세주소" name="user_address_detail">
            <input type="text" id="user_extraAddress" placeholder="참고항목"></td>
      </tr>
   </table>
   <input type="submit" value="입력완료" onclick="return check()">
   <input type="reset" value="취소하기">
</form>
</section>
<script>

   document.querySelector("input[name='user_email2']").value = document.querySelector("input[name='user_email3']").value;

    function post_search() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("user_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("user_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('user_post').value = data.zonecode;
                document.getElementById("user_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("user_address_detail").focus();
            }
        }).open();
    }
    /////////////////////////아이디 체크/////////////////////////////////////
    function idCheck() {
        if (document.frm.user_id.value == "") {
           alert("아이디를 입력하세요");
           document.frm.user_id.focus();
           return false;
        }
        let param = document.frm.user_id.value;
        const xhttp = new XMLHttpRequest();
        xhttp.onload = function() {
           document.getElementById("idOk").innerHTML = this.responseText;
        }
        xhttp.open("GET", "idOverCheck?id=" + param, true);
        xhttp.send();
     }
    ////////////////////////////비밀번호 확인////////////////////////////////
    function pwOk(){
       if(document.frm.user_pw.value != document.frm.user_pw_check.value){
          document.querySelector("#pw_check").innerHTML = "<span style='color:red';>비밀번호를 다시입력해주세요</span>";
          document.frm.user_pw_check.focus();
          return false;
       }else {
          document.querySelector("#pw_check").innerHTML = "<span style='color:green';>비밀번호 확인성공</span>";
          return true;
       }
    }
    ////////////////////////////이메일 체인지////////////////////////////////
   
   function changeEmail(){
     const email = document.querySelector("input[name='user_email2']").value;
     const cemail = document.querySelector("#user_emails").value;
       if(cemail == "0"){
          document.querySelector("input[name='user_email2']").value = "";
       }else {
          document.querySelector("input[name='user_email2']").value = cemail;
       }
    }
////////////////////////////취소하기///////////////////////////////

   /////////////////////////유효성 검사/////////////////////////////////////
    function check(){
       if(document.frm.user_id.value == ""){
          alert("아이디를 입력해주세요(필수)");
          document.frm.user_id.focus();
          return false;
       }else if(document.frm.user_pw.value == ""){
          alert("비밀번호를 입력해주세요(필수)");
          document.frm.user_pw.focus();
          return false;
       }else if(document.frm.user_pwCheck.value == ""){
          alert("비밀번호 확인을 입력해주세요(필수)");
          document.frm.user_pwCheck.focus();
          return false;
       }else if(document.frm.user_name.value == ""){
          alert("이름을 입력해주세요(필수)");
          document.frm.user_name.focus();
          return false;
       }else if(document.frm.user_email.value == ""){
          alert("이메일을 입력해주세요(필수)");
          document.frm.user_email.focus();
          return false;
       }else if(document.frm.user_email2.value == ""){
          alert("이메일을 입력해주세요(필수)");
          document.frm.user_email2.focus();
          return false;
       }else if(document.frm.user_tel.value == ""){
          alert("전화번호를 입력해주세요(필수)");
          document.frm.user_tel.focus();
          return false;
       }else if(document.frm.user_tel2.value == ""){
          alert("전화번호를 입력해주세요(필수)");
          document.frm.user_tel2.focus();
          return false;
       }else if(document.frm.user_tel3.value == ""){
          alert("전화번호를 입력해주세요(필수)");
          document.frm.user_tel3.focus();
          return false;
       }else{
          return true;
       }
    }
</script>
</body>
</html>