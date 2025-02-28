package vo;

import org.springframework.web.multipart.MultipartFile;

public class BannerVO {
	public int banner_idx;
	public String banner_name, banner_file;
	private MultipartFile photo;
	
	public int getBanner_idx() {
		return banner_idx;
	}
	public void setBanner_idx(int banner_idx) {
		this.banner_idx = banner_idx;
	}
	public String getBanner_name() {
		return banner_name;
	}
	public void setBanner_name(String banner_name) {
		this.banner_name = banner_name;
	}
	public String getBanner_file() {
		return banner_file;
	}
	public void setBanner_file(String banner_file) {
		this.banner_file = banner_file;
	}
	public MultipartFile getPhoto() {
		return photo;
	}
	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}

}
