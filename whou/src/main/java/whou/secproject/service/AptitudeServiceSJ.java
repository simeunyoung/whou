package whou.secproject.service;

import java.util.List;

import whou.secproject.component.AptitudeTestTemporarySaveDTO;
import whou.secproject.component.AptitudeTestValueDTOSJ;

public interface AptitudeServiceSJ {
	public AptitudeTestValueDTOSJ testCrawling(String testURL, String qnum); //검사 결과를 크롤링
	public void crawlingInsert(AptitudeTestValueDTOSJ dto); //크롤링한 검사 결과를 DB에 저장
	public List<String> reportView(String qnum, AptitudeTestValueDTOSJ dto); //크롤링 결과 출력할 수 있게 list로 가공
	public void temporarySaveInsert(List<String> answers, AptitudeTestTemporarySaveDTO dto, String qnum); //임시 저장
	
	public List<AptitudeTestValueDTOSJ> getRecentTest(AptitudeTestValueDTOSJ dto); //검사 메인의 검사횟수 및 최근검사일
	public List<AptitudeTestTemporarySaveDTO> getTemporarySave(AptitudeTestTemporarySaveDTO dto); //임시저장한 값
}