<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="en">
 <head>
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
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://kit.fontawesome.com/dbaea98925.js" crossorigin="anonymous"></script>
   	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
   	
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js" integrity="sha512-dLxUelApnYxpLt6K2iomGngnHO83iUvZytA3YjDUCjT0HDOHKXnVYdf3hU4JjM8uEhxf9nD1/ey98U3t2vZ0qQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
   	<script src="../resources/js/unpkg.com_gsap@3.12.1_dist_gsap.min.js"></script>
	<script src="../resources/js/ThreeCSG.js"></script>
	<script src="https://unpkg.com/three@0.128.0/examples/js/controls/OrbitControls.js"></script>
  	<script type="module" src="../resources/js/whouModel.js"></script>
  	
     
 </head>
<style>

</style>
 
 
<body>
    <%@ include file="../header.jsp" %> 
    <section class="py-2 mypage-section">
            <div class="container px-5">
                <h2 class="page-title">마이페이지</h2>
                <div class="desc-wrap">
                    <div class="left-wrap">
                        <div>
                            <nav>
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                  <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">검사결과보기</button>
                                  <button class="nav-link" id="nav-add-tab" data-bs-toggle="tab" data-bs-target="#nav-addInfo" type="button" role="tab" aria-controls="nav-addInfo" aria-selected="false">추가정보입력</button>
                                  <button class="nav-link" id="nav-modify-tab" data-bs-toggle="tab" data-bs-target="#nav-modifyInfo" type="button" role="tab" aria-controls="nav-modifyInfo" aria-selected="false">개인정보수정</button>
                                  <button class="nav-link" id="nav-book-tab" data-bs-toggle="tab" data-bs-target="#nav-book" type="button" role="tab" aria-controls="nav-book" aria-selected="false">나의 북마크</button>
                                  <button class="nav-link" id="nav-reco-tab" data-bs-toggle="tab" data-bs-target="#nav-reco" type="button" role="tab" aria-controls="nav-reco" aria-selected="false">추천 받기</button>
                                  <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">컨설팅하러가기</button>
                                </div>
                              </nav>
                        </div>                        
                        <div class="custom-box">
	                        <div>
	                       		<canvas class="webgl"></canvas> <%-- ai --%>                        
	                        </div>
	                        <div>
	                        	<a href="/whou/whouModel/modelCustom">커스텀하기 >></a>
	                        </div>
                        </div>
                    </div>
                    <div class="right-wrap">
                          <div class="tab-content" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">
                               <select id="testResultSelect">
                                   <option value="21">적성</option>
                                   <option value="25">가치관</option>
                                   <option value="27">역량</option>
                                   <option value="31">흥미</option>
                               </select>
                               <div id="item-aptitude">
                                  <c:if test="${!scoreTrue1}">
                                   <canvas id="aptitudeChart" style="display:none;"></canvas>
                                     <div class="empty-box">
                                     	<div>검사결과가 없습니다.</div>
                                     	<a href="/whou/aptitude/aptitudeMain">검사하러가기 >></a>
                                     </div>
                                  </c:if>
                                  <c:if test="${scoreTrue1}">
                                      <canvas id="aptitudeChart"></canvas>
                                      <ul>
                                           <li>${aptitudeRank.aptitude_name1}</li>                         
                                           <li>${aptitudeRank.aptitude_name2}</li>                         
                                           <li>${aptitudeRank.aptitude_name3}</li>                         
                                      </ul>
                                  </c:if>                                  
                               </div>
                               <div id="item-values">
                                  <c:if test="${!scoreTrue3}">
                                   <canvas id="valuesChart" style="display:none;"></canvas>
                                   <div class="empty-box">
                                     	<div>검사결과가 없습니다.</div>
                                     	<a href="/whou/aptitude/aptitudeMain">검사하러가기 >></a>
                                     </div>
                                  </c:if>
                                  <c:if test="${scoreTrue3}">
                                     <canvas id="valuesChart"></canvas>
                                  </c:if>
                               </div>
                               <div id="item-interest">
                                  <c:if test="${!scoreTrue2}">
                                      <canvas id="interestChart" style="display:none;"></canvas>
                                     <div class="empty-box">
                                     	<div>검사결과가 없습니다.</div>
                                     	<a href="/whou/aptitude/aptitudeMain">검사하러가기 >></a>
                                     </div>
                                  </c:if>
                                  <c:if test="${scoreTrue2}">
                                     <canvas id="interestChart"></canvas>
                                      <ul>
                                           <li>${aptitudeRank.interest_name1}</li>                         
                                           <li>${aptitudeRank.interest_name2}</li>                         
                                           <li>${aptitudeRank.interest_name3}</li>                         
                                      </ul>
                                  </c:if>
                               </div>
                               <div id="item-ability">
                                  <c:if test="${!scoreTrue4}">
                                   <canvas id="abilityChart1" style="display:none;"></canvas>
                                      <canvas id="abilityChart2" style="display:none;"></canvas>
                                     <div class="empty-box">
                                     	<div>검사결과가 없습니다.</div>
                                     	<a href="/whou/aptitude/aptitudeMain">검사하러가기 >></a>
                                     </div>
                                  </c:if>
                                  <c:if test="${scoreTrue4}">
                                       <canvas id="abilityChart1"></canvas>
                                      <canvas id="abilityChart2"></canvas>
                                  </c:if>
                                 
                               </div>
                            </div>
                            <div class="tab-pane fade" id="nav-addInfo" role="tabpanel" aria-labelledby="nav-add-tab" tabindex="0">
		                        <form action="/whou/member/updateInfo" method="post">
		                             <div>
		                                    <div class="add-wrap">
		                                        <div class="left-box">
		                                           <h4>자격증</h4>
		                                           <div id="qualificationContainer">
		                                              
		                                                 <div class="input-wrap">
		                                                     <input type="text" name="certi" autocomplete="off" placeholder="자격증 명" oninput="checkCerti(this)" /> <i class="fa-solid fa-circle-minus fa-lg"></i>
		                                                     <ul class="qualificationList"></ul>
		                                                 </div> 
		                                            
		                                           </div>
		                                           <div class="add-certi-wrap">
		                                              <div class="add-certi-btn" onclick="addQualification()">
		                                                  <i class="fa-solid fa-circle-plus fa-lg"></i>
		                                                  <p>자격증 추가</p>
		                                              </div>
		                                          </div>
		                                        </div>
		                                        <div class="right-box">
		                                          <h4>학과정보</h4>
		                                            <div id="majorContainer">
		                                              <div class="input-wrap">
		                                                   <select class="depart-select" name="depart" id="depart">
		                                                      <option value="대학">대학</option>
		                                                      <option value="전문대학">전문대학</option>
		                                                   </select>
		                                                   <input type="text" name="major" autocomplete="off" placeholder="전공명" oninput="checkMajor(this)" />
		                                                   <ul class="majorList"></ul>
		                                              </div>
		                                              <div class="input-wrap">
		                                                  <input type="text" name="major" autocomplete="off" placeholder="부전공명/복수전공명" oninput="checkMajor(this)" />
		                                                  <ul class="majorList"></ul>
		                                             </div>
		                                             </div>
		                                            </div>
		                                    </div> 
		                                    <div class="button-wrap">
		                                        <button type="submit" class="purple-btn" onclick="load()">저장</button>  
		                                    </div>                                       
		                                </div>   
		                        </form>                        
		                     </div>
               
							<!-- 개인정보수정 -->
		                   <div class="tab-pane fade" id="nav-modifyInfo" role="tabpanel" aria-labelledby="nav-modify-tab" tabindex="0">
                                  <nav>
                                   <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                     <button class="nav-link active" id="info-tab" data-bs-toggle="tab" data-bs-target="#nav-info" type="button" role="tab" aria-controls="nav-info" aria-selected="true">기본정보</button>
                                     <c:if test="${mem.join_type == 'whoU'}">
                                        <button class="nav-link" id="nav-pw-tab" data-bs-toggle="tab" data-bs-target="#nav-pw" type="button" role="tab" aria-controls="nav-pw" aria-selected="false">비밀번호 변경</button>
                                       </c:if>
                                   </div>
                                  </nav>
                                 <div class="tab-content" id="nav-tabContent">
                                    <div class="tab-pane fade show active" id="nav-info" role="tabpanel" aria-labelledby="nav-info-tab" tabindex="0">
                                       <h3>기본 정보</h3>
                                             <form name="joinForm" method="post">
                                            <div class="input-item">
                                            <label for="joinInput" class="form-label">이메일</label>
                                            <input type="text" class="form-control" name = "email" id="email" placeholder="xxxx@example.com" value = "${mem.email}">
                                          </div>
                                          <div class="input-item">
                                            <label for="joinInput" class="form-label">이름</label>
                                            <input type="text" class="form-control" name = "name" id="name" placeholder="이름(실명) 입력" value = "${mem.name}">
                                            <input type="hidden" class="form-control" id = "join_type" value ="${mem.join_type}">
                                          </div>
                                          <div class="input-item">
                                            <label for="joinInput" class="form-label">연도</label>
                                            <input type="text" class="form-control" name = "birth_year" id="birth_year" placeholder="YYYY" value = "${mem.birth_year}" required oninput = "checkYear()">
                                            <span class="year_error" style="color:red; display:none;">4자리로 입력해주세요.</span>
                                          </div>
                                          <div class="input-item">
                                            <label for="joinInput" class="form-label">휴대폰</label>
                                            <div class="input-box">
                                               <input type="text" class="form-control" id="tel" name = "tel" placeholder="'-' 빼고 숫자만 입력" value = "${mem.tel}">
                                               <button type="button" style="border-radius: 8px" class="purple-btn" name="phoneChk" id="phoneChk">인증 요청</button>
                                            </div>
                                               <span class="tel_error" style="color:red; display:none;">형식에 맞게 휴대폰번호를 정확히 입력해주세요.</span>
                                               <span class="tel_ok" style="color:green; display:none;">인증번호 발송이 완료되었습니다.</br> 휴대폰에서 인증번호를 확인해주십시오.</span>
                                            <div class="input-box">
                                               <input type="text" style="display:none;" class="form-control" id="tel2" name = "tel2" placeholder="인증번호 입력">
                                               <button type="button" style="display:none; border-radius: 8px" class="purple-btn" name="phoneChk2" id="phoneChk2">인증 확인</button>
                                         </div>
                                              <span class="tel2_ok" style="color:green; display:none;">인증에 성공하셨습니다.</span>
                                               <span class="tel2_error" style="color:red; display:none;">인증에 실패하셨습니다</br>인증번호를 다시 확인해주십시오.</span>
                                          </div>
                                          
                                          <div class="input-wrap">
                                             <button type="button" style="border-radius: 8px" class="purple-btn btn-xs" id="btnM">수정</button>
                                           </div>
                                        </form>
                                       <h3>추가 정보</h3>
                                       <div></div>
                                    </div>
                                    <div class="tab-pane fade" id="nav-pw" role="tabpanel" aria-labelledby="nav-pw-tab" tabindex="0">
                                        <form>
                                    <div class="input-item">
                                            <label for="joinInput" class="form-label">현재 비밀번호</label>
                                            <div class="input-box">
                                               <input type="password" class="form-control" name = "pw" id="pw" placeholder="4자리 이상">
                                            </div>
                                  </div>
                                           <div class="input-item">
                                       <c:if test="${email == null}">
                                            <label for="joinInput" class="form-label">새 비밀번호</label>
                                            <input type="password" class="form-control" name = "pw" id="pw" placeholder="4자리 이상">
                                            <span class="pw_error" style="color:red; display:none;">형식에 맞게 입력해주세요.</span>
                                       </c:if>
                                    </div>
                                    <div class="input-item">
                                       <c:if test="${email == null}">
                                            <label for="joinInput" class="form-label">새 비밀번호 확인</label>
                                            <input type="password" class="form-control" name = "pw" id="pw2" placeholder="4자리 이상" required oninput = "checkPw2()">
                                            <span class="pw_ok" style="color:green; display:none;">비밀번호가 일치합니다.</span>
                                            <span class="pw_x" style="color:red; display:none;">비밀번호가 일치하지 않습니다.</span>
                                       </c:if>
                                    </div>
                                    <div class="input-wrap">
                                       <button type="button" style="border-radius: 8px" class="purple-btn btn-xs" id="btnPw">변경</button>
                                     </div>
                                 </form>
                                    </div>
                                </div>                            
                             </div>
		                     <div class="tab-pane fade" id="nav-book" role="tabpanel" aria-labelledby="nav-book-tab" tabindex="0">
			                     <div class="book-wrap">
	                                 <c:if test="${books != null }">
	                                    <c:forEach var="job" items="${jobs}" varStatus="status">
	                                       <div class="card mb-5 mb-xl-0">
	                                          <a href="/whou/member/deleteBook?job_cd=${job.job_cd}"><i class="position-absolute top-0 start-100 translate-middle fa-solid fa-circle-minus fa-lg"></i></a>
	                                              <div class="result-cont">
		                                          	<div onclick="location='/whou/job/info?job_cd=${job.job_cd}'">
		                                                  <h4>${job.job_nm }<i class="fa-solid fa-chevron-right fa-xs" style="color: #111111;"></i></h4>
		                                                  <p>${job.works}</p>
		                                    		</div>
	                                              </div>
	                                       </div>
	                                    </c:forEach>
	                                 </c:if>
	                                 <c:if test="${books == null }">
		                                 <div class="empty-box">
		                                    <div>북마크한 관심직업이 없습니다.</div>
		                                    <div>직업정보 탐색 후, 나의 관심직업을 등록해 주세요.</div>
		                                    <a href="/whou/job/dic">직업정보 >></a>
		                                 </div>
	                                 </c:if>
	                        	</div> 
		                     </div>
		                     <!-- 추천 -->
		                     <div class="tab-pane fade" id="nav-reco" role="tabpanel" aria-labelledby="nav-reco-tab" tabindex="0">
		                        <div id="reco-container">
		                                  <div class="reco-wrap">
		                                        <div class="reco-item-container" style="display:flex; justify-content:flex-start; gap:20px;">
		                                           <div class="reco-tag" style="width:400px; height:180px">
		                                                <span style="font-weight:600;font-size: 18px;margin-left:5px;">컨설팅 직업 선택</span>
		                                                <a style="font-size: 12px; margin-left:10px;"onclick="location = '/whou/member/mypage?load=6'">컨설팅 받으러 가기 ></a>
		                                                <div class="input-wrap" style="margin-top:10px;display:flex;">
		                                                    <input class="jobSearch" type="text" name="job" autocomplete="off" placeholder="직업 이름" oninput="" />
		                                                    <div class="button-wrap" style="margin-top:10px; width:80px;">
		                                                       <button type="submit" class="purple-btn" style="margin-left:10px;">적용</button>  
		                                                   </div> 
		                                                    <ul class="searchList"></ul>
		                                                </div> 
		                                              <div style="font-weight:600;font-size: 18px;margin-left:5px;margin-top:20px;">나의 현재 직업 : ${jobDetailCunsuling.getBaseInfo().getJob_nm()} </div>
		                                          </div>
		                                           <div class="reco-tag" style="width:500px; height:180px;">
		                                             <span style="font-weight:600;font-size: 18px;margin-left:5px;">중요도 선택하기</span>
		                                             <a style="font-size: 12px; margin-left:10px;"onclick="">선택하지 않을시에는 모두 동일한 중요도로 선택합니다</a>
		                                             <div style="display:flex">
		                                              <div style="display:flex;font-weight:600;font-size: 18px;margin-left:5px;margin-top:20px; width:200px;">
		                                                 <p>적성</p>
		                                                 <select id="aptiImportance" style="min-width:80px; margin-left:15px;">
		                                                     <option value="1">1순위</option>
		                                                     <option value="2">2순위</option>
		                                                     <option value="3">3순위</option>
		                                                 </select>
		                                                 <p>응시 안함</p>		                                            
		                                              </div>
		                                    <div style="font-weight:600;font-size: 18px;margin-left:5px;margin-top:20px;">
		                                                 흥미
		                                              <select id="inteImportance" style="min-width:80px; margin-left:15px;">
		                                                  <option value="1">1순위</option>
		                                                  <option value="2">2순위</option>
		                                                  <option value="3">3순위</option>
		                                              </select>
		                                                 응시 안함
		                                              </div>
		                                              <div style="font-weight:600;font-size: 18px;margin-left:5px;margin-top:20px;">
		                                                 가치관
		                                                 <select id="valueImportance" style="min-width:80px; margin-left:15px;">
		                                                     <option value="1">1순위</option>
		                                                     <option value="2">2순위</option>
		                                                     <option value="3">3순위</option>
		                                                 </select>
		                                                 응시함
		                                              </div>
		                                              <div class="button-wrap" style="margin-top:10px; width:80px;">
		                                                    <button type="submit" class="purple-btn" style="margin-left:10px;">적용</button>  
		                                    </div> 
		                                 </div>
		                              </div>
		                              </div>
		                           </div>
		                           <c:if test="${!none}">
		                              <p style="margin-bottom:20px;margin-left:10px;">직업 정보를 보고싶으면 본문의 내용을, 컨설팅을 받고 싶으면 직업 이름을 눌러주세요</p>
		                           <c:forEach var="rere" items="${reres}">
		                              <div class="reco-wrap">
		                                 <div class="reco-item">
		                                    <div onclick="alert('직업선택이 완료 되었습니다.');location='/whou/member/insertConsult?job_cd=${rere.job_cd}'">${rere.job_nm}</div>
		                                    <div onclick="location='/whou/job/info?job_cd=${rere.job_cd}'">${rere.descriptions}</div>
		                                          </div>
		                                       </div> 
		                                  </c:forEach>
		                           <div>
		                           
		                           </div>
		                         
		                             
		                     </c:if>
		                            <c:if test="${none}">
		                                <div class="empty-box">
		                                  <div>추천이 불가능합니다.</div>
		                                  <div>검사를 보거나, 자격증 및 학과 정보를 기입해주세요.</div>
		                                  <a href="/whou/aptitude/aptitudeMain">검사하러가기 >></a>                               
		                               </div>
		                            </c:if>
		                             
		                          </div>
		                          <div class="add-btn" onclick="getRecoLi()">
		                                  <i class="fa-solid fa-circle-plus fa-lg"></i>
		                              </div>
		                       </div>
              
		                     
		                     <!-- 컨설팅  -->
                            <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab" tabindex="0">
                            	<%-- <c:if test="${avilReinforce eq '' || avilReinforce==null || cunsultingNum == 0}">--%>
                            	<c:if test="${cunsultingNum==0 }">
	                            	<div class="empty-box">
	                            		<div>컨설팅을 원한다면 직업적성검사를 받으세요.</div>
	                            		<a href="/whou/aptitude/aptitudeMain">검사하러가기 >></a>
	                            	</div>
                            	</c:if>
                            	<c:if test="${!(avilReinforce eq '') || avilReinforce!=null }">
									<div style="padding:0px 10xp;">
										<c:if test="${cunsultingNum > 0}">
											<div style="margin:0px 10xp;">
												<div>${memId} 님의 컨설팅이 완료되었습니다.</div>
				                                <h4>직업 이름 : ${jobDetailCunsuling.getBaseInfo().getJob_nm()}</h4>
				                                <div>
				                                	<p>직업설명: ${jobDetailCunsuling.getWorkList().get(0).getWork()}</p>
				                                </div>
			                                </div>
			                                <div class="card">
											  <div class="card-header">취업 방법</div>
											  <div class="card-body">
											  	<c:forEach var="getRecruit" items="${jobDetailCunsuling.getJobReady().getRecruit()}">
											    <p class="card-text">${getRecruit.recruit}</p>
			                                	</c:forEach>
											  </div>
											</div>
			                                <div class="card">
											  <div class="card-header">관련 교육</div>
											  <div class="card-body">
			                                	<c:forEach var="getCurriculum" items="${jobDetailCunsuling.getJobReady().getCurriculum()}">
			                                		<p class="card-text">${getCurriculum.curriculum}</p>
			                                	</c:forEach>
											  </div>
											  
												
											</div>
											<div class="card">
										  
					                                <div class="card-header">관련학과</div>
					                                <div class="card-body">
					                                	<c:forEach var="getDepartList" items="${jobDetailCunsuling.getDepartList()}">
					                                		${getDepartList.depart_name},
					                                	</c:forEach>
													  <div style="height:300px;">
													  	<canvas id="chartCanvas"></canvas>
													  	<script>
														  	function getSpecificColor(index) {
														    	  const colors = [
														    		  '#FF6D60', '#F7D060', '#F3E99F', '#98D8AA',
														    		  '#3AA6B9', '#F0F0F0', '#F9D949', '#F45050',
														    		  '#F7C8E0', '#DFFFD8', '#B4E4FF', '#95BDFF',
														    		  '#6F69AC', '#95DAC1', '#C56183',
														    	  ];
														    	  return colors[index % colors.length]; // 인덱스에 따라서 색상을 반복해서 사용합니다.
															}
														  	var charLabel = [
														        <c:forEach items="${majorChartMajor}" var="chartMajorLabel" varStatus="status">
														            '${chartMajorLabel}'<c:if test="${not status.last}">,</c:if>
														        </c:forEach>
														    ];
														  	var chartData = [
														        <c:forEach items="${majorChartMajorData}" var="chartMajorData" varStatus="status">
														            '${chartMajorData}'<c:if test="${not status.last}">,</c:if>
														        </c:forEach>
														    ];
														  	const canvas3 = document.getElementById("chartCanvas");
													    	const data3 = {
													    	    	  labels: charLabel,
													    	    	  datasets: [
													    	    	    {
													    	    	      label: "종사자의 전공 계열",
													    	    	      data: chartData,
													    	    	      backgroundColor: Array.from({ length: charLabel.length }, (_, index) => getSpecificColor(index)), // 무작위 색상을 5000개 생성하여 배열로 설정,
													    	    	      hoverOffset: 4,
													    	    	    },
													    	    	  ],
													    	    	};
													    	const options3 = {
													    			plugins: {
													    				responsive: false,
													    				title: {
													    					display: true,
													    					position: 'bottom',
													    					text: '종사자의 전공 계열',
													    					font: { size: 20, weight: 'bold' },
													    					},
													    			    legend: {
													    			    	position: 'right',
													    			    	},
																	},
															};
			
															new Chart(canvas3, {
																type: "doughnut",
																data: data3,
																options: options3,
															});
													  	</script>
													  </div>
													    <div>
												  	${jobDetailCunsuling.getMajorChart().get(0).getSource()}
												  </div>
												  </div>
												  
												  </div>
											<!-- 
			                                <div>
			                                	종사자 전공 계열 분포 : 
			                                	<c:forEach var="majorChartMajor" items="${majorChartMajor}">
			                                		${majorChartMajor}
			                                	</c:forEach>
			                                	<c:forEach var="majorChartMajorData" items="${majorChartMajorData}">
			                                		${majorChartMajorData}%
			                                	</c:forEach>
			                                	${jobDetailCunsuling.getMajorChart().get(0).getSource()}
			                                </div>
			                                 -->
			                                 
			                                 <c:if test="${jobDetailCunsuling.getJobReady().getCertificate().get(0) != null }">
				                                 <div class="card">
													<div class="card-header">자격증</div>
													<div class="card-body">
														<c:forEach var="getCertificate" items="${jobDetailCunsuling.getJobReady().getCertificate()}">
								                 			<p class="card-text">${getCertificate.certificate}</p>
								                 		</c:forEach>
													</div>
												</div>
											</c:if>
			                                
			                                <div class="card">
			                                	<div class="card-header">요구 능력</div>
			                                	<div class="card-body">
			                                		<c:forEach var="getAbilityList" items="${jobDetailCunsuling.getAbilityList()}">
			                                			${getAbilityList.ability_name}
			                                		</c:forEach>
			                                	</div>
		                                	</div>
		                                	<div>
		                                	     <div class="card">
				                                	<div class="card-header">직업적성검사 결과</div>
				                                	<div class="card-body">
				                                		<c:forEach var="i" begin="0" end="${fn:length(needAvil)}">
														    <c:set var="currentNeedAvil" value="${needAvil[i]}" />
														    <c:set var="currentAvilArrValue" value="${avilArrValue[i]}" />
														    <c:set var="currentReinDTO" value="${reinDTO[i]}" />
														    <c:if test="${currentNeedAvil != null && currentAvilArrValue < 55}">
														        ${currentNeedAvil}영역이 ${currentAvilArrValue}점으로 보완이 필요합니다.
														        아래와 같은 방법을 통해 보완할 수 있습니다.
																
																<ol>
															        <li>${currentReinDTO.getMethod01()}</li>
															        <li>${currentReinDTO.getMethod02()}</li>
															        <li>${currentReinDTO.getMethod03()}</li>
															        <li>${currentReinDTO.getMethod04()}</li>
															        <li>${currentReinDTO.getMethod05()}</li>
															        <li>${currentReinDTO.getMethod06()}</li>
															        <li>${currentReinDTO.getMethod07()}</li>
															        <li>${currentReinDTO.getMethod08()}</li>
															        <li>${currentReinDTO.getMethod09()}</li>
															        <li>${currentReinDTO.getMethod10()}</li>
														        </ol>
														    </c:if>
														
														    <c:if test="${currentNeedAvil != null && currentAvilArrValue > 55 && currentAvilArrValue < 101}">
														        ${currentNeedAvil}영역이 ${currentAvilArrValue}점으로 준수합니다. 
														        자격증과 기타 활동을 위주로 수행하시는 것을 추천드립니다.
														    </c:if>
														</c:forEach>
				                                	</div>
			                                	</div>
			                                
			                                </div>
				                        </c:if>
				                      
									</div>
								</c:if>
							</div>
                            
						
                          </div>
                    </div>
                </div>    
            </div>
        </section>
        <%@ include file="../footer.jsp" %> 
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>

        
        let load = "${load}";
        
        if(load === "2"){
         	 $(".nav-link").removeClass("active");
         	 $(".tab-pane").removeClass("active show");
         	 
           	 $("#nav-add-tab").addClass("active");
           	 $("#nav-addInfo").addClass("active show");
        }else if(load === "3"){
        	$(".nav-link").removeClass("active");
        	 $(".tab-pane").removeClass("active show");
        	 
          	 $("#nav-modify-tab").addClass("active");
          	 $("#nav-modifyInfo").addClass("active show");
        }
        else if(load === "6"){
            $(".nav-link").removeClass("active");
               $(".tab-pane").removeClass("active show");
               
                 $("#nav-contact-tab").addClass("active");
                 $("#nav-contact").addClass("active show");
           }
         // 적성 차트
         	let aptitudeScoreArr = 0;
         	let aptitudeNameArr = ["음악능력","수리·논리력","창의력","자연친화력","예술시각능력","공간지각력","대인관계능력","손재능","언어능력","자기성찰능력","신체·운동능력"];
        	if (typeof aptitudeScoreArr !== 'undefined' && aptitudeScoreArr !== null && aptitudeScoreArr !== '') {
        		aptitudeScoreArr = ${aptitudeScoreArr};
        		aptitudeNameArr =${aptitudeNameArr};
			}
        	
            const ctx21 = document.getElementById('aptitudeChart');
              var myChart21 = new Chart(ctx21, {
                   type: 'radar',
                   data: {
                       labels:aptitudeNameArr,
                       datasets: [
                       {
                           data: aptitudeScoreArr,
                           backgroundColor: 'rgba(255, 99, 132, 0.5)',
                           borderColor: 'rgba(255, 99, 132, 1)',
                           borderWidth: 1,
                          
                       },              
                       ]
                   },
                   options: {
                       scale: {                                          
                               min: 0,
                               max: 100,
                               ticks: {
                                 stepSize:5
                               }
                           
                       }
                   }
                   });
              
              // 흥미차트 
	           let  interestScoreArr = 0;
				if (typeof interestScoreArr !== 'undefined' && interestScoreArr !== null && interestScoreArr !== '') {
					interestScoreArr = ${interestScoreArr};
				} 
             
            const ctx31 = document.getElementById('interestChart');
              var myChart31 = new Chart(ctx31, {
                   type: 'radar',
                   data: {
                       labels:['자연과학','AI·소프트웨어','공학','법률·행정','복지','교육','예술·미디어','스포츠','마케팅','금융·경영','여가·관광','보건의료', '농생명', '환경', '제조', '물류·운송·유통', '설계·건축·토목'],
                       datasets: [
                       {
                           data: interestScoreArr,
                           backgroundColor: 'rgba(255, 99, 132, 0.5)',
                           borderColor: 'rgba(255, 99, 132, 1)',
                           borderWidth: 1,
                          
                       },              
                       ]
                   },
                   options: {
                       scale: {                                          
                               min: 0,
                               max: 100,
                               ticks: {
                                 stepSize:5
                               }
                           
                       }
                   }
                   });
              
           // 가치관 
           let valuesScoreArr=0;
			if (typeof valuesScoreArr !== 'undefined' && valuesScoreArr !== null && valuesScoreArr !== '') {
				valuesScoreArr = ${valuesScoreArr};
			}
          
            const ctx25 = document.getElementById('valuesChart');
              var myChart25 = new Chart(ctx25, {
                   type: 'radar',
                   data: {
                       labels:['안정성', '보수', '일과 삶의 균형', '즐거움','소속감','자기계발', '도전성', '영향력', '사회적 기여','성취','사회적 인정','자율성'],
                       datasets: [
                       {
                           data: valuesScoreArr,
                           backgroundColor: 'rgba(255, 99, 132, 0.5)',
                           borderColor: 'rgba(255, 99, 132, 1)',
                           borderWidth: 1,
                          
                       },              
                       ]
                   },
                   options: {
                       scale: {                                          
                               min: 0,
                               max: 20,
                               ticks: {
                                 stepSize:5
                               }
                           
                       }
                   }
                   });
           // 역량 
             let abilityScoreArr1=0;
             let abilityScoreArr2=0;
			if (typeof abilityScoreArr1 !== 'undefined' && abilityScoreArr1 !== null && abilityScoreArr1 !== '') {
				abilityScoreArr1 = [${firstThree}];
				abilityScoreArr2 = [${lastSix}];
			}
            
            const ctx271 = document.getElementById('abilityChart1');
              var myChart271 = new Chart(ctx271, {
                   type: 'radar',
                   data: {
                       labels:['자기이해', '직업이해', '진로탐색', '진로계획'],
                       datasets: [
                       {
                           data: abilityScoreArr1,
                           backgroundColor: 'rgba(255, 99, 132, 0.5)',
                           borderColor: 'rgba(255, 99, 132, 1)',
                           borderWidth: 1,
                          
                       },              
                       ]
                   },
                   options: {
                       scale: {                                          
                               min: 0,
                               max: 100,
                               ticks: {
                                 stepSize:5
                               }
                           
                       }
                   }
                   });
              
              
            
              const ctx272 = document.getElementById('abilityChart2');
                var myChart272 = new Chart(ctx272, {
                     type: 'radar',
                     data: {
                         labels:['낙관성', '지속성', '호기심', '유연성', '도전성', '의사소통'],
                         datasets: [
                         {
                             data: abilityScoreArr2,
                             backgroundColor: 'rgba(255, 99, 132, 0.5)',
                             borderColor: 'rgba(255, 99, 132, 1)',
                             borderWidth: 1,
                            
                         },              
                         ]
                     },
                     options: {
                         scale: {                                          
                                 min: 0,
                                 max: 100,
                                 ticks: {
                                   stepSize:5
                                 }
                             
                         }
                     }
                     });

              
              // tab
            const triggerTabList = document.querySelectorAll('#myTab button')
         triggerTabList.forEach(triggerEl => {
           const tabTrigger = new bootstrap.Tab(triggerEl)
         
           triggerEl.addEventListener('click', event => {
             event.preventDefault()
             tabTrigger.show()
           })
         })
  
         // 추가 정보 입력
            function checkCerti(inputElement) {
               var certi = $(inputElement).val();
               var qualificationList = $(inputElement).siblings(".qualificationList");
               $.ajax({
                   url: "/whou/member/getCerti",
                   data: { certi: certi },
                   success: function (result) {
                       qualificationList.empty();
                       qualificationList.hide();
                       if(certi.length > 0){
                          if(result && result.length > 0){
                              for (var i = 0; i < result.length; i++) {
                                  var qualification = result[i];
                                  var button = $("<button>").text(qualification);
                               
                                  button.on("click", function () {
                                     event.preventDefault();
                                      var selectedQualification = $(this).text();
                                      $(inputElement).val(selectedQualification);
                                      qualificationList.hide();
                                  });
                                  qualificationList.append($("<li>").append(button));
                              }
                           }else{
                               var message = "' " + certi + " '을(를) 찾을 수 없습니다.";
                               var messageElement = $("<li>").text(message);
                               messageElement.on("click", function () {
                                   // 메시지 클릭 시 qualificationList를 숨기고 인풋 값을 비웁니다.
                                   $(inputElement).val("");
                                   qualificationList.hide();
                               });
                               qualificationList.append(messageElement);
                           }    

                           qualificationList.show();
                       }
                   }
               });
           }
           
           function checkMajor(inputElement) {
               var major = $(inputElement).val();
               var univSe = $("#depart").val();
               //var univSe2 = $("#depart2").val();
               var majorList = $(inputElement).next(".majorList");

               $.ajax({
                   url: "/whou/member/getMajor",
                   data: { major: major, univSe:univSe},
                   success: function (result) {
                      majorList.empty();
                      majorList.hide();
                      
                      if(major.length > 0){
                         if(result && result.length > 0){
                             for (var i = 0; i < result.length; i++) {
                                 var major2 = result[i];
                                 var button = $("<button>").text(major2);
                                 button.on("click", function () {
                                    event.preventDefault();
                                     var selectedMajor = $(this).text();
                                     $(inputElement).val(selectedMajor);
                                     majorList.hide();
                                 });
                                 majorList.append($("<li>").append(button));
                             }
                         }else{
                             var message = "' " + major + " '을(를) 찾을 수 없습니다.";
                             var messageElement = $("<li>").text(message);
                             messageElement.on("click", function () {
                                 // 메시지 클릭 시 qualificationList를 숨기고 인풋 값을 비웁니다.
                                 $(inputElement).val("");
                                 majorList.hide();
                             });
                             majorList.append(messageElement);
                         }
                         majorList.show();
                      }
                   }
               });
           }

        function addQualification() {
            var newDiv = $("<div>").addClass("input-wrap");
            var newInput = $("<input>").attr({
                type: "text",
                name: "certi",
                required: true,
                oninput: "checkCerti(this)",
                placeholder: "자격증 명",
                autocomplete: "off",
            });
            var newIcon = $("<i>").addClass("fa-solid fa-circle-minus fa-lg");
            var newUl = $("<ul>").addClass("qualificationList");
   
            newDiv.append(newInput).append(newIcon).append(newUl);

            $("#qualificationContainer").append(newDiv);
            newUl.hide();
        }
        
        function addMajor() {
            var newDiv = $("<div>");
            var newInput = $("<input>").attr({
                type: "text",
                name: "major",
                required: true,
                oninput: "checkMajor(this)",
                autocomplete: "off",
            });
            var newUl = $("<ul>").addClass("majorList");

            newDiv.append(newInput).append(newUl);

            $("#majorContainer").append(newDiv);
            newUl.hide();
        }
        $(document).on('click', '.fa-solid.fa-circle-minus', function(){
            $(this).parent(".input-wrap").remove();
        });
        
        // select 요소의 값 변경 감지
        $('#testResultSelect').change(function() {
            var selectedValue = $(this).val();
            
            // 모든 아이템을 숨김 처리
            $('#item-aptitude').hide();
            $('#item-interest').hide();
            $('#item-values').hide();
            $('#item-ability').hide();

            // 선택된 값에 따라 해당 아이템을 보여줌
            if (selectedValue === '21') {
                $('#item-aptitude').show();
            } else if (selectedValue === '31') {
                $('#item-interest').show();
            } else if (selectedValue === '25') {
                $('#item-values').show();
            }else if (selectedValue === '27') {
                $('#item-ability').show();
            }
        });
        
        
        
        // 추천
        function addReco() {
            var newDiv = $("<div>").addClass("input-wrap");
            var newInput = $("<input>").attr({
                type: "text",
                name: "certi",
                required: true,
                oninput: "checkCerti(this)",
                placeholder: "자격증 명",
                autocomplete: "off",
            });
            var newIcon = $("<i>").addClass("fa-solid fa-circle-minus fa-lg");
            var newUl = $("<ul>").addClass("qualificationList");
   
            newDiv.append(newInput).append(newIcon).append(newUl);

            $("#qualificationContainer").append(newDiv);
            newUl.hide();
        }
        
        
        var recoPlus = 1;
        function getRecoLi(){
           var size=5;
            $.ajax({
                url: "/whou/member/getRecoLi",
                type: "GET",
                dataType: "json",
                data: { page : recoPlus++, size:size},
                success: function(result) {
                   console.log(result);
                   for(var i = 0 ; i < result.length; i++){
                       generateDynamicHTML(result[i]);
                   }
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching joke:", error);
                }
            });
        }; 

        // Function to generate the dynamic HTML content
        function generateDynamicHTML(data) {
            const recoWrapDiv = document.createElement('div');
            recoWrapDiv.className = 'reco-wrap';

            const recoItemDiv = document.createElement('div');
            recoItemDiv.className = 'reco-item';

            const jobNameDiv = document.createElement('div');
            jobNameDiv.innerText = data.job_nm;
            jobNameDiv.onclick = function () {
                location = '/whou/member/insertConsult?job_cd='+data.job_cd;
            };
            
            const jobDescriptionDiv = document.createElement('div');
            jobDescriptionDiv.innerText = data.descriptions;
            jobDescriptionDiv.onclick = function () {
                location = '/whou/job/info?job_cd='+data.job_cd;
            };

            recoItemDiv.appendChild(jobNameDiv);
            recoItemDiv.appendChild(jobDescriptionDiv);
            recoWrapDiv.appendChild(recoItemDiv);

            const dynamicContentDiv = document.getElementById('reco-container');
            dynamicContentDiv.appendChild(recoWrapDiv);
        }
        </script>
       <script>
	       var modelCamera_x = 0;
		   	var modelCamera_y = 1;
		   	var modelCamera_z = 3;
        	var modelPath= '';
        	var modelWidth = 200;
        	var modelHeight = 200;
        	if('${model.headColor}' === ''){
        		var headColor = '#FF0080';
        	}else{
        		headColor = '${model.headColor}';
        	}
        	if('${model.armColor}' === ''){
        		var armColor = '#FF0080';
        	}else{
        		armColor = '${model.armColor}';
        	}
        	if('${model.cheekColor}' === ''){
        		var cheekColor = '#FF0080';
        	}else{
        		cheekColor = '${model.cheekColor}';
        	}
        	if('${model.legColor}' === ''){
        		var legColor = '#FF0080';
        	}else{
        		legColor = '${model.legColor}';
        	}
        	
        	
        	
            
          
        </script>
        
    
    </body>
    
</html>