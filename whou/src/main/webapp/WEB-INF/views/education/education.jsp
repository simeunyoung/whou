<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    </head>
 
<body>
        <!-- Responsive navbar-->
       <%@ include file="../header.jsp" %>     
    
              <header class="pt-5">
            <div class="container px-5">
                <h2 class="page-title">학과정보</h2>
                
                <section class="py-5" >
                    <div class="card edu-search-card">
                        <div class="card-body">
                            <div class="input-group search-form">
                                <span class="search-btn"><i class="fa-solid fa-magnifying-glass fa-xl" style="color: #5a3fff;"></i></span>
                                <input type="text" class="">
                            </div>
                            <div class="search-cont" >
                                <h5>전공계열<span class="info"><i class="fa-solid fa-circle-info" style="color: #707070;"></i></span></h5>
                                <ul class="check-group">
                                    <li>
                                        <div class="InpBox">
                                            <input type="checkbox" id="agree_rule1" >
                                            <label class="Lbl check-fil check_off" for="agree_rule1">
                                            전체
                                            </label>                                                  
                                        </div>
                                    </li>
                                    <li>
                                        <div class="InpBox">
                                            <input type="checkbox" id="agree_rule1" >
                                            <label class="Lbl check-fil check_off" for="agree_rule1">
                                            인문계열
                                            </label>                                                  
                                        </div>
                                    </li>
                                    <li>
                                        <div class="InpBox">
                                            <input type="checkbox" id="agree_rule1" >
                                            <label class="Lbl check-fil check_off" for="agree_rule1">
                                            인문계열
                                            </label>                                                  
                                        </div>
                                    </li>
                                    <li>
                                        <div class="InpBox">
                                            <input type="checkbox" id="agree_rule1" >
                                            <label class="Lbl check-fil check_off" for="agree_rule1">
                                            인문계열
                                            </label>                                                  
                                        </div>
                                    </li>
                                    <li>
                                        <div class="InpBox">
                                            <input type="checkbox" id="agree_rule1" >
                                            <label class="Lbl check-fil check_off" for="agree_rule1">
                                            인문계열
                                            </label>                                                  
                                        </div>
                                    </li>
                                    <li>
                                        <div class="InpBox">
                                            <input type="checkbox" id="agree_rule1" >
                                            <label class="Lbl check-fil check_off" for="agree_rule1">
                                            인문계열
                                            </label>                                                  
                                        </div>
                                    </li>
                                    <li>
                                        <div class="InpBox">
                                            <input type="checkbox" id="agree_rule1" >
                                            <label class="Lbl check-fil check_off" for="agree_rule1">
                                            인문계열
                                            </label>                                                  
                                        </div>
                                    </li>
                                    <li>
                                        <div class="InpBox">
                                            <input type="checkbox" id="agree_rule1" >
                                            <label class="Lbl check-fil check_off" for="agree_rule1">
                                            인문계열
                                            </label>                                                  
                                        </div>
                                    </li>
                                </ul>
                                <h5>학교유형</h5>
                                <ul class="check-group">
                                    <li>
                                        <div class="InpBox">
                                            <input type="checkbox" id="agree_rule1" >
                                            <label class="Lbl check-fil check_off" for="agree_rule1">
                                            전체
                                            </label>                                                  
                                        </div>
                                    </li>
                                    <li>
                                        <div class="InpBox">
                                            <input type="checkbox" id="agree_rule1" >
                                            <label class="Lbl check-fil check_off" for="agree_rule1">
                                            인문계열
                                            </label>                                                  
                                        </div>
                                    </li>
                                    <li>
                                        <div class="InpBox">
                                            <input type="checkbox" id="agree_rule1" >
                                            <label class="Lbl check-fil check_off" for="agree_rule1">
                                            인문계열
                                            </label>                                                  
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="search-bottom">
                                <button class="purple-btn">조건검색</button>
                            </div>
                            
                        </div>
                    </div>
                </section>
            </div>
        </header>
        <!-- Features section-->
    
        <!-- Pricing section-->
        <section class="py-2 education-section">
            <div class="container px-5 my-5">
                <div class="result-top">
                    <p class="result-top-txt">총 <span>534</span>건이 검색되었습니다</p>
                    <div class="result-top-right">
                        <select name="" id="">
                            <option value="">정렬순서</option>
                        </select>
                        <select name="" id="">
                            <option value="">9개씩보기</option>
                        </select>
                        <button class="square-btn">적용</button>
                        <div><i class="fa-solid fa-table-cells fa-lg"></i></div>
                        <div><i class="fa-solid fa-bars fa-lg"></i></div>
                    </div>
                </div>
                
                <div class="row justify-content-center">
                    <div class="edu-card">
                        <div class="edu-item-tit">
                            <div>한국어학과 <span>대학교</span></div>
                            <div><span>인문</span></div>
                        </div>
                        <div class="edu-item-cont">
                            <div class="content">Lorem ipsum dolor sit amet consectetur adipisicing elit. Modi magnam, alias ipsa dolor animi corrupti laborum fuga. Incidunt, illo aperiam aut, perspiciatis facere, quisquam at quis omnis sit officia consequuntur.Lorem ipsum dolor sit amet consectetur adipisicing elit. Modi magnam, alias ipsa dolor animi corrupti laborum fuga. Incidunt, illo aperiam aut, perspiciatis facere, quisquam at quis omnis sit officia consequuntur.</div>
                            <div class="disc">관련학과 : </div>
                        </div>
                        <div class="edu-item-bottom">
                            <div><i class="fa-solid fa-magnifying-glass" style="color: #707070;"></i> 조회수 : <span>33,042</span></div>
                            <div><i class="fa-regular fa-thumbs-up" style="color: #707070;"></i> 추천수 : <span>2</span></div>
                        </div>
                    </div>
                    <div class="edu-card">
                        <div class="edu-item-tit">
                            <div>한국어학과 <span>대학교</span></div>
                            <div><span>인문</span></div>
                        </div>
                        <div class="edu-item-cont">
                            <div class="content">Lorem ipsum dolor sit amet consectetur adipisicing elit. Modi magnam, alias ipsa dolor animi corrupti laborum fuga. Incidunt, illo aperiam aut, perspiciatis facere, quisquam at quis omnis sit officia consequuntur.Lorem ipsum dolor sit amet consectetur adipisicing elit. Modi magnam, alias ipsa dolor animi corrupti laborum fuga. Incidunt, illo aperiam aut, perspiciatis facere, quisquam at quis omnis sit officia consequuntur.</div>
                            <div class="disc">관련학과 : </div>
                        </div>
                        <div class="edu-item-bottom">
                            <div><i class="fa-solid fa-magnifying-glass" style="color: #707070;"></i> 조회수 : <span>33,042</span></div>
                            <div><i class="fa-regular fa-thumbs-up" style="color: #707070;"></i> 추천수 : <span>2</span></div>
                        </div>
                    </div>
                </div>

                <div class="pagination">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                          <li class="page-item">
                            <a class="page-link" href="#!" aria-label="Previous">
                              <span aria-hidden="true">&laquo;</span>
                            </a>
                          </li>
                          <li class="page-item"><a class="page-link" href="#!">1</a></li>
                          <li class="page-item"><a class="page-link" href="#!">2</a></li>
                          <li class="page-item"><a class="page-link" href="#!">3</a></li>
                          <li class="page-item">
                            <a class="page-link" href="#!" aria-label="Next">
                              <span aria-hidden="true">&raquo;</span>
                            </a>
                          </li>
                        </ul>
                      </nav>
                </div>
                
            </div>
        </section>
    <%@ include file="../footer.jsp" %> 
    
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    
</html>