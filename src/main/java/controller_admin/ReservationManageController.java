package controller_admin;




import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.LoginDAO;
import dao.ProfessorDAO;
import dao.ReservationDAO;
import util.Paging_Design_Admin_Calling;
import vo.ManageReservationVO;
import vo.ProfessorListVO;
import vo.ReservationVO;

@Controller
public class ReservationManageController {

	ReservationDAO reservation_dao;
	public void setReservation_dao(ReservationDAO reservation_dao) {
		this.reservation_dao = reservation_dao;
	}

	LoginDAO login_dao;
	public void setLogin_dao(LoginDAO login_dao) {
		this.login_dao = login_dao;
	}

	ProfessorDAO professor_dao;
	public void setProfessor_dao(ProfessorDAO professor_dao) {
		this.professor_dao = professor_dao;
	}

	//관리자-예약관리 페이지로 이동(모든예약 조회)------------------------------------------------------------------------------
	@RequestMapping("reservation_ManagePage.do")
	public String reservation_ManagePage(Model model, String search, Integer page) {

		int nowPage = 1;

		//정상적으로 페이지 값을 받은 경우
		if(page != null) {
			nowPage = page; 
		}

		//한 페이지에 표시할 게시글의 시작번호와 끝번호를 계산
		int start = (nowPage - 1) * Common.reservation.BLOCKLIST + 1;
		int end = start + Common.reservation.BLOCKLIST - 1;

		//start와 end를 map에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);

		List<ManageReservationVO> res_list = null;

		//페이지 정보를 담은 map을 가지고 모든 회원의 예약들을 조회
		res_list = reservation_dao.reservation_selectList(map);

		//전체 게시글 수
		int row_total = reservation_dao.reservationCount(map); 

		//페이지메뉴 생성
		String pageMenu = Paging_Design_Admin_Calling.getPaging(
				"reservation_ManagePage.do", nowPage, row_total,
				Common.reservation.BLOCKLIST, Common.reservation.BLOCKPAGE);

		model.addAttribute("pageMenu", pageMenu);
		model.addAttribute("res_list", res_list);

		return Common.manageReservation.VIEW_PATH + "reservation_manage_page.jsp";
	}

	//관리자-선택한 하나의 예약 조회------------------------------------------------------------------------------
	@RequestMapping("reservation_update_page.do")
	public String reservation_update_page(Model model, int res_idx, 
			String pat_name, String pro_name, String dept_name) {

		//예약 번호로 예약 테이블 정보들 가져오기
		ReservationVO res_vo = reservation_dao.selectOne(res_idx);

		model.addAttribute("res_vo", res_vo);
		return Common.manageReservation.VIEW_PATH + "reservation_update_page.jsp?pat_name=" + pat_name 
				+ "&pro_name=" + pro_name + "&dept_name=" + dept_name;
	}

	//관리자-교수목록 불러오기------------------------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="professor_list.do", produces = "application/json; charset=utf8")
	public List<ProfessorListVO> professor_list() {
	    List<ProfessorListVO> list = professor_dao.selectList();
	    return list; // JSON으로 반환
	}
	
	//관리자-예약 수정하기------------------------------------------------------------------------------
	@RequestMapping("reservation_update.do")
	public String reservation_update(int res_idx, int pro_idx, String res_time, int res_chk, int pay_chk) {
		
		ReservationVO vo = new ReservationVO();
		vo.setRes_idx(res_idx);
		vo.setPro_idx(pro_idx);
		vo.setRes_time(res_time);
		vo.setRes_chk(res_chk);
		vo.setPay_chk(pay_chk);
		
		int res = reservation_dao.manage_update(vo);
		
		return "redirect:reservation_ManagePage.do";
	}
	
	//관리자-예약 삭제하기------------------------------------------------------------------------------
	@RequestMapping("reservation_delete.do")
	@ResponseBody
	public String reservation_delete(int res_idx) {
		//예약번호로 해당 예약 삭제하기
		int del_res = reservation_dao.delete_res(res_idx);
		
		String result = "fail";
		if(del_res > 0) {
			result = "succ";
		}
		
		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}
}







