package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.VolcommentVO;

public class VolcommentDAO {
	
	SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//댓글 조회
	public List<VolcommentVO> selectVolComm(int vol_idx) {
		List<VolcommentVO> list = sqlSession.selectList("volcomment.comm_list", vol_idx);
		return list;
	
	}
	
	//댓글 추가
	public int insert( VolcommentVO vo) {
		int res = sqlSession.insert("volcomment.insert_comm", vo);
		return res;
	}
	
	
	
}
