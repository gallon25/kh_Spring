package vo;

/*
--교수 진료 일정 테이블
CREATE TABLE pro_able_days (
    pro_idx NUMBER(10) NOT NULL,   -- 교수 ID
    weekday      NUMBER(1)  NOT NULL,  -- 요일 (1: 월요일, 2: 화요일, ...)
    PRIMARY KEY (pro_idx, weekday)
);

*/

public class ScheduleVO {
	private int pro_idx, weekday;
	
	public ScheduleVO() {
	}
	public int getPro_idx() {
		return pro_idx;
	}

	public void setPro_idx(int pro_idx) {
		this.pro_idx = pro_idx;
	}

	public int getWeekday() {
		return weekday;
	}

	public void setWeekday(int weekday) {
		this.weekday = weekday;
	}
	// toString 메서드 (디버깅 용도)
    @Override
    public String toString() {
        return "ScheduleVO{" +
                "pro_Idx=" + pro_idx +
                ", weekday=" + weekday +
                '}';
    }

}
