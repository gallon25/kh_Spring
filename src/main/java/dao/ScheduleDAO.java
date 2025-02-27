package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.ScheduleVO;

public class ScheduleDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<ScheduleVO> pro_schedule(int pro_idx){
		List<ScheduleVO> list = sqlSession.selectList("sche.abledays", pro_idx);
		return list;
	}

}
