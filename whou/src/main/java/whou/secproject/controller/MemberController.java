package whou.secproject.controller;

import java.io.IOException;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.apis.NaverApi;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import whou.secproject.component.JobDicDetailResponseDTO;
import whou.secproject.component.JobDicDetailResponseDTO.Knowledge;
import whou.secproject.component.JobDicDetailResponseDTO.Perform_;
import whou.secproject.component.MemberDTO;
import whou.secproject.repository.JobDicApiDAO;
import whou.secproject.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService service;
	
	@Autowired
	private JobDicApiDAO dao;
	
	//회원가입 폼
	@RequestMapping("/joinForm")
	public String  joinForm() {
		
		return "/user/joinForm";
	}
	
	//로그인 폼
	@RequestMapping("/login")
	public String  login() {
		
		return "/user/login";
	}
	
	//로그인
	@RequestMapping("/loginPro")
	public @ResponseBody String  loginPro(String email, String pw, HttpServletRequest request) {
		String dpw = service.login(email);
		System.out.println(dpw);
		HttpSession session = request.getSession();
		if(pw.equals(dpw)) {
			session.setAttribute("memId", email);
			System.out.println("비번 일치");
		}
		return dpw;
	}
	
	//메인페이지(세션확인)
	@RequestMapping("/main")
	public String main(Model model, HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		String memId = (String)session.getAttribute("memId");
		System.out.println(memId);
		model.addAttribute("memId", memId);
		return "/main";
	}
	
	//로그아웃
  	@RequestMapping("/logout")
  	public String logout(HttpSession session, HttpServletRequest request, Model model ) {
  	    session.removeAttribute("access_Token");
  	    session.removeAttribute("memId");
  		return "/main";
  	}
  	
  	//이메일 찾기 폼
  	@RequestMapping("/findEmail")
  	public String findEmail(HttpSession session, HttpServletRequest request, Model model ) {
  		return "/user/findEmail";
  	}
  	
  	//이메일 찾기
  	@RequestMapping("/findEmailPro")
  	public @ResponseBody String findEmailPro(String name, String tel) {
  		System.out.println(name+" ////// "+tel);
  		String email = service.getEmail(name, tel);
  		String type = null;
  		if(email != null) {
  	  		type = service.join_type(email);
  		}
  		if(email == null) { //가입한적 없음
  	  		return "0";
  		}else if(email != null && type != null) { //소셜가입
  			return "1";
  		}else{ //자체가입함
  	  		return email;
  		}
  	}
  	//이메일 찾기 결과
  	@RequestMapping("/findEmailPro2")
  	public String findEmailPro2(Model model,@RequestParam("result") String result) {
  		model.addAttribute("email", result);
  		return "/user/findEmailPro";
  	}
  	
  	//비밀번호 찾기 폼
  	@RequestMapping("/findPw")
  	public String findPw(HttpSession session, HttpServletRequest request, Model model ) {
  		return "/user/findPw";
  	}
  	
  	//비밀번호 찾기
  	@RequestMapping("/findPwPro")
  	public @ResponseBody String findPwPro(String email) {
  		String dpw = service.login(email);
  		String type = service.join_type(email);
  		if(dpw == null && type == null) { //가입한적 없음
  	  		return "0";
  		}else if(dpw == null && type != null) { //소셜가입
  			return "1";
  		}else { //자체가입함
  	  		return dpw;
  		}
  	}
  	
  	//비밀번호 찾기 결과
  	@RequestMapping("/findPwPro2")
  	public String findPwPro2(Model model,@RequestParam("result") String result) {
  		model.addAttribute("pw", result);
  		return "/user/findPwPro2";
  	}
	
	//네이버 로그인
	@RequestMapping("/naver")
    public String naverLogin(HttpServletRequest request) {
        OAuth20Service service = new ServiceBuilder("QWYmFRRrJidAIVICUYXk")
        		.apiSecret("SjbYDHwrH9")
                .callback("http://localhost:8080/whou/member/Ncallback")
                .build(NaverApi.instance());
        
        String authorizationUrl = service.getAuthorizationUrl();

        request.getSession().setAttribute("oauth2Service", service);

        
        return "redirect:" + authorizationUrl;
    }
    
	//네이버 콜백
    @RequestMapping("/Ncallback")
    public String naverCallback(@RequestParam("code") String code, HttpServletRequest request, Model model) throws IOException, InterruptedException, ExecutionException {
        OAuth20Service serv = (OAuth20Service) request.getSession().getAttribute("oauth2Service");
        
        OAuth2AccessToken accessToken = serv.getAccessToken(code);
        
        // HttpClient를 사용하여 요청을 보냅니다.
        HttpClient httpClient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet("https://openapi.naver.com/v1/nid/me");
        httpGet.addHeader("X-Naver-Client-Id", "QWYmFRRrJidAIVICUYXk");
        httpGet.addHeader("X-Naver-Client-Secret", "SjbYDHwrH9");
        httpGet.addHeader("Authorization", "Bearer " + accessToken.getAccessToken());

        HttpResponse httpResponse = httpClient.execute(httpGet);
        String responseBody = EntityUtils.toString(httpResponse.getEntity());
        
        // JSON 파싱을 위한 ObjectMapper 인스턴스 생성
        ObjectMapper objectMapper = new ObjectMapper();

        // JSON 데이터 파싱
        JsonNode jsonNode = objectMapper.readTree(responseBody);

        // 사용자 정보 추출
        //String id = jsonNode.get("response").get("id").asText();
        String email = jsonNode.get("response").get("email").asText();
        
        System.out.println(jsonNode);
        
        //세션 생성
        HttpSession session = request.getSession();
		if (email != null) {
	        model.addAttribute("email", email);
	        int count = service.check(email);
	        if(count == 0) {
	        	model.addAttribute("join_type", "N");
	        	model.addAttribute("join", 1);
	        	return "/user/joinForm";
	        }else if(count == 1) {
	        	//가입타입을 검사해서 N이면 로그인 아니면 다른걸로 가입햇음
	        	String join = service.join_type(email);
	        	if(join.equals("N")) {
	        		session.setAttribute("memId", email);
			        session.setAttribute("access_Token", accessToken);
		        	return "/main";
	        	}else {
	        		model.addAttribute("warn", 1);
	        		return "/main";
	        	}
	        }
	    }else if(email == null){
	    	return "/user/joinForm";
	    }
        return "/main";
    }
    
    //카카오 로그인
  	@RequestMapping("/kakao")
  	public String login(@RequestParam("code") String code, Model model, HttpServletRequest request) {
  		String access_Token = service.getAccessToken(code);
  		System.out.println("/////토큰////"+access_Token);
  	    String email = service.getUserInfo(access_Token);
  		System.out.println("이메일------" + email);
  		HttpSession session = request.getSession();
  		if (email != null) {
  	        model.addAttribute("email", email);
  	        int count = service.check(email);
  	        System.out.println(count);
  	        if(count == 0) {
  	        	model.addAttribute("join_type", "K");
  	        	model.addAttribute("join", 1);
  	        	return "/user/joinForm";
  	        }else if(count == 1) {
  	        	//가입타입을 검사해서 N이면 로그인 아니면 다른걸로 가입햇음
  	        	String join = service.join_type(email);
  	        	System.out.println(join);
  	        	if(join.equals("K")) {
  	        		session.setAttribute("memId", email);
  			        session.setAttribute("access_Token", access_Token);
  		        	return "/main";
  	        	}else {
  	        		model.addAttribute("warn", 1);
  	        		return "/main";
  	        	}
  	        }
  	    }else if(email == null){
  	    	return "/user/joinForm";
  	    }
          return "/main";
    }
  		
	//구글 로그인
  	@RequestMapping("/google")
  	public String google(Model model, HttpServletRequest request) throws IOException {
		String googleLoginUrl = "https://accounts.google.com/o/oauth2/auth" +
		          "?client_id=" + "694729335668-knpidd602057l2ovrvk6qpqhqeub7b6c.apps.googleusercontent.com" +
		          "&redirect_uri=" + "http://localhost:8080/whou/member/googleLog" +
		          "&response_type=code" +
		          "&scope=email profile";
		System.out.println("구글 거쳐감");
		return "redirect:" + googleLoginUrl;
	}
  	
  	//구글 로그인프로
  	@RequestMapping("/googleLog")
  	public String googleLog(@RequestParam("code") String authorizationCode, Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
  		try {
              GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                      new NetHttpTransport(),
                      JacksonFactory.getDefaultInstance(),
                      "https://oauth2.googleapis.com/token",
                      "694729335668-knpidd602057l2ovrvk6qpqhqeub7b6c.apps.googleusercontent.com",
                      "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",
                      authorizationCode,
                      "http://localhost:8080/whou/member/googleLog"
              ).execute();

              // 접근 토큰 가져오기
              String accessToken = tokenResponse.getAccessToken();
              System.out.println(accessToken);
              
              // 접근 토큰으로 정보 가져오기
              ResponseEntity<String> json = service.getInfo(accessToken);
              System.out.println(json);
              
              // 회원 정보 파싱
              JsonParser jsonParser = new JsonParser();
              JsonObject jsonObject = jsonParser.parse(json.getBody()).getAsJsonObject();

              String email = jsonObject.get("email").getAsString();
              
              //세션 생성
              HttpSession session = request.getSession();
	      	  if (email != null) {
	      	      model.addAttribute("email", email);
	      	      int count = service.check(email);
	      	      System.out.println(count);
	      	      if(count == 0) {
	      	      		model.addAttribute("join_type", "G");
	      	        	model.addAttribute("join", 1);
	      	        	return "/user/joinForm";
	      	      }else if(count == 1) {
	      	        	//가입타입을 검사해서 N이면 로그인 아니면 다른걸로 가입햇음
	      	        	String join = service.join_type(email);
	      	        	if(join.equals("G")) {
	      	        		session.setAttribute("memId", email);
	      			        session.setAttribute("access_Token", accessToken);
	      		        	return "/main";
	      	        	}else {
	      	        		model.addAttribute("warn", 1);
	      	        		return "/main";
	      	        	}
	      	      }
	      	  }else if(email == null){
	      	    	return "/user/joinForm";
	      	  }
	              return "/main"; // 인증이 성공한 경우 리디렉션할 페이지
	       } catch (IOException e) {
	              // 예외 처리
	              return "redirect:/error"; // 인증이 실패한 경우 리디렉션할 페이지
	       }
  	}
  	//중복확인 & 추가정보
  	@PostMapping("/check")
  	public @ResponseBody int check(MemberDTO dto, HttpSession session) {
  	    System.out.println(dto);
  	    int count = service.count(dto.getTel());
  	    int check = service.check(dto.getEmail());
  	    System.out.println(count);
  	    int result = 0;

  	    if (count == 1 || check == 1) {
  	        result = 1;
  	        session.invalidate();
  	        
  	    }else if(count == 0 && check == 0){
  	    	result = 0;
  	    	service.insertPro(dto);
  		  	service.insert2(dto.getEmail());
  	        session.setAttribute("memId", dto.getEmail());
  	    }
  	    System.out.println(result);
  	    return result;
  	}
  	
  	@RequestMapping("/telChk")
  	public @ResponseBody String telChk(String tel) {
        Random rand  = new Random(); //랜덤숫자 생성하기 !!
        String numStr = "";
        for(int i=0; i<4; i++) {
            String ran = Integer.toString(rand.nextInt(10));
            numStr+=ran;
        }
        service.telChk(tel, numStr);
        System.out.println(numStr);
        return numStr;
    }	
  	
  	@RequestMapping("/emailChk")
  	public @ResponseBody int emailChk(String email) {
  		int result = service.check(email);
        System.out.println(result);
        return result;
    }
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
    @RequestMapping("/info")
    public String JobDicInfo(HttpServletRequest request, Model model) {
       int seq = -1;
       String strSeq= request.getParameter("job_cd");
       JobDicDetailResponseDTO jobDetail = null;
       if(strSeq!=null) 
          seq = Integer.parseInt(strSeq);
       
       System.out.println("seq == " +seq);
       jobDetail= dao.getJobDicDetail(seq);
       //System.out.println("////////// " + jobDetail);// dto.work
       List<JobDicDetailResponseDTO.Work> workList = jobDetail.getWorkList(); 
       String link = jobDetail.getCertiList().get(0).getLink();
       List<Knowledge> knowledge = jobDetail.getPerform().getKnowledge();
       //Object p = jobDetail.getPerform().getPerform_();

      
      //System.out.println(knowledge);
      //      JobDicDetailResponseDTO.BaseInfo baseInfo = jobDetail.getBaseInfo(); 
//       for(int i=0; i<jobDetail.getWorkList().size(); i++)
//          System.out.println(jobDetail.getWorkList().get(i).getWork());
       model.addAttribute("jobDetail", jobDetail);
       return "/job/description-detail";
    }
    
  
}
