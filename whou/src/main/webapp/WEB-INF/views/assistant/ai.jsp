<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>whou</title>
	<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
	<!-- Bootstrap icons-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />
	<!-- Core theme CSS (includes Bootstrap)-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<link rel="stylesheet" href="/whou/resources/css/style.css">
	<script src="https://kit.fontawesome.com/dbaea98925.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js" ></script>
<script>
	$(function(){
		var chat = "";
		function appendChat(user, bot) { // 채팅 내용 출력하는 함수
			chat += '<p class="chat user" id="user">유저: ' + user + '<p/>' + '<p class="chat bot" id="bot">챗봇: ' + bot + '<p/>'; 
			$(".editable").html(chat);
			scrollToBottom(); 
		}
	
		function scrollToBottom() { // 채팅이 div영역 벗어나면 자동으로 스크롤 내림
			var editableDiv = document.getElementById("editable");
			editableDiv.scrollTop = editableDiv.scrollHeight;
	    }
	
		function sendAjaxRequest(button) { // ajax 동작 함수
			if(button == "돌아가기"){ // 돌아가기 버튼 누르면 Back 함수 호출
				handleBackButtonClick();
			}else{
				$.ajax({
					url: "/whou/assistant/getAiList",
					type: "GET",
					data: {prompt: button},
					success: function(result) {
						var test = []; // return 받은 질문들 넣기위한 배열 (= 2번째 질문들)
						for (var i = 0; i < result.length; i++) {
							test.push(result[i].qes); // 배열에 질문들 다 넣음
						}
						if (result.length > 0) { // 2번째 질문이 있을 때
							$.ajax({
								url: "/whou/assistant/aiContent",
								data: {prompt: button}, // 버튼 value값 제출
								success: function(result) {
									var html = "";
									appendChat(button, result); // 채팅 입력 함수 호출
									for (var i = 0; i < test.length; i++) { // 2번째 질문들로 버튼 생성
									html += '<input type="button" class="otherBtn btn btn-light" value="' + test[i] + '" />';
									}
								$("#btnContain").html(html);
								$("#btnContain").append('<input type="button" class="btn btn-light" id="back" value="돌아가기" />');
								}
							});
						} else { // 질문이 없으면
							$.ajax({
								url: "/whou/assistant/aiContent",
								data: {prompt: button},
								success: function(result) {
									appendChat(button, result);
									$("#btnContain").html('<input type="button" id="back" class="btn btn-light" value="돌아가기" />'); // 돌아가기 버튼만 생성     
								}
							});
						}
					}
				});
			}
		}
	
		function handleButtonClick() { // 첫 질문 버튼 함수
			var button = $(this).val(); // 해당 버튼 value를 button 변수에 대입
			sendAjaxRequest(button); // ajax동작 함수 호출
		}
	
		function handleBackButtonClick() { // 돌아가기 버튼 함수
			$("#btnContain").html('<c:forEach items="${list}" var="aiList">' // 그룹이 1인 리스트들로 버튼 생성
								+'<input type="button" class="btn btn-light mainbtn" value="${aiList.qes}"/>'
								+'</c:forEach>');
		}
	
		$(document).on('click', '.mainbtn, .otherBtn', handleButtonClick); // 해당 클래스 버튼 클릭했을 때 함수 호출
		$(document).on('click', '#back', handleBackButtonClick); // 해당 id 버튼 클릭했을 때 함수 호출
	});
	
	
	var audioFile = new Audio();
	function readBot(){
		if(!read){return;} // 취소버튼 눌렀을 때 동작 안 하고 끝냄
		var text = $(this).text(); // 마우스 올린 텍스트
		var data = {    
			"voice":{
				"languageCode":"ko-KR",
		//   	"name":"hi-IN-Standard-A"
			},
			"input":{
				"text": text 
			},
			"audioConfig":{
				"audioEncoding":"mp3"
			}
		}
		// 재생중인 오디오 멈춤
		audioFile.pause(); 
		audioFile.currentTime = 0;
		$.ajax({
			type:'POST',
			url: 'https://texttospeech.googleapis.com/v1/text:synthesize?key=AIzaSyDD1c5EpqlpRrRrnHqi36SVDTyzwygoOHg',
			data: JSON.stringify(data),
			dataType: 'JSON',
			contentType: "application/json; charset=UTF-8",
			success: function(res) {
				let audioBlob = base64ToBlob(res.audioContent, "mp3");
				audioFile.src = window.URL.createObjectURL(audioBlob);
				audioFile.playbackRate = 1; //재생속도
				audioFile.play();
			},
			error : function(request, status, error ) {
				alert("오류","오류가 발생하였습니다. 관리자에게 문의해주세요.");
			}
		});
		
	};
	
	function base64ToBlob(base64, fileType) {
		let typeHeader = "data:application/" + fileType + ";base64,"; // base64 헤더 파일 유형 정의
		let audioSrc = typeHeader + base64; 
		let arr = audioSrc.split(",");
		let array = arr[0].match(/:(.*?);/);
		let mime = (array && array.length > 1 ? array[1] : type) || type;
		// url헤더 제거하고 btye로 변환
		let bytes = window.atob(arr[1]);
		// 예외를 처리하고 0보다 작은 ASCII 코드를 0보다 큰 값으로 변환
		let ab = new ArrayBuffer(bytes.length);
		// 뷰 생성(메모리에 직접): 8비트 부호 없는 정수, 길이 1바이트
		let ia = new Uint8Array(ab);
		for (let i = 0; i < bytes.length; i++) {
			ia[i] = bytes.charCodeAt(i);
		}
		return new Blob([ab], {
			type: mime
		});
	}
	
	var read = false;
	$(document).on("click", "#readbtn", function(){ // 읽기버튼 눌렀을 때 동작
		$("#readArea").html('<input type="button" id="csbtn" class="btn btn-light" value="취소" />');
		read = true; 
		checkReadStatus(); // 함수 호출해서 read값 반영
	});
		
	$(document).on("click", "#csbtn", function(){
		$("#readArea").html('<input type="button" id="readbtn" class="btn btn-light" value="읽기" />');
		read = false;
		checkReadStatus();
	});
	
	function checkReadStatus(){
		if(read){ // 읽기 버튼을 눌렀을때 텍스트에 마우스 갖다대면 tts함수 실행
			$(document).on('mouseenter', '.user, .bot', readBot);
		}	
	}

</script>
<html>
	<head>
	    <style>
	        div.editable {
	            width: 500px;
	            height: 550px;
	            border: 1px solid #dcdcdc;
	            overflow: auto;
	            margin:0 auto;
	        }
	        p#bot {
				text-align : left;
			}
	        p#user{
	        	text-align : right;
	        }
	        div#btnContain{
	        	display: inline-block;
	        	width: fit-content;
	        }
	    </style>
	</head>
	<body>
		  <%@ include file="../header.jsp" %>        
	        <!-- Header-->
		<header class="py-5">
			<div class="container px-5">
				<h2 class="page-title">ai</h2>
			</div>
		</header>
		<div style="width: 900px; height: 1000px; border: 1px solid #dcdcdc; margin:0 auto;">
			<div class="editable" id="editable" contenteditable="false" style="width: 900px; height: 1000px;">
			<p class="chat"> 문의하실 내용을 선택해주세요. </p>
		</div>
			<div style="display: flex; justify-content: right; align-items: right;">
				<div id="btnContain">
					<c:forEach items="${list}" var="ailist">
						<input type="button" class="btn btn-light mainbtn" value="${ailist.qes}"/>
					</c:forEach>
				</div>
				<div id="readArea" style="display: flex; justify-content: right; align-items: right;">
					<button class="btn btn-light" id="readbtn">읽기</button>
				</div>
			</div>
		</div>
		<footer class="container py-5">
			<div class="border-top border-bottom py-3">
				<ul class="footer-content">
					<li><a href="#!">개인정보처리방침</a></li>
					<li><a href="#!">이메일주소무단수집거부</a></li>
					<li><a href="#!">이용안내</a></li>
					<li><a href="#!">이용문의 및 오류제보</a></li>
					<li><a href="#!">English</a></li>
					<li><a href="#!">오픈API</a></li>
				</ul>
			</div>
			<div class="footer-address py-3">
				<p class="m-0">주소 : 서울특별시 관악구 봉천동 에그옐로우 14층</p>
				<p class="m-0">운영 : 한국직업능력연구원 국가진로교육연구센터</p>
				<p class="m-0">Copyright &copy; Your Website 2023</p>
			</div>
		</footer>
	</body>
</html>