package controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.BannerDAO;
import dao.LoginDAO;
import dao.MypageDAO;
import dao.NoticeDAO;
import service.MailSendService;
import vo.BannerVO;
import vo.NoticeVO;
import vo.PatientVO;

@Controller
public class LoginController {

	@Autowired
	HttpSession session;

	LoginDAO login_dao;
	public void setLogin_dao(LoginDAO login_dao) {
		this.login_dao = login_dao;
	}

	BannerDAO banner_dao;
	public void setBanner_dao(BannerDAO banner_dao) {
		this.banner_dao = banner_dao;
	}

	MypageDAO mypage_dao;
	public void setMypage_dao(MypageDAO mypage_dao) {
		this.mypage_dao = mypage_dao;
	}
	
	NoticeDAO notice_dao;
	public void setNotice_dao(NoticeDAO notice_dao) {
		this.notice_dao = notice_dao;
	}

	MailSendService mss;
	public void setMss(MailSendService mss) {
		this.mss = mss;
	}

	//기본 메인화면
	@RequestMapping(value = {"/", "main.do"})
	public String main_start(Model model, Integer pat_idx) {
		
		int now_pat_idx = 0;

		if(pat_idx != null) {
			now_pat_idx = pat_idx; 
		}
		
		//배너 이미지 담은 list들 DB에서 가져오기
		List<BannerVO> list_banner = banner_dao.selectBanner();
		
		//공지사항 담은 list들 DB에서 가져오기
		List<NoticeVO> list_notice = notice_dao.selectNotList();
		
		model.addAttribute("images", list_banner);
		model.addAttribute("notices", list_notice);
		return Common.main.VIEW_PATH + "MainPage_User.jsp";
	}

	//로그인 페이지
	@RequestMapping("login_page.do")
	public String login() {
		return Common.login.VIEW_PATH + "login.jsp";
	}

	//회원가입 페이지
	@RequestMapping("register_page.do")
	public String register() {
		return Common.login.VIEW_PATH + "register.jsp";
	}

	//환자정보 insert -----------------------------------------------------------------------------
	@RequestMapping("register_patient_insert.do")
	public String insertPatient(PatientVO vo, String pat_email_addr, 
			String pat_phone1_1, String pat_phone1_2,
			String pat_phone2_1, String pat_phone2_2) {

		String fullEmail = vo.getPat_email() + "@" + pat_email_addr;
		String fullPhone = vo.getPat_phone() +  "-" + pat_phone1_1 +  "-" +  pat_phone1_2;
		String fullPhone2 = vo.getPat_phone2() +  "-" +  pat_phone2_1 +  "-" +  pat_phone2_2;

		vo.setPat_email(fullEmail);
		vo.setPat_phone(fullPhone);
		vo.setPat_phone2(fullPhone2);

		int res = login_dao.insertPatient(vo);
		System.out.println("insert 결과 : " + res);
		return "redirect:main.do";
	} //insertPatient

	//환자정보 select (아이디 중복체크를 위한) ----------------------------------------------------------
	@RequestMapping("register_check_id.do")
	@ResponseBody
	public String checkId(String pat_id) {
		PatientVO vo = login_dao.selectPatientById(pat_id);

		String result = "no";
		if(vo != null) { //해당 아이디와 동일한 환자정보가 존재하는 경우
			result = "yes";
		}

		String resultStr = String.format("[{'result' : '%s'}]", result);
		return resultStr;
	} //checkId

	//회원정보 select (로그인 시 아이디, 비밀번호 체크를 위한)  ----------------------------------------------------------
	@RequestMapping("login_chk_correct.do")
	@ResponseBody
	public String login(String pat_id, String pat_pwd) {
		//아이디가 존재하는지 체크
		PatientVO vo1 = login_dao.selectPatientById(pat_id); 

		//비밀번호가 일치하는지 체크
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pat_id", pat_id);
		map.put("pat_pwd", pat_pwd);
		PatientVO vo2 = login_dao.selectPatient(map);

		String result = "id_not_exist";
		int pat_idx = 0;
		if(vo2 != null) { //아이디와 비밀번호가 모두 일치하는 경우
			result = "login_success";
			//아이디에 해당하는 pat_idx 가져오기
			pat_idx = login_dao.selectPatientIdx(pat_id);
		} else if (vo1 != null) { //비밀번호는 일치하지 않지만 아이디는 일치하는 경우
			result = "id_exist";
		}

		//세션스코프에 로그인한 회원 정보 저장
		session.setAttribute("patient", vo2);
		
		//세션 유지시간(30분(기존) -> 1시간)
		session.setMaxInactiveInterval(3600);
		
		String resultStr = 
				String.format("[{'result' : '%s'}, {'pat_idx' : '%d'}]", result, pat_idx);
		return resultStr; 
	}

	//로그아웃 --------------------------------------------------------------------------------------------
	@RequestMapping("logout.do")
	@ResponseBody
	public String logout(String pat_idx) {
		pat_idx = "";
		session.removeAttribute("patient"); // 세션에서 "patient" 속성 제거
		return "";
	}

	//아이디 찾기 ----------------------------------------------------------------------------------------------
	@RequestMapping("login_find_id_form.do")
	public String findIdForm() {
		return Common.login.VIEW_PATH + "find_id.jsp";
	}

	@RequestMapping("login_find_id.do")
	@ResponseBody
	public String findId(String pat_name, String pat_email) {
		Map<String, String> map = new HashMap<String, String>();

		map.put("pat_name", pat_name);
		map.put("pat_email", pat_email);

		String result = "";

		//1) 존재하는 회원인지 조회
		PatientVO vo = login_dao.selectPatientByEmailAndName(map);
		String id = "";
		if(vo == null) { //존재하지 않는 회원인 경우
			result = "no_patient";
		}

		//2) 이메일 전송하기 (존재하는 회원인 경우)
		else { 
			result = mss.sendNumberEmail(pat_email);
			id=vo.getPat_id();
		}

		String resultStr = String.format("[{'result' : '%s'}, {'id' : '%s'}]", result, id);
		return resultStr; 
	}
	@RequestMapping("login_find_id_page.do")
	public String findIdPage(String pat_id) {
		return Common.login.VIEW_PATH + "find_id_page.jsp";
	}

	//비밀번호 찾기 ----------------------------------------------------------------------------------------------
	@RequestMapping("login_find_pwd_form.do")
	public String findPwdForm() {
		return Common.login.VIEW_PATH + "find_pwd.jsp";
	}

	@RequestMapping("login_find_pwd.do")
	@ResponseBody
	public String findPwd(String pat_id, String pat_email) {
		Map<String, String> map = new HashMap<String, String>();

		map.put("pat_id", pat_id);
		map.put("pat_email", pat_email);

		String result = "";

		//1) 존재하는 회원인지 조회
		PatientVO vo = login_dao.selectPatientByEmailAndId(map);
		int idx = 0;
		if(vo == null) { //존재하지 않는 회원인 경우
			result = "no_patient";
		}

		//2) 이메일 전송하기 (존재하는 회원인 경우)
		else { 
			result = mss.sendNumberEmail(pat_email);
			idx = vo.getPat_idx();
		}

		String resultStr = String.format("[{'result' : '%s'}, {'idx': '%d'}]", result, idx);
		return resultStr; 
	}

	//비밀번호 재설정 페이지로 이동
	@RequestMapping("login_find_pwd_page.do")
	public String findPwdPage(String pat_idx) {
		return Common.login.VIEW_PATH + "find_pwd_page.jsp?pat_idx=" + pat_idx;
	}

	//비밀번호 재설정
	@RequestMapping("login_update_pwd.do")
	public String updatePwd(String pwd_new, int pat_idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pwd_new", pwd_new);
		map.put("pat_idx", pat_idx);

		int res = mypage_dao.updatePatientPwd(map);
		System.out.println("pwd update 결과 : " + res);
		return "redirect:login_page.do"; 
	}

}


