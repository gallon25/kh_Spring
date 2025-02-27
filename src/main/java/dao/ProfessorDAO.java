package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.ProfessorListVO;
import vo.ProfessorVO;

public class ProfessorDAO {
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//관리자-교수 전체목록
	public List<ProfessorListVO> selectList(){
		List<ProfessorListVO> list = sqlSession.selectList("reservation.professor_list");
		return list;
	}
	
	public List<ProfessorVO> select_professor(String name){
		List<ProfessorVO> list = sqlSession.selectList("pro.professor_list", name);
		return list;
	}
	
	public ProfessorVO select_professor(int pro_idx){
		ProfessorVO vo = sqlSession.selectOne("pro.select_professor", pro_idx);
		return vo;
	}
}
