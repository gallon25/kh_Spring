package vo;

/*
drop table professor;
drop sequence pro_idx_seq;
 
--교수테이블
CREATE TABLE professor (
		pro_idx	 	NUMBER(3)	 NOT NULL,
		dept_idx	 	NUMBER(10)	 NULL,
		pro_name 	VARCHAR2(30)	 NULL,
		pro_field	 	CLOB	 	NULL,
		pro_file 		VARCHAR2(100) 	NULL
);

--시퀀스
create sequence pro_idx_seq;
	
--DB구축(세브란스)
insert into professor values(
	pro_idx_seq.nextVal,
	1, --호흡기내과
	'강영애',
	'폐결핵, 내성결핵, 비결핵항산균',
	'prof_image.png'
);
insert into professor values(
	pro_idx_seq.nextVal,
	4, --내분비내과
	'김다함',
	'갑상선암, 갑상선 결절, 갑상선종, 갑상선 기능항진증, 갑상선 기능저하증, 갑상선염, 일시적 갑상선 기능 이상',
	'prof_image.png'
);
insert into professor values(
	pro_idx_seq.nextVal,
	8, --흉부외과
	'이진구',
	'폐이식, 폐암, 흉선종 및 근무력증, 종격동 종양, 간질성 폐질',
	'prof_image.png'
);
insert into professor values(
	pro_idx_seq.nextVal,
	15, --정신건강의학과
	'강지인',
	'정신신체장애, 신경성신체증상, 질병불안장애, 공황장애',
	'prof_image.png'
);
*/

public class ProfessorVO {
	public int pro_idx, dept_id;
	public String pro_name, pro_field, pro_file;

	public int getPro_idx() {
		return pro_idx;
	}
	public void setPro_idx(int pro_idx) {
		this.pro_idx = pro_idx;
	}
	public int getDept_id() {
		return dept_id;
	}
	public void setDept_id(int dept_id) {
		this.dept_id = dept_id;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	public String getPro_field() {
		return pro_field;
	}
	public void setPro_field(String pro_field) {
		this.pro_field = pro_field;
	}
	public String getPro_file() {
		return pro_file;
	}
	public void setPro_file(String pro_file) {
		this.pro_file = pro_file;
	}
}
