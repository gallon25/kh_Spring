package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.PatientVO;
import vo.VolunteerVO;

public class VolunteerDAO {
	
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//자원봉사 조회
	public List<VolunteerVO> selectVol(){
		List<VolunteerVO> list = sqlSession.selectList("volunteer.vol_list");
		return list;
	}
	
	//상세보기 조회
	public VolunteerVO selectVolOne(int vol_idx) {
		VolunteerVO vo = sqlSession.selectOne("volunteer.vol_one", vol_idx);
		return vo;
	}
	
	//상세보기 조회 (환자 이름)
	public PatientVO selectPatInfo(int pat_idx) {
		PatientVO vo = sqlSession.selectOne("volunteer.pat_info", pat_idx);
		return vo;
	}
	
}
