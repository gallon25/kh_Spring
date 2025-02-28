package controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import dao.NoticeDAO;
import dao.PatBoardDAO;
import vo.NoticeVO;

@Controller
public class InfoController { 
	
	NoticeDAO notice_dao;
	public void setNotice_dao(NoticeDAO notice_dao) {
		this.notice_dao = notice_dao;
	}
	
	
	//층별 안내
	@RequestMapping("floor_info.do")
	public String floorInfo() {
		return Common.info.VIEW_PATH + "floor_info.jsp";
	}
	
	//주차 안내
	@RequestMapping("parking_info.do")
	public String parkingInfo() {
		return Common.info.VIEW_PATH + "parking_info.jsp";
	}
	
	//오시는 길 
	@RequestMapping("/way_info.do")
	public String wayinfo() {
		return Common.info.VIEW_PATH + "way_info.jsp";
	}
	
	// ------------------------ 공지사항 ---------------------
	//공지사항 조회 페이지로 전환
	@RequestMapping("/info_notice_list.do")
	public String hos_notice_form(Model model) {
		List<NoticeVO> list = notice_dao.selectNotList();
		model.addAttribute("list", list);
		
		return Common.info.VIEW_PATH + "hos_notice.jsp";
	}
	
	//공지사항 상세보기 페이지로 전환
	@RequestMapping("/info_notice_view.do")
	public String hos_notice_view(Model model, Integer not_idx) {
		NoticeVO vo = notice_dao.selectNotOne(not_idx);
		model.addAttribute("vo", vo);
		
		return Common.info.VIEW_PATH + "hos_notice_view.jsp";
	}
	
	
	
}


