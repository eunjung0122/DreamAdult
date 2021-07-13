package test.study.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.study.dto.StudyDto;
import test.util.DbcpBean;

public class StudyDao {
	private static StudyDao dao;
	private StudyDao() {}
	public static StudyDao getInstance() {
		if(dao==null) {
			dao=new StudyDao();
		}
		return dao;
	}
	
	public List<StudyDto> getLikeMaxList(StudyDto dto){
		List<StudyDto> list=new ArrayList<StudyDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *" + 
					"FROM" + 
					"	(SELECT result1.*, ROWNUM AS rnum" + 
					"	FROM" + 
					"		(SELECT DISTINCT board_study.num, count(*)OVER(PARTITION BY board_study.num) AS cnt, title," + 
					"		board_study.nick, TO_CHAR(board_study.regdate,'YYYY.MM.DD')regdate, grade" + 
					"		FROM board_study INNER JOIN studylike" + 
					"		ON studylike.num = board_study.num" + 
					"		INNER JOIN users" + 
					"		ON board_study.writer = users.id" + 
					"		WHERE liked ='yes'" + 
					"		ORDER BY cnt DESC) result1)" + 
					" WHERE rnum<=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setInt(1, dto.getEndRowNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			while (rs.next()) {
				StudyDto dto2=new StudyDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setTitle(rs.getString("title"));
				dto2.setNick(rs.getString("nick"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setGrade(rs.getString("grade"));
				list.add(dto2);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return list;
	}
	
	
	public List<StudyDto> getMyList(StudyDto dto){
		List<StudyDto> list=new ArrayList<StudyDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ " FROM"
					+ "	(SELECT result1.*, ROWNUM AS rnum"
					+ " FROM"
					+ "	(SELECT num,B.nick,title,viewCount,TO_CHAR(B.regdate,'YYYY.MM.DD')regdate,category" + 
					"	FROM BOARD_STUDY B,USERS U" + 
					"	WHERE B.WRITER=U.ID AND WRITER=?"
					+ " ORDER BY num DESC) result1)"
					+ " WHERE rnum>=? AND rnum<=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getWriter());
			pstmt.setInt(2, dto.getStartRowNum());
			pstmt.setInt(3, dto.getEndRowNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			while (rs.next()) {
				StudyDto dto2=new StudyDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setNick(rs.getString("nick"));
				dto2.setTitle(rs.getString("title"));
				dto2.setViewCount(rs.getInt("viewcount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setCategory(rs.getString("category"));
				list.add(dto2);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return list;
	}
	
	public int getMyCount(StudyDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS count"
					+ " FROM BOARD_STUDY B, USERS U" + 
					"	WHERE B.WRITER=U.ID AND WRITER=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getWriter());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				count=rs.getInt("count");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return count;
	}
	

	//학습공부 글 하나의 정보를 리턴하는 메소드
	public StudyDto getData(int num) {
		StudyDto dto=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT writer, nick, title, content, viewCount, regdate, category"
					+ " FROM board_study"
					+ " WHERE num=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, num);
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if (rs.next()) {
				dto=new StudyDto();
				dto.setNum(num);
				dto.setWriter(rs.getString("writer"));
				dto.setNick(rs.getString("nick"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewCount(rs.getInt("viewCount"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setCategory(rs.getString("category"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	
	//학습공부 글 삭제하는 메소드
	   public boolean delete(int num) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      int flag = 0;
	      try {
	         conn = new DbcpBean().getConn();
	         //실행할 sql문 작성
	         String sql = "DELETE FROM board_study"
	               + " WHERE num=?";
	         pstmt = conn.prepareStatement(sql);
	         //?에 바인딩 할 내용이 있으면 여기서 바인딩
	         pstmt.setInt(1, num);
	         //insert or update or delete 문 수행하고 변화된 row의 갯수 리턴 받기
	         flag = pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	            if (pstmt != null)
	               pstmt.close();
	            if (conn != null)
	               conn.close();
	         } catch (Exception e) {
	         }
	      }
	      if (flag > 0) {
	         return true;
	      } else {
	         return false;
	      }
	   }
	   
	   //학습공부 글 수정하는 메소드
	   public boolean update(StudyDto dto) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      int flag = 0;
	      try {
	         conn = new DbcpBean().getConn();
	         //실행할 sql문 작성
	         String sql = "UPDATE board_study"
	               + " SET title=?, content=?, category=?"
	               + " WHERE num=?";
	         pstmt = conn.prepareStatement(sql);
	         //?에 바인딩 할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getTitle());
	         pstmt.setString(2, dto.getContent());
	         pstmt.setString(3, dto.getCategory());
	         pstmt.setInt(4, dto.getNum());
	         //insert or update or delete 문 수행하고 변화된 row의 갯수 리턴 받기
	         flag = pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	            if (pstmt != null)
	               pstmt.close();
	            if (conn != null)
	               conn.close();
	         } catch (Exception e) {
	         }
	      }
	      if (flag > 0) {
	         return true;
	      } else {
	         return false;
	      }
	   }
	   
	   //학습공부 새 글 추가하는 메소드
	   public boolean insert(StudyDto dto) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      int flag = 0;
	      try {
	         conn = new DbcpBean().getConn();
	         //실행할 sql문 작성
	         String sql = "INSERT INTO board_study"
	                    + " (num, writer, nick, title, content, viewCount, regdate, category)"
	                    + " VALUES(board_study_seq.NEXTVAL, ?, ?, ?, ?, 0, SYSDATE, ?)";
	         pstmt = conn.prepareStatement(sql);
	         //?에 바인딩 할 내용이 있으면 여기서 바인딩
	            pstmt.setString(1, dto.getWriter());
	            pstmt.setString(2, dto.getNick());
	            pstmt.setString(3, dto.getTitle());
	            pstmt.setString(4, dto.getContent());
	            pstmt.setString(5, dto.getCategory());
	         //insert or update or delete 문 수행하고 변화된 row의 갯수 리턴 받기
	         flag = pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {
	            if (pstmt != null)
	               pstmt.close();
	            if (conn != null)
	               conn.close();
	         } catch (Exception e) {
	         }
	      }
	      if (flag > 0) {
	         return true;
	      } else {
	         return false;
	      }
	   }
	   

	public boolean addViewCount(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "UPDATE board_study"
					+ "	SET viewCount=viewCount+1"
					+ "	WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//? 바인딩할 내용 있으면 바인딩
			pstmt.setInt(1, num);
			//insert or update or delete 문 수행하고 변화된 row의 갯수 리턴받기
			flag = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	public StudyDto getData(StudyDto dto) {
		StudyDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,TO_CHAR(regdate,'YYYY.MM.DD HH:MI')regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_study"
					+ "		ORDER BY num DESC)"
					+ " WHERE num=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setInt(1, dto.getNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				dto2=new StudyDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setNick(rs.getString("nick"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setCategory(rs.getString("category"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return dto2;
	}
	public StudyDto getDataT(StudyDto dto) {
		StudyDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,TO_CHAR(regdate,'YYYY.MM.DD HH:MI')regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_study"
					+ "		WHERE title LIKE '%'||?||'%'"
					+ "		ORDER BY num DESC)"
					+ " WHERE num=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setInt(2, dto.getNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				dto2=new StudyDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setNick(rs.getString("nick"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setCategory(rs.getString("category"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return dto2;
	}
	public StudyDto getDataN(StudyDto dto) {
		StudyDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,TO_CHAR(regdate,'YYYY.MM.DD HH:MI')regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_study"
					+ "		WHERE nick LIKE '%'||?||'%'"
					+ "		ORDER BY num DESC)"
					+ " WHERE num=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getNick());
			pstmt.setInt(2, dto.getNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				dto2=new StudyDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setNick(rs.getString("nick"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setCategory(rs.getString("category"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return dto2;
	}
	public StudyDto getDataTC(StudyDto dto) {
		StudyDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,TO_CHAR(regdate,'YYYY.MM.DD HH:MI')regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_study"
					+ "		WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'"
					+ "		ORDER BY num DESC)"
					+ " WHERE num=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				dto2=new StudyDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setNick(rs.getString("nick"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setCategory(rs.getString("category"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return dto2;
	}
	public StudyDto getDataC(StudyDto dto) {
		StudyDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,TO_CHAR(regdate,'YYYY.MM.DD HH:MI')regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_study"
					+ "		WHERE category LIKE ?"
					+ "		ORDER BY num DESC)"
					+ " WHERE num=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getCategory());
			pstmt.setInt(2, dto.getNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				dto2=new StudyDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setNick(rs.getString("nick"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setCategory(rs.getString("category"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return dto2;
	}
	
	public StudyDto getDataTCa(StudyDto dto) {
		StudyDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,TO_CHAR(regdate,'YYYY.MM.DD HH:MI')regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_study"
					+ "		WHERE title LIKE '%'||?||'%' AND category LIKE ?"
					+ "		ORDER BY num DESC)"
					+ " WHERE num=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getCategory());
			pstmt.setInt(3, dto.getNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				dto2=new StudyDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setNick(rs.getString("nick"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setCategory(rs.getString("category"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return dto2;
	}
	public StudyDto getDataNCa(StudyDto dto) {
		StudyDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,TO_CHAR(regdate,'YYYY.MM.DD HH:MI')regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_study"
					+ "		WHERE nick LIKE '%'||?||'%' AND category LIKE ?"
					+ "		ORDER BY num DESC)"
					+ " WHERE num=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getNick());
			pstmt.setString(2, dto.getCategory());
			pstmt.setInt(3, dto.getNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				dto2=new StudyDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setNick(rs.getString("nick"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setCategory(rs.getString("category"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return dto2;
	}
	public StudyDto getDataTCCa(StudyDto dto) {
		StudyDto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,TO_CHAR(regdate,'YYYY.MM.DD HH:MI')regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_study"
					+ "		WHERE (title LIKE '%'||?||'%' OR content LIKE '%'||?||'%') AND category LIKE ?"
					+ "		ORDER BY num DESC)"
					+ " WHERE num=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getCategory());
			pstmt.setInt(4, dto.getNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				dto2=new StudyDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setNick(rs.getString("nick"));
				dto2.setTitle(rs.getString("title"));
				dto2.setContent(rs.getString("content"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setCategory(rs.getString("category"));
				dto2.setPrevNum(rs.getInt("prevNum"));
				dto2.setNextNum(rs.getInt("nextNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return dto2;
	}
	
	public List<StudyDto> getList(StudyDto dto){
		List<StudyDto> list=new ArrayList<StudyDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "FROM"
					+ "	(SELECT result1.*,ROWNUM as rnum"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,viewCount,category,TO_CHAR(regdate,'YYYY.MM.DD')regdate"
					+ "		FROM board_study"
					+ " 	ORDER BY num DESC)result1)"
					+ "	WHERE rnum>=? AND rnum<=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setInt(1, dto.getStartRowNum());
			pstmt.setInt(2, dto.getEndRowNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			while (rs.next()) {
				StudyDto tmp=new StudyDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setWriter(rs.getString("writer"));
				tmp.setNick(rs.getString("nick"));
				tmp.setTitle(rs.getString("title"));
				tmp.setViewCount(rs.getInt("viewCount"));
				tmp.setRegdate(rs.getString("regdate"));
				tmp.setCategory(rs.getString("category"));
				list.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return list;
	}
	
	public int getCount() {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_study";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return count;
	}
	
	public List<StudyDto> getListT(StudyDto dto){
		List<StudyDto> list=new ArrayList<StudyDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "	(SELECT result1.*,ROWNUM as rnum"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,viewCount,TO_CHAR(regdate,'YYYY.MM.DD')regdate,category"
					+ "		FROM board_study"
					+ "		WHERE title LIKE '%'||?||'%'"
					+ " 	ORDER BY num DESC)result1)"
					+ "	WHERE rnum>=? AND rnum<=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setInt(2, dto.getStartRowNum());
			pstmt.setInt(3, dto.getEndRowNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			while (rs.next()) {
				StudyDto tmp=new StudyDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setWriter(rs.getString("writer"));
				tmp.setNick(rs.getString("nick"));
				tmp.setTitle(rs.getString("title"));
				tmp.setViewCount(rs.getInt("viewCount"));
				tmp.setRegdate(rs.getString("regdate"));
				tmp.setCategory(rs.getString("category"));
				list.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return list;
	}
	
	public List<StudyDto> getListN(StudyDto dto){
		List<StudyDto> list=new ArrayList<StudyDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "FROM"
					+ "	(SELECT result1.*,ROWNUM as rnum"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,viewCount,TO_CHAR(regdate,'YYYY.MM.DD')regdate,category"
					+ "		FROM board_study"
					+ "		WHERE nick LIKE '%'||?||'%'"
					+ " 	ORDER BY num DESC)result1)"
					+ "	WHERE rnum>=? AND rnum<=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getNick());
			pstmt.setInt(2, dto.getStartRowNum());
			pstmt.setInt(3, dto.getEndRowNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			while (rs.next()) {
				StudyDto tmp=new StudyDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setWriter(rs.getString("writer"));
				tmp.setNick(rs.getString("nick"));
				tmp.setTitle(rs.getString("title"));
				tmp.setViewCount(rs.getInt("viewCount"));
				tmp.setRegdate(rs.getString("regdate"));
				tmp.setCategory(rs.getString("category"));
				list.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return list;
	}
	
	public List<StudyDto> getListTC(StudyDto dto){
		List<StudyDto> list=new ArrayList<StudyDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "FROM"
					+ "	(SELECT result1.*,ROWNUM as rnum"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,viewCount,TO_CHAR(regdate,'YYYY.MM.DD')regdate,category"
					+ "		FROM board_study"
					+ "		WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'"
					+ " 	ORDER BY num DESC)result1)"
					+ "	WHERE rnum>=? AND rnum<=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getStartRowNum());
			pstmt.setInt(4, dto.getEndRowNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			while (rs.next()) {
				StudyDto tmp=new StudyDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setWriter(rs.getString("writer"));
				tmp.setNick(rs.getString("nick"));
				tmp.setTitle(rs.getString("title"));
				tmp.setViewCount(rs.getInt("viewCount"));
				tmp.setRegdate(rs.getString("regdate"));
				tmp.setCategory(rs.getString("category"));
				list.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return list;
	}
	public List<StudyDto> getListC(StudyDto dto){
		List<StudyDto> list=new ArrayList<StudyDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "FROM"
					+ "	(SELECT result1.*,ROWNUM as rnum"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,viewCount,TO_CHAR(regdate,'YYYY.MM.DD')regdate,category"
					+ "		FROM board_study"
					+ "		WHERE category LIKE ?"
					+ " 	ORDER BY num DESC)result1)"
					+ "	WHERE rnum>=? AND rnum<=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getCategory());
			pstmt.setInt(2, dto.getStartRowNum());
			pstmt.setInt(3, dto.getEndRowNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			while (rs.next()) {
				StudyDto tmp=new StudyDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setWriter(rs.getString("writer"));
				tmp.setNick(rs.getString("nick"));
				tmp.setTitle(rs.getString("title"));
				tmp.setViewCount(rs.getInt("viewCount"));
				tmp.setRegdate(rs.getString("regdate"));
				tmp.setCategory(rs.getString("category"));
				list.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return list;
	}
	
	public int getCountT(StudyDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_study"
					+ "	WHERE title LIKE '%'||?||'%'";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return count;
	}
	public int getCountN(StudyDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_study"
					+ "	WHERE nick LIKE '%'||?||'%'";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getNick());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return count;
	}
	public int getCountTC(StudyDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_study"
					+ "	WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return count;
	}
	public int getCountC(StudyDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_study"
					+ "	WHERE category LIKE ?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getCategory());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return count;
	}
	public List<StudyDto> getListTCa(StudyDto dto){
		List<StudyDto> list=new ArrayList<StudyDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "FROM"
					+ "	(SELECT result1.*,ROWNUM as rnum"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,viewCount,TO_CHAR(regdate,'YYYY.MM.DD')regdate,category"
					+ "		FROM board_study"
					+ "		WHERE title LIKE '%'||?||'%' AND category LIKE ?"
					+ " 	ORDER BY num DESC)result1)"
					+ "	WHERE rnum>=? AND rnum<=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getCategory());
			pstmt.setInt(3, dto.getStartRowNum());
			pstmt.setInt(4, dto.getEndRowNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			while (rs.next()) {
				StudyDto tmp=new StudyDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setWriter(rs.getString("writer"));
				tmp.setNick(rs.getString("nick"));
				tmp.setTitle(rs.getString("title"));
				tmp.setViewCount(rs.getInt("viewCount"));
				tmp.setRegdate(rs.getString("regdate"));
				tmp.setCategory(rs.getString("category"));
				list.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return list;
	}
	public List<StudyDto> getListNCa(StudyDto dto){
		List<StudyDto> list=new ArrayList<StudyDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "FROM"
					+ "	(SELECT result1.*,ROWNUM as rnum"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,viewCount,TO_CHAR(regdate,'YYYY.MM.DD')regdate,category"
					+ "		FROM board_study"
					+ "		WHERE nick LIKE '%'||?||'%' AND category LIKE ?"
					+ " 	ORDER BY num DESC)result1)"
					+ "	WHERE rnum>=? AND rnum<=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getNick());
			pstmt.setString(2, dto.getCategory());
			pstmt.setInt(3, dto.getStartRowNum());
			pstmt.setInt(4, dto.getEndRowNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			while (rs.next()) {
				StudyDto tmp=new StudyDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setWriter(rs.getString("writer"));
				tmp.setNick(rs.getString("nick"));
				tmp.setTitle(rs.getString("title"));
				tmp.setViewCount(rs.getInt("viewCount"));
				tmp.setRegdate(rs.getString("regdate"));
				tmp.setCategory(rs.getString("category"));
				list.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return list;
	}
	
	public List<StudyDto> getListTCCa(StudyDto dto){
		List<StudyDto> list=new ArrayList<StudyDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "FROM"
					+ "	(SELECT result1.*,ROWNUM as rnum"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,viewCount,TO_CHAR(regdate,'YYYY.MM.DD')regdate,category"
					+ "		FROM board_study"
					+ "		WHERE (title LIKE '%'||?||'%' OR content LIKE '%'||?||'%') AND category LIKE ?"
					+ " 	ORDER BY num DESC)result1)"
					+ "	WHERE rnum>=? AND rnum<=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getCategory());
			pstmt.setInt(4, dto.getStartRowNum());
			pstmt.setInt(5, dto.getEndRowNum());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			while (rs.next()) {
				StudyDto tmp=new StudyDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setWriter(rs.getString("writer"));
				tmp.setNick(rs.getString("nick"));
				tmp.setTitle(rs.getString("title"));
				tmp.setViewCount(rs.getInt("viewCount"));
				tmp.setRegdate(rs.getString("regdate"));
				tmp.setCategory(rs.getString("category"));
				list.add(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return list;
	}
	
	public int getCountTCa(StudyDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_study"
					+ "	WHERE title LIKE '%'||?||'%' AND category LIKE ?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getCategory());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return count;
	}
	public int getCountNCa(StudyDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_study"
					+ "	WHERE nick LIKE '%'||?||'%' AND category LIKE ?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getNick());
			pstmt.setString(2, dto.getCategory());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return count;
	}
	public int getCountTCCa(StudyDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_study"
					+ "	WHERE (title LIKE '%'||?||'%' OR content LIKE '%'||?||'%') AND category LIKE ?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getCategory());
			//select 문 수행하고 결과를 ResultSet으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type으로 포장하기
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}return count;
	}
}
