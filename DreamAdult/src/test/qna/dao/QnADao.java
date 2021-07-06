package test.qna.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.qna.dto.QnADto;
import test.util.DbcpBean;

public class QnADao {
	private static QnADao dao;
	private QnADao() {}
	public static QnADao getInstance() {
		if(dao==null) {
			dao=new QnADao();
		}
		return dao;
	}
	
	//QnA 글 하나의 정보를 리턴하는 메소드
	public QnADto getData(int num) {
		QnADto dto=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT writer, nick, title, content, viewCount, regdate, category"
					+ " FROM board_QnA"
					+ " WHERE num=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, num);
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if (rs.next()) {
				dto=new QnADto();
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
	
	//QnA 글 삭제하는 메소드
	   public boolean delete(int num) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      int flag = 0;
	      try {
	         conn = new DbcpBean().getConn();
	         //실행할 sql문 작성
	         String sql = "DELETE FROM board_QnA"
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
	   
	   //QnA 글 수정하는 메소드
	   public boolean update(QnADto dto) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      int flag = 0;
	      try {
	         conn = new DbcpBean().getConn();
	         //실행할 sql문 작성
	         String sql = "UPDATE board_QnA"
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
	   
	   //QnA 새 글 추가하는 메소드
	   public boolean insert(QnADto dto) {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      int flag = 0;
	      try {
	         conn = new DbcpBean().getConn();
	         //실행할 sql문 작성
	         String sql = "INSERT INTO board_QnA"
	                    + " (num, writer, nick, title, content, viewCount, regdate, category)"
	                    + " VALUES(board_QnA_seq.NEXTVAL, ?, ?, ?, ?, 0, SYSDATE, ?)";
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
			String sql = "UPDATE board_QnA"
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
	public QnADto getData(QnADto dto) {
		QnADto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_QnA"
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
				dto2=new QnADto();
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
	public QnADto getDataT(QnADto dto) {
		QnADto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_QnA"
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
				dto2=new QnADto();
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
	public QnADto getDataN(QnADto dto) {
		QnADto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_QnA"
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
				dto2=new QnADto();
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
	public QnADto getDataTC(QnADto dto) {
		QnADto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_QnA"
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
				dto2=new QnADto();
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
	public QnADto getDataC(QnADto dto) {
		QnADto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_QnA"
					+ "		WHERE category LIKE '%'||?||'%'"
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
				dto2=new QnADto();
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
	
	public QnADto getDataTCa(QnADto dto) {
		QnADto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_QnA"
					+ "		WHERE title LIKE '%'||?||'%' AND category LIKE'%'||?||'%'"
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
				dto2=new QnADto();
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
	public QnADto getDataNCa(QnADto dto) {
		QnADto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_QnA"
					+ "		WHERE nick LIKE '%'||?||'%' AND category LIKE'%'||?||'%'"
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
				dto2=new QnADto();
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
	public QnADto getDataTCCa(QnADto dto) {
		QnADto dto2=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "		(SELECT num,writer,nick,title,content,viewCount,regdate,category,"
					+ "		LAG(num,1,0) OVER(ORDER BY num DESC) AS prevNum,"
					+ "		LEAD(num,1,0) OVER(ORDER BY num DESC) nextNum"
					+ "		FROM board_QnA"
					+ "		WHERE (title LIKE '%'||?||'%' OR content LIKE '%'||?||'%') AND category LIKE'%'||?||'%'"
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
				dto2=new QnADto();
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
	
	public List<QnADto> getList(QnADto dto){
		List<QnADto> list=new ArrayList<QnADto>();
		
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
					+ "		(SELECT num,writer,nick,title,viewCount,regdate,category"
					+ "		FROM board_QnA"
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
				QnADto tmp=new QnADto();
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
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_QnA";
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
	
	public List<QnADto> getListT(QnADto dto){
		List<QnADto> list=new ArrayList<QnADto>();
		
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
					+ "		(SELECT num,writer,nick,title,viewCount,regdate,category"
					+ "		FROM board_QnA"
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
				QnADto tmp=new QnADto();
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
	
	public List<QnADto> getListN(QnADto dto){
		List<QnADto> list=new ArrayList<QnADto>();
		
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
					+ "		(SELECT num,writer,nick,title,viewCount,regdate,category"
					+ "		FROM board_QnA"
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
				QnADto tmp=new QnADto();
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
	
	public List<QnADto> getListTC(QnADto dto){
		List<QnADto> list=new ArrayList<QnADto>();
		
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
					+ "		(SELECT num,writer,nick,title,viewCount,regdate,category"
					+ "		FROM board_QnA"
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
				QnADto tmp=new QnADto();
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
	public List<QnADto> getListC(QnADto dto){
		List<QnADto> list=new ArrayList<QnADto>();
		
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
					+ "		(SELECT num,writer,nick,title,viewCount,regdate,category"
					+ "		FROM board_QnA"
					+ "		WHERE category LIKE '%'||?||'%'"
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
				QnADto tmp=new QnADto();
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
	
	public int getCountT(QnADto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_QnA"
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
	public int getCountN(QnADto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_QnA"
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
	public int getCountTC(QnADto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_QnA"
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
	public int getCountC(QnADto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_QnA"
					+ "	WHERE category LIKE '%'||?||'%'";
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
	public List<QnADto> getListTCa(QnADto dto){
		List<QnADto> list=new ArrayList<QnADto>();
		
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
					+ "		(SELECT num,writer,nick,title,viewCount,regdate,category"
					+ "		FROM board_QnA"
					+ "		WHERE title LIKE '%'||?||'%' AND category LIKE '%'||?||'%'"
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
				QnADto tmp=new QnADto();
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
	public List<QnADto> getListNCa(QnADto dto){
		List<QnADto> list=new ArrayList<QnADto>();
		
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
					+ "		(SELECT num,writer,nick,title,viewCount,regdate,category"
					+ "		FROM board_QnA"
					+ "		WHERE nick LIKE '%'||?||'%' AND category LIKE '%'||?||'%'"
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
				QnADto tmp=new QnADto();
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
	
	public List<QnADto> getListTCCa(QnADto dto){
		List<QnADto> list=new ArrayList<QnADto>();
		
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
					+ "		(SELECT num,writer,nick,title,viewCount,regdate,category"
					+ "		FROM board_QnA"
					+ "		WHERE (title LIKE '%'||?||'%' OR content LIKE '%'||?||'%') AND category LIKE '%'||?||'%'"
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
				QnADto tmp=new QnADto();
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
	
	public int getCountTCa(QnADto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_QnA"
					+ "	WHERE title LIKE '%'||?||'%' AND category LIKE '%'||?||'%'";
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
	public int getCountNCa(QnADto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_QnA"
					+ "	WHERE nick LIKE '%'||?||'%' AND category LIKE '%'||?||'%'";
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
	public int getCountTCCa(QnADto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM board_QnA"
					+ "	WHERE (title LIKE '%'||?||'%' OR content LIKE '%'||?||'%') AND category LIKE '%'||?||'%'";
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
