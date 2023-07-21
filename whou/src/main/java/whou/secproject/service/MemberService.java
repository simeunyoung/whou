package whou.secproject.service;

import java.io.IOException;
import java.util.List;

import org.springframework.http.ResponseEntity;

import whou.secproject.component.MemberDTO;

public interface MemberService {
    public int count(String tel);
    public int check(String email);
    public String join_type(String email);
    public String login(String email);
    public String getEmail(String name, String tel);
    public void insert2(String email);
    public void insertPro(MemberDTO dto);
    public String getAccessToken (String authorize_code);
    public String getUserInfo (String access_Token);
	public ResponseEntity<String> getInfo(String ACCESS_TOKEN) throws IOException;
	public void telChk(String tel, String numStr);
	public List<String> getCerti(String certi);
	public List<String> getMajor(String major);
	public void updateInfo(String combinedCerti, String combinedMajor);
}

