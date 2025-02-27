package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.BannerVO;

public class BannerDAO {
	SqlSession sqlSession;
	public void setSqlSesson(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//배너 모든 이미지 조회(메인화면 띄우기)
	public List<BannerVO> selectBanner() {
		List<BannerVO> list = sqlSession.selectList("banner.banner_list");
		return list;
	}
	
	//배너 이미지 추가
	public int insertBanner(BannerVO vo) {
		int res = sqlSession.insert("banner.banner_insert",vo);
		return res;
	}
	
	//배너 이미지 삭제
	public int deleteBanner(int banner_idx) {
		int res = sqlSession.delete("banner.banner_delete", banner_idx);
		return res;
	}
	
}
