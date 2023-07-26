package whou.secproject.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import whou.secproject.component.JobDicAptdValueListDTO;
import whou.secproject.component.JobDicDetailResponseDTO;
import whou.secproject.component.JobDicListResponseDTO;
import whou.secproject.component.JobDicParamDTO;
import whou.secproject.component.JobDicValueListDTO;
import whou.secproject.component.WhouModelCustomDTO;
import whou.secproject.component.WhouModelDTO;
import whou.secproject.mapper.MemberMapper;
import whou.secproject.repository.JobDicApiDAO;
import whou.secproject.service.JobDicService;
import whou.secproject.service.WhouModelCustomService;
import whou.secproject.service.WhouModelService;

@Controller
@RequestMapping("/job")
public class JobController {
	
	@Autowired
	private JobDicApiDAO dao;
	
	@Autowired
	private JobDicService service;
	
	@Autowired
	private MemberMapper mapperMem;

	@Autowired
	private WhouModelService whouModelService;
	
	@Autowired
	private WhouModelCustomService whouModelCustomService;
	@RequestMapping("/dic")
	public String goJobDic(Model model,HttpServletRequest request) {

		List<JobDicValueListDTO> valueList= service.getSortValue("search_factor");
		List<JobDicAptdValueListDTO> aptdValueList= service.getAptdValue("aptd_factor");
		String clickTabId= request.getParameter("clickTabId");
		
		if(clickTabId==null) clickTabId = "pills-home-tab";
		model.addAttribute("clickTabId", clickTabId);
		model.addAttribute("temaValueList1", valueList.subList(21, 31));
		model.addAttribute("temaValueList2", valueList.subList(31, 41));
		model.addAttribute("aptdValueList", valueList.subList(41, 84));
		model.addAttribute("jobCdList", valueList.subList(0, 10));
		//model.addAttribute("aptdList", valueList.subList(10, 21));
		model.addAttribute("aptdList", aptdValueList);
		JobDicParamDTO jParam = new JobDicParamDTO();
		String jobNm = request.getParameter("jobNM");
		try {
			if(jobNm!=null) 
				jobNm = new String(jobNm.getBytes("ISO-8859-1"), "UTF-8");
			jParam.setSearchJobNm(jobNm);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		model.addAttribute("jobNm", jobNm);
		
		String [] idCheck = request.getParameterValues("id");
		String checkedJson = "null";
		String checkBoxJson = "null";
		String checked []= null;
		ObjectMapper objectMapper = new ObjectMapper();
		if(idCheck!=null) {
			if(clickTabId.equals("pills-home-tab")) jParam.setSearchThemeCode(String.join(",", idCheck));
			else if(clickTabId.equals("pills-profile-tab")) jParam.setSearchAptdCodes(String.join(",", idCheck));
			else if(clickTabId.equals("pills-disabled-tab")) jParam.setSearchJobCd(String.join(",",idCheck));
			try {
				checkedJson = objectMapper.writeValueAsString(idCheck);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}else {
			if(clickTabId.equals("pills-profile-tab")) {
				checked = request.getParameterValues("aptdCheck");
				if(checked==null) checked = request.getParameterValues("aptd");
				if(checked!=null) {
					jParam.setSearchAptdCodes(String.join(",", checked));
					try {
						checkBoxJson = objectMapper.writeValueAsString(checked);
					} catch (JsonProcessingException e) {
						e.printStackTrace();
					}
				}
			}
		}
		String aptd = request.getParameter("aptd");
		if(aptd!=null) model.addAttribute("aptd", aptd);
		model.addAttribute("check", checkBoxJson);
		model.addAttribute("checked", checkedJson);
		
		String pageIndex = request.getParameter("pageIndex");
		if(pageIndex==null) pageIndex = "1";
		jParam.setPageIndex(pageIndex);
		
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageIndex);
		int count = 0;
		//int startRow = (currentPage-1)*pageSize +1;
		//int endRow = currentPage * pageSize;
		//int number = 0;
		
		
		JobDicListResponseDTO dtoList = dao.getJobDicListSorted(jParam);
		count = dtoList.getCount();
		if(count>0) {
			int pageCount = count / pageSize + (count % pageSize==0 ? 0 :1);
			int startPage = (int)(currentPage/10)*10+1;
			int pageBlock = 10;
			int endPage = startPage + pageBlock -1;
			if (endPage > pageCount) endPage = pageCount;
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageBlock", pageBlock);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("jobs", dtoList.getJobs());
		}
		
		model.addAttribute("count", count);
		model.addAttribute("currentPage", currentPage); // currentPage

		return "/job/description";
	}
	
//	@RequestMapping("/search")
//	public String JobDicSearch(HttpServletRequest request) {
//		
//		String pageIndex = request.getParameter("pageIndex");
//		if(pageIndex!=null)
//			pageIndex = "1";
//		
//		JobDicParamDTO jParam = new JobDicParamDTO();
//		
//		jParam.setPageIndex(pageIndex);
//		jParam.setSearchJobNm(request.getParameter("jobNM"));
//		
//		dao.getJobDicListSorted(jParam);
//		return "/job/description";
//	}
//	
//	@RequestMapping("/list")
//	public String JobDicListSorted(HttpServletRequest request) {
//		
//		JobDicParamDTO jParam = new JobDicParamDTO();
//		
//		String pageIndex = request.getParameter("pageIndex");
//		
//		if(pageIndex!=null) pageIndex = "1";
//		jParam.setPageIndex(pageIndex);
//		
//		jParam.setSearchJobNm(request.getParameter("jobNM"));
//		String strs = request.getParameter("field");
//		System.out.println(strs);
//		
//		dao.getJobDicListSorted(jParam);
//		return "/job/description";
//	}
	
	@RequestMapping("/info")
    public String JobDicInfo(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String memId = (String)session.getAttribute("memId");
       int seq = -1;
       String strSeq= request.getParameter("job_cd");
       JobDicDetailResponseDTO jobDetail = null;
       if(strSeq!=null) 
          seq = Integer.parseInt(strSeq);
       
       // 직업분류별 모델
       int modelNum = whouModelService.selectSortValue(seq);
       WhouModelDTO whouModel = whouModelService.selectModel(modelNum);
       if(whouModel.getColor() == null) {whouModel.setColor("noColor");}
       
       System.out.println("seq == " +seq);
       jobDetail= dao.getJobDicDetail(seq);
       
       String data = jobDetail.getIndicatorChart().get(0).getIndicator_data();
       String major_data = jobDetail.getMajorChart().get(0).getMajor_data();
       String edu_data = jobDetail.getEduChart().get(0).getChart_data();
       System.out.println(data);

       List<String> indicator = new ArrayList<String>();
       List<String> major = new ArrayList<String>();
       List<String> edu = new ArrayList<String>();
       
       String[] dataParts = data.split(",");
       String[] major_dataParts = major_data.split(",");
       String[] edu_dataParts = edu_data.split(",");
       
       indicator.addAll(Arrays.asList(dataParts));
       major.addAll(Arrays.asList(major_dataParts));
       edu.addAll(Arrays.asList(edu_dataParts));
       
       String indicatorData = "null";
       String majorData = "null";
       String eduData = "null";
       ObjectMapper objectMapper = new ObjectMapper();
       try {
          indicatorData = objectMapper.writeValueAsString(indicator);
          majorData = objectMapper.writeValueAsString(major);
          eduData = objectMapper.writeValueAsString(edu);
       } catch (JsonProcessingException e) {
           e.printStackTrace();
       }
      
      boolean contain = false;
      String temp = "";
      if(memId != null) {
    	  WhouModelCustomDTO modelColor = whouModelCustomService.customModel(memId); // 커스텀한 모델 색
    	  model.addAttribute("modelColor",modelColor);
    	  temp = mapperMem.getBook(memId);
    	  if(temp!=null) {
    		  String [] arr = temp.split(",");
    		  for (String str : arr) {
    			  if (str.equals(strSeq)) {
    				  contain = true;
    			  }
    		  }
    	  }
      }
       
       model.addAttribute("contain", contain);
       model.addAttribute("jobDetail", jobDetail);
       model.addAttribute("indicatorData", indicatorData);
       model.addAttribute("majorData", majorData);
       model.addAttribute("eduData", eduData);
       model.addAttribute("model", whouModel);
       return "/job/description-detail";
    }
	
//	@RequestMapping("/ijd")
//	public String insertJobDetail() {
//		JobDicParamDTO jparam = new JobDicParamDTO();
//		JobDicListResponseDTO dto = null;
//		JobDicDetailResponseDTO jddrdto =null;
//		for(int i = 1; i < 55; i++) {
//			jparam.setPageIndex(i+"");
//			dto = dao.getJobDicListSorted(jparam);
//			for(int j = 0; j < dto.getJobs().size(); j++) {
//				int jcd= dto.getJobs().get(j).getJob_cd();
//				jddrdto =  dao.getJobDicDetail(jcd);
//				service.insert(jddrdto);
//				try {
//					Thread.sleep(1000);
//				} catch (InterruptedException e) {
//					e.printStackTrace();
//				}
//			}
//		}
//		
////		jddrdto =  dao.getJobDicDetail(10040);
////		service.insert(jddrdto);
//		return null;
//	}
	
//	@RequestMapping("/aa")
//	public String JobDic() {
//		for(int j = 0; j < 10; j++) {
//			JobDicParamDTO jParam = new JobDicParamDTO();
//			jParam.setSearchJobCd(j+"");
//			JobDicListResponseDTO jdlrDTO = dao.getJobDicListSorted(jParam);
//			int a = jdlrDTO.getCount()/10;
//			System.out.println(a);
//			String [] list = new String[jdlrDTO.getCount()];
//			for(int i = 1; i <= a+1; i++) {
//				System.out.println(i);
//				jParam.setPageIndex(i+"");
//				jdlrDTO = dao.getJobDicListSorted(jParam);
//				List<JobDicListResponseDTO.Jobs> jobs= jdlrDTO.getJobs();
//				for(int k = 0 ; k < jobs.size(); k++) {
//					list [((i-1)*10)+k] = jobs.get(k).getJob_cd()+"";
//				}
//			}
//			String str = String.join(",", list);
//			System.out.println(str);
//			service.insertJCC(j, str);
//		}
//		return null;
//	}
	
}
