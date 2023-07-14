<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <script src="https://kit.fontawesome.com/dbaea98925.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
        <script>
	        $(document).ready(function(){
        	$(window).scroll(function(){  //스크롤이 움직일때마다 이벤트 발생
        	      var position = $(window).scrollTop()+500; // 현재 스크롤바의 위치값을 반환
        	      $("#Quick").stop().animate({top:position+"px"}, 400); //해당 오브젝트 위치값 재설정
        	   });

        	});
        </script>
    </head>
 
    <body>
        <!-- Responsive navbar-->
       <%@ include file="../header.jsp" %>        
        <!-- Header-->
        <header class="py-5">
            <div class="container px-5">
                <h2 class="page-title">공지사항</h2>
                <div class="row gx-5 justify-content-center">
                    <div class="col-lg-9">
                      <form action="/whou/cs/noticeSearch">
                        <div class="text-center my-4 d-flex">
	                            <div class="select-form">
	                                <select class="desc-select" name="option">
	                                    <option value="all">전체</option>
	                                    <option value="subject">제목</option>
	                                    <option value="content">내용</option>
	                                </select>
	                            </div>
	                            <div class="input-group search-form">
                                <span class="search-btn"><i class="fa-solid fa-magnifying-glass fa-xl" style="color: #5a3fff;"></i></span>
                                <input type="text" class="" name="word">
                                <input type="submit" style="display: none;">
                            </div>
                        </div>
                      </form>
                    </div>
                </div>
            </div>
        </header>
        <!-- Features section-->
    
        <!-- Pricing section-->
        <section class="py-2 result-section">
            <div class="container px-5 my-5">
                <div class="result-top">
                <c:if test="${count == 0 }">
                	<p class="result-top-txt">조회된 글이 없습니다</p>
                </c:if>
                <c:if test="${count > 0 }">
                    <p class="result-top-txt">총 <span>${count}</span>건의 글이 있습니다</p>
                </c:if>
                <c:if test="${lv == 0}">
	                 <div style="float: right;">
	                	<button type="button" class="btn btn-light" onclick="location='/whou/cs/noticeWriteForm'">글작성</button>
	                </div>
                </c:if>
                </div>
                            <!-- <div class="result-img">img</div> -->
					<table class="table table-hover" style="table-layout:fixed" >
						<thead>
							<tr class="table-secondary">
								<th scope="col">글번호</th>
								<th scope="col">작성자</th>
								<th scope="col">제목</th>
								<th scope="col">내용</th>
								<th scope="col">작성일</th>
								<th scope="col">조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${noticeList}" var="notice">
							<tr>
								<th scope="row">
								${number}
								<c:set var="number" value="${number - 1}" />
								</th>
									<td>관리자</td>
									<td>
										<a href="/whou/cs/noticeDetail?num=${notice.num}">${notice.subject}</a>
									</td>
									<td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">
										<a href="/whou/cs/noticeDetail?num=${notice.num}">${notice.content}</a>
									</td>
								    <td>
								    	<fmt:formatDate value="${notice.reg}" pattern="yyyy-MM-dd" type="date"/>
								    </td>
								    <td>
								    	${notice.readcount}
								    </td>
							</tr>
							</c:forEach>
							</tbody>
						</table>

                <div class="pagination">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                          <li class="page-item">
                          <c:if test="${startPage > 1}">
                            <a class="page-link" href="notice?pageNum=${startPage - 1 }" aria-label="Previous">
                              <span aria-hidden="true">&laquo;</span>
                            </a>
                          </c:if>
                          </li>
                          <c:forEach begin="${startPage}" end="${endPage}" var="i">
                          	<li class="page-item"><a class="page-link" href="notice?pageNum=${i}">${i}</a></li>
                          </c:forEach>
                          
                          <li class="page-item">
                          <c:if test="${endPage < pageCount}">
                            <a class="page-link" href="notice?pageNum=${startPage + 1}" aria-label="Next">
                              <span aria-hidden="true">&raquo;</span>
                            </a>
                          </c:if>
                          </li>
                        </ul>
                      </nav>
                </div>
                <div id="Quick" class="" style="position: absolute; right: 10px; top: 400px;">
				    <table class="quickMenuBar" style="">
				        <tr>
				            <td colspan="2" style="cursor:pointer;" onclick="window.scrollTo(0,0);">TOP</td>
				        </tr>
				    </table>
				</div>
				                
            </div>
        </section>
        <!-- Footer-->
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
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            const triggerTabList = document.querySelectorAll('#myTab button')
				triggerTabList.forEach(triggerEl => {
				  const tabTrigger = new bootstrap.Tab(triggerEl)
				
				  triggerEl.addEventListener('click', event => {
				    event.preventDefault()
				    tabTrigger.show()
				  })
				})
        </script>
    </body>
    
</html>
