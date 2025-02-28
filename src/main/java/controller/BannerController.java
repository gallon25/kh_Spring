package controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import dao.BannerDAO;
import vo.BannerVO;

@Controller
public class BannerController {

	@Autowired 
	ServletContext app;

	BannerDAO banner_dao;
	public void setBanner_dao(BannerDAO banner_dao) {
		this.banner_dao = banner_dao;
	}

	//배너 이미지 추가 페이지로 이동
	@RequestMapping("insert_banner_page.do")
	public String insert_banner_page() {
		return Common.main.VIEW_PATH + "Insert_Banner_Page.jsp";
	}

	//배너 이미지 추가
	@RequestMapping("insert_banner.do")
	public String insert_banner(BannerVO vo, Model model, int pat_idx) {
		String fake_path = "/resources/upload/"; //상대경로
		String real_path = app.getRealPath(fake_path); //절대경로
		System.out.println(real_path);
		
		//업로드를 위한 파일정보
		MultipartFile photo = vo.getPhoto();
		String filename = "no_file";

		if(!photo.isEmpty()) {
			filename = photo.getOriginalFilename();
			//저장할 파일의 경로
			File saveFile = new File(real_path, filename);
			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}else {
				//동일한 이름의 파일이 존재한다면 현재 업로드 시간을 붙여서 방지
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s", time, filename);
				saveFile = new File(real_path, filename);
			}
			//파일을 절대경로에 생성
			try {
				photo.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace(); //에러 띄워주기
			} 
		}//if
		
		vo.setBanner_name(vo.banner_name);
		vo.setBanner_file(filename);
		
		//추가할 사진과 이름을 담은 vo를 dao에 보냄
		int res = banner_dao.insertBanner(vo);
		
		//관리자 idx가지고 main.do로 돌아감 
		return "redirect:main.do?pat_idx=" + pat_idx;
	}
	
	//배너 이미지 삭제 페이지로 이동(팝업)
	@RequestMapping("delete_banner_page.do")
	public String delete_banner_page(Model model) {
		
		//각 배너의 이름을 팝업창에 띄워주기 위해 DB에 접근해서 배너 list가져오기
		List<BannerVO> list = banner_dao.selectBanner();
		model.addAttribute("banner", list);
		
		return Common.main.VIEW_PATH + "Delete_Banner_Page.jsp";
	}
	
	//배너 삭제
	@RequestMapping("delete_banner.do")
	@ResponseBody
	public String delete_banner(int banner_idx, String banner_file) {
		
		int res = banner_dao.deleteBanner(banner_idx);
		
		String fake_path = "/resources/upload/";
		String real_path = app.getRealPath(fake_path);
		
		//절대경로에 있는 실제 이미지 파일 삭제
		File deleteFile = new File(real_path, banner_file);
		if(deleteFile.exists()) {
			deleteFile.delete();
		}
		
		String result = "fail";
		if(res > 0) {
			result = "succ";
		}
		
		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;
	}
	
	
	
}




