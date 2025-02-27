package controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import dao.PatBoardDAO;
import dao.VolcommentDAO;
import dao.VolunteerDAO;
import util.Paging;
import vo.PatBoardVO;
import vo.PatientVO;
import vo.VolcommentVO;
import vo.VolunteerVO;

//고객참여 컨트롤러
@Controller
public class JoinController {
	
	PatBoardDAO patBoard_dao;
	public void setPatBoard_dao(PatBoardDAO patBoard_dao) {
		this.patBoard_dao = patBoard_dao;
	}
	
	VolunteerDAO volunteer_dao;
	public void setVolunteer_dao(VolunteerDAO volunteer_dao) {
		this.volunteer_dao = volunteer_dao;
	}
	
	VolcommentDAO volcomment_dao;
	public void setVolcomment_dao(VolcommentDAO volcomment_dao) {
		this.volcomment_dao = volcomment_dao;
	}
	
	
	@Autowired
	ServletContext application;
	
	
	// ------------------------------ 감사합니다 (조회) --------------------------------------
	//감사합니다 리스트 조회 
	@RequestMapping("/join_thanks_list.do")
	public String thanks_list_form(Model model, Integer page) {
		
		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
		}
		
		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		
		List<PatBoardVO> list = patBoard_dao.selectThanks( map );
		
		int row_total = patBoard_dao.getRowTotal( map );
		
		String pageMenu = Paging.getPaging(
				"join_thanks_list.do", nowPage, row_total,
				Common.Board.BLOCKLIST,
				Common.Board.BLOCKPAGE );
		
		model.addAttribute("list", list);
		
		model.addAttribute("pageMenu", pageMenu);
		
		return Common.join.VIEW_PATH + "thanks_list.jsp";
	}
	
	
	//감사합니다 글 작성 페이지 전환
	@RequestMapping("/join_thanks_insert_form.do")
	public String thanks_insert_form() {
		return Common.join.VIEW_PATH + "thanks_insert.jsp";
	}
	
	
	
	// ----------------------------- 건의합니다 (추가 페이지로) ------------------------------------
	//건의합니다 작성 페이지로 전환
	@RequestMapping("/join_compl_insert_form.do")
	public String complaint_insert_form() {
		return Common.join.VIEW_PATH + "complaint_insert.jsp";
	}
	
	
	
	// ---------------------------- 감사합니다, 건의합니다 (추가)------------------------------------
	//감사, 건의합니다 추가
	@RequestMapping("/join_board_insert.do")
	public String thanks_insert(@ModelAttribute PatBoardVO vo, String board_phone,
								String board_phone_1, String board_phone_2,
								String board_email1, String board_email2,
								String page) {
		
	    
		String fullPhone = board_phone+"-" +board_phone_1+"-"+board_phone_2;
		String fullEmail = board_email1+"@"+board_email2;
		
		vo.setBoard_phone(fullPhone);
		vo.setBoard_email(fullEmail);
		
		//사진 파일 업로드
		String webPath = "resources/uploadThanksCompl/"; //상대경로
		String savePath = application.getRealPath(webPath); //절대경로
		
		System.out.println("--- 감사합니다 절대경로 : " + savePath);
		
		//업로드를 위한 파일 정보 
		MultipartFile photo = vo.getPhoto();
		String filename = "no_file";
		
		if( !photo.isEmpty() ) {
			filename = photo.getOriginalFilename();
			
			//저장할 파일 경로
			File saveFile = new File(savePath, filename);
			if( !saveFile.exists() ) {
				//절대경로 존재하지 않는다면 생성
				saveFile.mkdirs();
			}else {
				//파일 동일명 설정
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(savePath, filename);
			}
			
			//절대경로에 파일 생성
			try {
				photo.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			} 
			
		}else {
			filename = "no_file";
		}
		
		vo.setBoard_file(filename);
		
		
		int res = patBoard_dao.insertJoin(vo);
		
		System.out.println("----res : "+ res);
		
		String redirectUrl = "";
		
		if( "thanks".equals(vo.getBoard_type()) ) {				
			redirectUrl = "/join_thanks_list.do?page="+page;
		}else if( "complaint".equals(vo.getBoard_type()) ) {
			redirectUrl = "/join_compl_insert_form.do?page"+page;
		}
		
		return "redirect:" + redirectUrl;
		
	}
	
	
	
	// ------------------------------ 자원봉사 --------------------------------------
	//자원봉사 조회
	@RequestMapping("/join_volunteer_list.do")
	public String volunteer_list_form(Model model, int pat_idx) {
		List<VolunteerVO> list = volunteer_dao.selectVol();
		
		model.addAttribute("list", list);
		
		return Common.join.VIEW_PATH + "volunteer_list.jsp?pat_idx="+pat_idx;
	}
	
	//자원봉사 상세보기 페이지로 전환
	@RequestMapping("/join_volunteer_view.do")
	public String volunteer_view_form(Model model, Integer vol_idx, Integer pat_idx) {
		
		PatientVO patVO = volunteer_dao.selectPatInfo(pat_idx);
		VolunteerVO volVO = volunteer_dao.selectVolOne(vol_idx);
		
		//댓글 조회
		List<VolcommentVO> comm_list = volcomment_dao.selectVolComm(vol_idx);
		
		
		model.addAttribute("vo", volVO);
		model.addAttribute("patVO", patVO);
		model.addAttribute("comm_list", comm_list);
		
		return Common.join.VIEW_PATH + "volunteer_view.jsp";
	}
	
	
	// ------------------------------ 자원봉사 댓글 --------------------------------------
	@RequestMapping("join_volcomm_list.do")
	@ResponseBody
	public List<VolcommentVO> comment_list(Integer vol_idx) {
		List<VolcommentVO> comm_list = volcomment_dao.selectVolComm(vol_idx);
		
		return comm_list;
	}
	
	
	
	  //자원봉사 댓글 추가
	 
	  @RequestMapping("join_volcomment_insert.do")
	  
	  @ResponseBody public String comment_insert(VolcommentVO vo) {
	  
	  int res = volcomment_dao.insert(vo);
	  
	  System.out.println("res: " + res);
	 
	  String result = "fail"; if( res == 1 ) { result = "succ"; }
	  
	  String resultStr = String.format("[{'result':'%s'}]", result); return
	  resultStr; }
	 
	
}





