package test.file.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.file.dto.FileDto;
import test.qna.dto.QnADto;
import test.util.DbcpBean;

public class FileDao {
	
	private static FileDao dao;
	
	private FileDao() {}
	
	public static FileDao getInstance() {
		if(dao==null) {
			dao=new FileDao();
		}
		return dao;
	}
	
	
	
	   public boolean addViewCount(int num) {
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      int flag = 0;
		      try {
		         conn = new DbcpBean().getConn();
		         //실행할 sql 문 작성
		         String sql = "UPDATE board_file"
		               + " SET viewCount=viewCount+1"
		               + " WHERE num=?";
		         pstmt = conn.prepareStatement(sql);
		         //? 에 바인딩할 내용이 있으면 여기서 바인딩
		         pstmt.setInt(1, num);
		         //insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
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
	
	// 한명의 파일 목록을 삭제하는 메소드
	public boolean delete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "DELETE FROM board_file" + 
					 " WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, num);
			//insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
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
	
	// 한명의 파일 목록을 수정하는 메소드
	public boolean update(FileDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "UPDATE board_file" + 
					" SET category=?, title=?, content=?, orgFileName=?, saveFileName=?, fileSize=?" + 
					" WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getCategory());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getOrgFileName());
			pstmt.setString(5, dto.getSaveFileName());
			pstmt.setLong(6, dto.getFileSize());
			pstmt.setInt(7, dto.getNum());
			//insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
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
	 
	
	// 한명의 파일 목록을 가져오는 메소드
	public FileDto getData(int num) {
		FileDto dto=new FileDto();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			// 실행할 SELECT 문.
			String sql = "SELECT num, category, writer, nick, grade, title, viewCount, content, orgFileName, saveFileName, fileSize" + 
					" FROM board_file INNER JOIN users" + 
					" ON board_file.writer = users.id" + 
					" WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩할 내용은 여기서.
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			//반복문 돌면서 select 된 회원정보  읽어오기
			if (rs.next()) {
				// SELECT 된 결과를 여기서 추출해서 객체에 담음.
				dto.setNum(rs.getInt("num"));
				dto.setCategory(rs.getString("category"));
				dto.setWriter(rs.getString("writer"));
				dto.setNick(rs.getString("nick"));
				dto.setGrade(rs.getString("grade"));
				dto.setTitle(rs.getString("title"));
				dto.setViewCount(rs.getInt("viewCount"));
				dto.setContent(rs.getString("content"));
				dto.setOrgFileName(rs.getString("orgFileName"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setFileSize(rs.getLong("fileSize"));
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
		}
		return dto;
	}
	
	//글하나의 정보를 리턴하는 메소드
	   public FileDto getData(FileDto dto) {
	      FileDto dto2=null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT *" + 
	               " FROM" + 
	               "   (SELECT num, category, writer, nick, grade, title, viewCount, content, orgFileName, saveFileName, fileSize," + 
	               "   LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
	               "   LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
	               "   FROM board_file INNER JOIN users" +
	               "   ON board_file.writer = users.id"+
	               "   ORDER BY num DESC)" + 
	               " WHERE num=?";
	         
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setInt(1, dto.getNum());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         if(rs.next()) {
	            dto2=new FileDto();
	            dto2.setNum(rs.getInt("num"));
	            dto2.setCategory(rs.getString("category"));
	            dto2.setWriter(rs.getString("writer"));
	            dto2.setNick(rs.getString("nick"));
	            dto2.setGrade(rs.getString("grade"));
	            dto2.setTitle(rs.getString("title"));
	            dto2.setViewCount(rs.getInt("viewCount"));
	            dto2.setContent(rs.getString("content"));
	            dto2.setOrgFileName(rs.getString("orgFileName"));
	            dto2.setSaveFileName(rs.getString("saveFileName"));
	            dto2.setFileSize(rs.getLong("fileSize"));
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
	      }
	      return dto2;
	   }
	   
	   public FileDto getDataC(FileDto dto) {
	      FileDto dto2=null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT *" + 
	               " FROM" + 
	               "   (SELECT num, category, writer, nick, grade, title, viewCount, content, orgFileName, saveFileName, fileSize," + 
	               "   LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
	               "   LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
	               "   FROM board_file INNER JOIN users" +
	               "   ON board_file.writer = users.id"+
	               "   WHERE category LIKE '%'||?||'%'"+
	               "   ORDER BY num DESC)" + 
	               " WHERE num=?";
	         
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getCategory());
	         pstmt.setInt(2, dto.getNum());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         if(rs.next()) {
	            dto2=new FileDto();
	            dto2.setNum(rs.getInt("num"));
	            dto2.setCategory(rs.getString("category"));
	            dto2.setWriter(rs.getString("writer"));
	            dto2.setNick(rs.getString("nick"));
	            dto2.setGrade(rs.getString("grade"));
	            dto2.setTitle(rs.getString("title"));
	            dto2.setViewCount(rs.getInt("viewCount"));
	            dto2.setContent(rs.getString("content"));
	            dto2.setOrgFileName(rs.getString("orgFileName"));
	            dto2.setSaveFileName(rs.getString("saveFileName"));
	            dto2.setFileSize(rs.getLong("fileSize"));
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
	      }
	      return dto2;
	   }
	   
	   public FileDto getDataN(FileDto dto) {
	      FileDto dto2=null;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
	         //Connection 객체의 참조값 얻어오기 
	         conn = new DbcpBean().getConn();
	         //실행할 sql 문 작성
	         String sql = "SELECT *" + 
	               " FROM" + 
	               "   (SELECT num, category, writer, nick, grade, title, viewCount, content, orgFileName, saveFileName, fileSize," + 
	               "   LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
	               "   LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
	               "   FROM board_file INNER JOIN users" +
	               "   ON board_file.writer = users.id"+
	               "   WHERE users.nick LIKE '%'||?||'%'"+
	               "   ORDER BY num DESC)" + 
	               " WHERE num=?";
	         //PreparedStatement 객체의 참조값 얻어오기
	         pstmt = conn.prepareStatement(sql);
	         //? 에 바인딩할 내용이 있으면 여기서 바인딩
	         pstmt.setString(1, dto.getNick());
	         pstmt.setInt(2, dto.getNum());
	         //select 문 수행하고 결과를 ResultSet 으로 받아오기
	         rs = pstmt.executeQuery();
	         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
	         if(rs.next()) {
	            dto2=new FileDto();
	            dto2.setNum(rs.getInt("num"));
	            dto2.setCategory(rs.getString("category"));
	            dto2.setWriter(rs.getString("writer"));
	            dto2.setNick(rs.getString("nick"));
	            dto2.setGrade(rs.getString("grade"));
	            dto2.setTitle(rs.getString("title"));
	            dto2.setViewCount(rs.getInt("viewCount"));
	            dto2.setContent(rs.getString("content"));
	            dto2.setOrgFileName(rs.getString("orgFileName"));
	            dto2.setSaveFileName(rs.getString("saveFileName"));
	            dto2.setFileSize(rs.getLong("fileSize"));
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
	      }
	      return dto2;
	   }
	   
	   public FileDto getDataT(FileDto dto) {
		      FileDto dto2=null;
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      try {
		         //Connection 객체의 참조값 얻어오기 
		         conn = new DbcpBean().getConn();
		         //실행할 sql 문 작성
		         String sql = "SELECT *" + 
		               " FROM" + 
		               "   (SELECT num, category, writer, nick, grade, title, viewCount, content, orgFileName, saveFileName, fileSize," + 
		               "   LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
		               "   LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
		               "   FROM board_file INNER JOIN users" +
		               "   ON board_file.writer = users.id"+
		               "   WHERE title LIKE '%'||?||'%'"+
		               "   ORDER BY num DESC)" + 
		               " WHERE num=?";
		         //PreparedStatement 객체의 참조값 얻어오기
		         pstmt = conn.prepareStatement(sql);
		         //? 에 바인딩할 내용이 있으면 여기서 바인딩
		         pstmt.setString(1, dto.getTitle());
		         pstmt.setInt(2, dto.getNum());
		         //select 문 수행하고 결과를 ResultSet 으로 받아오기
		         rs = pstmt.executeQuery();
		         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
		         if(rs.next()) {
		            dto2=new FileDto();
		            dto2.setNum(rs.getInt("num"));
		            dto2.setCategory(rs.getString("category"));
		            dto2.setWriter(rs.getString("writer"));
		            dto2.setNick(rs.getString("nick"));
		            dto2.setGrade(rs.getString("grade"));
		            dto2.setTitle(rs.getString("title"));
		            dto2.setViewCount(rs.getInt("viewCount"));
		            dto2.setContent(rs.getString("content"));
		            dto2.setOrgFileName(rs.getString("orgFileName"));
		            dto2.setSaveFileName(rs.getString("saveFileName"));
		            dto2.setFileSize(rs.getLong("fileSize"));
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
		      }
		      return dto2;
		   }
	   
	   public FileDto getDataTC(FileDto dto) {
		      FileDto dto2=null;
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      try {
		         //Connection 객체의 참조값 얻어오기 
		         conn = new DbcpBean().getConn();
		         //실행할 sql 문 작성
		         String sql = "SELECT *" + 
		               " FROM" + 
		               "   (SELECT num, category, writer, nick, grade, title, viewCount, content, orgFileName, saveFileName, fileSize," + 
		               "   LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
		               "   LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
		               "   FROM board_file INNER JOIN users" +
		               "   ON board_file.writer = users.id"+
		               "   WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'"+
		               "   ORDER BY num DESC)" + 
		               " WHERE num=?";
		         //PreparedStatement 객체의 참조값 얻어오기
		         pstmt = conn.prepareStatement(sql);
		         //? 에 바인딩할 내용이 있으면 여기서 바인딩
		         pstmt.setString(1, dto.getTitle());
		         pstmt.setString(2, dto.getContent());
		         pstmt.setInt(3, dto.getNum());
		         //select 문 수행하고 결과를 ResultSet 으로 받아오기
		         rs = pstmt.executeQuery();
		         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
		         if(rs.next()) {
		            dto2=new FileDto();
		            dto2.setNum(rs.getInt("num"));
		            dto2.setCategory(rs.getString("category"));
		            dto2.setWriter(rs.getString("writer"));
		            dto2.setNick(rs.getString("nick"));
		            dto2.setGrade(rs.getString("grade"));
		            dto2.setTitle(rs.getString("title"));
		            dto2.setViewCount(rs.getInt("viewCount"));
		            dto2.setContent(rs.getString("content"));
		            dto2.setOrgFileName(rs.getString("orgFileName"));
		            dto2.setSaveFileName(rs.getString("saveFileName"));
		            dto2.setFileSize(rs.getLong("fileSize"));
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
		      }
		      return dto2;
		   }
	   
	   public FileDto getDataTCa(FileDto dto) {
		      FileDto dto2=null;
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      try {
		         //Connection 객체의 참조값 얻어오기 
		         conn = new DbcpBean().getConn();
		         //실행할 sql 문 작성
		         String sql = "SELECT *" + 
		               " FROM" + 
		               "   (SELECT num, category, writer, nick, grade, title, viewCount, content, orgFileName, saveFileName, fileSize," + 
		               "   LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
		               "   LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
		               "   FROM board_file INNER JOIN users" +
		               "   ON board_file.writer = users.id"+
		               "   WHERE title LIKE '%'||?||'%' OR category LIKE '%'||?||'%'"+
		               "   ORDER BY num DESC)" + 
		               " WHERE num=?";
		         //PreparedStatement 객체의 참조값 얻어오기
		         pstmt = conn.prepareStatement(sql);
		         //? 에 바인딩할 내용이 있으면 여기서 바인딩
		         pstmt.setString(1, dto.getTitle());
		         pstmt.setString(2, dto.getCategory());
		         pstmt.setInt(3, dto.getNum());
		         //select 문 수행하고 결과를 ResultSet 으로 받아오기
		         rs = pstmt.executeQuery();
		         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
		         if(rs.next()) {
		            dto2=new FileDto();
		            dto2.setNum(rs.getInt("num"));
		            dto2.setCategory(rs.getString("category"));
		            dto2.setWriter(rs.getString("writer"));
		            dto2.setNick(rs.getString("nick"));
		            dto2.setGrade(rs.getString("grade"));
		            dto2.setTitle(rs.getString("title"));
		            dto2.setViewCount(rs.getInt("viewCount"));
		            dto2.setContent(rs.getString("content"));
		            dto2.setOrgFileName(rs.getString("orgFileName"));
		            dto2.setSaveFileName(rs.getString("saveFileName"));
		            dto2.setFileSize(rs.getLong("fileSize"));
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
		      }
		      return dto2;
		   }
	   
	   public FileDto getDataNCa(FileDto dto) {
		      FileDto dto2=null;
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      try {
		         //Connection 객체의 참조값 얻어오기 
		         conn = new DbcpBean().getConn();
		         //실행할 sql 문 작성
		         String sql = "SELECT *" + 
		               " FROM" + 
		               "   (SELECT num, category, writer, nick, grade, title, viewCount, content, orgFileName, saveFileName, fileSize," + 
		               "   LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
		               "   LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
		               "   FROM board_file INNER JOIN users" +
		               "   ON board_file.writer = users.id"+
		               "   WHERE nick LIKE '%'||?||'%' OR category LIKE '%'||?||'%'"+
		               "   ORDER BY num DESC)" + 
		               " WHERE num=?";
		         //PreparedStatement 객체의 참조값 얻어오기
		         pstmt = conn.prepareStatement(sql);
		         //? 에 바인딩할 내용이 있으면 여기서 바인딩
		         pstmt.setString(1, dto.getNick());
		         pstmt.setString(2, dto.getCategory());
		         pstmt.setInt(3, dto.getNum());
		         //select 문 수행하고 결과를 ResultSet 으로 받아오기
		         rs = pstmt.executeQuery();
		         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
		         if(rs.next()) {
		            dto2=new FileDto();
		            dto2.setNum(rs.getInt("num"));
		            dto2.setCategory(rs.getString("category"));
		            dto2.setWriter(rs.getString("writer"));
		            dto2.setNick(rs.getString("nick"));
		            dto2.setGrade(rs.getString("grade"));
		            dto2.setTitle(rs.getString("title"));
		            dto2.setViewCount(rs.getInt("viewCount"));
		            dto2.setContent(rs.getString("content"));
		            dto2.setOrgFileName(rs.getString("orgFileName"));
		            dto2.setSaveFileName(rs.getString("saveFileName"));
		            dto2.setFileSize(rs.getLong("fileSize"));
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
		      }
		      return dto2;
		   }
	   
	   public FileDto getDataTCCa(FileDto dto) {
		      FileDto dto2=null;
		      Connection conn = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      try {
		         //Connection 객체의 참조값 얻어오기 
		         conn = new DbcpBean().getConn();
		         //실행할 sql 문 작성
		         String sql = "SELECT *" + 
		               " FROM" + 
		               "   (SELECT num, category, writer, nick, grade, title, viewCount, content, orgFileName, saveFileName, fileSize," + 
		               "   LAG(num, 1, 0) OVER(ORDER BY num DESC) AS prevNum," + 
		               "   LEAD(num, 1, 0) OVER(ORDER BY num DESC) nextNum" + 
		               "   FROM board_file INNER JOIN users" +
		               "   ON board_file.writer = users.id"+
		               "   WHERE (title LIKE '%'||?||'%' OR content LIKE '%'||?||'%') AND category LIKE'%'||?||'%'"+
		               "   ORDER BY num DESC)" + 
		               " WHERE num=?";
		         //PreparedStatement 객체의 참조값 얻어오기
		         pstmt = conn.prepareStatement(sql);
		         //? 에 바인딩할 내용이 있으면 여기서 바인딩
		         pstmt.setString(1, dto.getTitle());
		         pstmt.setString(2, dto.getContent());
		         pstmt.setString(3, dto.getCategory());
		         pstmt.setInt(4, dto.getNum());
		         //select 문 수행하고 결과를 ResultSet 으로 받아오기
		         rs = pstmt.executeQuery();
		         //ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
		         if(rs.next()) {
		            dto2=new FileDto();
		            dto2.setNum(rs.getInt("num"));
		            dto2.setCategory(rs.getString("category"));
		            dto2.setWriter(rs.getString("writer"));
		            dto2.setNick(rs.getString("nick"));
		            dto2.setGrade(rs.getString("grade"));
		            dto2.setTitle(rs.getString("title"));
		            dto2.setViewCount(rs.getInt("viewCount"));
		            dto2.setContent(rs.getString("content"));
		            dto2.setOrgFileName(rs.getString("orgFileName"));
		            dto2.setSaveFileName(rs.getString("saveFileName"));
		            dto2.setFileSize(rs.getLong("fileSize"));
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
		      }
		      return dto2;
		   }
	
	// 한명의 파일 목록을 저장하는 메소드
	public boolean insert(FileDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = "INSERT INTO board_file" + 
					" (num, writer, category, title, content, regdate, viewCount, orgFileName, saveFileName, fileSize)" + 
					" VALUES(board_file_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE, 0, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getCategory());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getOrgFileName());
			pstmt.setString(6, dto.getSaveFileName());
			pstmt.setLong(7, dto.getFileSize());
			//insert or update or delete 문 수행하고 변화된 row 의 갯수 리턴 받기
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
	
	// 전체의 파일 목록을 가져오는 메소드
	public List<FileDto> getList(){
		List<FileDto> list=new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			// 실행할 SELECT 문.
			String sql = "SELECT num, nick, category, title, board_file.regdate, viewCount" + 
					" FROM board_file INNER JOIN users" + 
					" ON board_file.writer = users.id" +
					" ORDER BY num DESC";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩할 내용은 여기서.

			rs = pstmt.executeQuery();
			//반복문 돌면서 select 된 회원정보  읽어오기
			while (rs.next()) {
				// SELECT 된 결과를 여기서 추출해서 객체에 담음.
				FileDto dto=new FileDto();
				dto.setNum(rs.getInt("num"));
				dto.setNick(rs.getString("nick"));
				dto.setCategory(rs.getString("category"));
				dto.setTitle(rs.getString("title"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViewCount(rs.getInt("viewCount"));
				list.add(dto);
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
		}
		return list;
	}
	
	public List<FileDto> getList(FileDto dto){
		List<FileDto> list=new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			// 실행할 SELECT 문.
			String sql = "SELECT *"
					+ "FROM"
					+ "		(SELECT result1.*, ROWNUM AS rnum"
					+ "		FROM"
					+ "			(SELECT num, nick, category, title, board_file.regdate, viewCount"  
					+ " 		FROM board_file INNER JOIN users"  
					+ " 		ON board_file.writer = users.id"
					+ "			ORDER BY num DESC)result1)"
					+ "		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩할 내용은 여기서.
			pstmt.setInt(1, dto.getStartRowNum());
	        pstmt.setInt(2, dto.getEndRowNum());
			rs = pstmt.executeQuery();
			//반복문 돌면서 select 된 회원정보  읽어오기
			while (rs.next()) {
				// SELECT 된 결과를 여기서 추출해서 객체에 담음.
				dto=new FileDto();
				dto.setNum(rs.getInt("num"));
				dto.setNick(rs.getString("nick"));
				dto.setCategory(rs.getString("category"));
				dto.setTitle(rs.getString("title"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViewCount(rs.getInt("viewCount"));
				list.add(dto);
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
		}
		return list;
	}
	public List<FileDto> getListTC(FileDto dto){
		List<FileDto> list=new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			// 실행할 SELECT 문.
			String sql = "SELECT *"
					+ "FROM"
					+ "		(SELECT result1.*, ROWNUM AS rnum"
					+ "		FROM"
					+ "			(SELECT num, nick, category, title, board_file.regdate, viewCount"  
					+ " 		FROM board_file INNER JOIN users"  
					+ " 		ON board_file.writer = users.id"
					+ "	 		WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'"
					+ "			ORDER BY num DESC)result1)"
					+ "		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩할 내용은 여기서.
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
	        pstmt.setInt(3, dto.getStartRowNum());
	        pstmt.setInt(4, dto.getEndRowNum());
	        
			rs = pstmt.executeQuery();
			//반복문 돌면서 select 된 회원정보  읽어오기
			while (rs.next()) {
				// SELECT 된 결과를 여기서 추출해서 객체에 담음.
				dto=new FileDto();
				dto.setNum(rs.getInt("num"));
				dto.setNick(rs.getString("nick"));
				dto.setCategory(rs.getString("category"));
				dto.setTitle(rs.getString("title"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViewCount(rs.getInt("viewCount"));
				list.add(dto);
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
		}
		return list;
	}
	
	
	public List<FileDto> getListT(FileDto dto){
		List<FileDto> list=new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			// 실행할 SELECT 문.
			String sql = "SELECT *"
					+ "FROM"
					+ "		(SELECT result1.*, ROWNUM AS rnum"
					+ "		FROM"
					+ "			(SELECT num, nick, category, title, board_file.regdate, viewCount"  
					+ " 		FROM board_file INNER JOIN users"  
					+ " 		ON board_file.writer = users.id"
					+ "	 		WHERE title LIKE '%'||?||'%'"
					+ "			ORDER BY num DESC)result1)"
					+ "		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩할 내용은 여기서.
			pstmt.setString(1, dto.getTitle());
	        pstmt.setInt(2, dto.getStartRowNum());
	        pstmt.setInt(3, dto.getEndRowNum());
	        
			rs = pstmt.executeQuery();
			//반복문 돌면서 select 된 회원정보  읽어오기
			while (rs.next()) {
				// SELECT 된 결과를 여기서 추출해서 객체에 담음.
				dto=new FileDto();
				dto.setNum(rs.getInt("num"));
				dto.setNick(rs.getString("nick"));
				dto.setCategory(rs.getString("category"));
				dto.setTitle(rs.getString("title"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViewCount(rs.getInt("viewCount"));
				list.add(dto);
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
		}
		return list;
	}
	
	public List<FileDto> getListN(FileDto dto){
		List<FileDto> list=new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			// 실행할 SELECT 문.
			String sql = "SELECT *"
					+ "FROM"
					+ "		(SELECT result1.*, ROWNUM AS rnum"
					+ "		FROM"
					+ "			(SELECT num, nick, category, title, board_file.regdate, viewCount"  
					+ " 		FROM board_file INNER JOIN users"  
					+ " 		ON board_file.writer = users.id"
					+ "	 		WHERE nick LIKE '%'||?||'%'"
					+ "			ORDER BY num DESC)result1)"
					+ "		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩할 내용은 여기서.
			pstmt.setString(1, dto.getNick());
	        pstmt.setInt(2, dto.getStartRowNum());
	        pstmt.setInt(3, dto.getEndRowNum());
	        
			rs = pstmt.executeQuery();
			//반복문 돌면서 select 된 회원정보  읽어오기
			while (rs.next()) {
				// SELECT 된 결과를 여기서 추출해서 객체에 담음.
				dto=new FileDto();
				dto.setNum(rs.getInt("num"));
				dto.setNick(rs.getString("nick"));
				dto.setCategory(rs.getString("category"));
				dto.setTitle(rs.getString("title"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViewCount(rs.getInt("viewCount"));
				list.add(dto);
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
		}
		return list;
	}
	
	public List<FileDto> getListC(FileDto dto){
		List<FileDto> list=new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			// 실행할 SELECT 문.
			String sql = "SELECT *"
					+ "FROM"
					+ "		(SELECT result1.*, ROWNUM AS rnum"
					+ "		FROM"
					+ "			(SELECT num, nick, category, title, board_file.regdate, viewCount"  
					+ " 		FROM board_file INNER JOIN users"  
					+ " 		ON board_file.writer = users.id"
					+ "	 		WHERE category LIKE '%'||?||'%'"
					+ "			ORDER BY num DESC)result1)"
					+ "		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩할 내용은 여기서.
			pstmt.setString(1, dto.getCategory());
	        pstmt.setInt(2, dto.getStartRowNum());
	        pstmt.setInt(3, dto.getEndRowNum());
	        
			rs = pstmt.executeQuery();
			//반복문 돌면서 select 된 회원정보  읽어오기
			while (rs.next()) {
				// SELECT 된 결과를 여기서 추출해서 객체에 담음.
				dto=new FileDto();
				dto.setNum(rs.getInt("num"));
				dto.setNick(rs.getString("nick"));
				dto.setCategory(rs.getString("category"));
				dto.setTitle(rs.getString("title"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViewCount(rs.getInt("viewCount"));
				list.add(dto);
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
		}
		return list;
	}
	
	public List<FileDto> getListTCCa(FileDto dto){
		List<FileDto> list=new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			// 실행할 SELECT 문.
			String sql = "SELECT *"
					+ "FROM"
					+ "		(SELECT result1.*, ROWNUM AS rnum"
					+ "		FROM"
					+ "			(SELECT num, nick, category, title, board_file.regdate, viewCount"  
					+ " 		FROM board_file INNER JOIN users"  
					+ " 		ON board_file.writer = users.id"
					+ "	 		WHERE (title LIKE '%'||?||'%' OR content LIKE '%'||?||'%') AND category LIKE '%'||?||'%'"
					+ "			ORDER BY num DESC)result1)"
					+ "		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩할 내용은 여기서.
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getCategory());
	        pstmt.setInt(4, dto.getStartRowNum());
	        pstmt.setInt(5, dto.getEndRowNum());
	        
			rs = pstmt.executeQuery();
			//반복문 돌면서 select 된 회원정보  읽어오기
			while (rs.next()) {
				// SELECT 된 결과를 여기서 추출해서 객체에 담음.
				dto=new FileDto();
				dto.setNum(rs.getInt("num"));
				dto.setNick(rs.getString("nick"));
				dto.setCategory(rs.getString("category"));
				dto.setTitle(rs.getString("title"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViewCount(rs.getInt("viewCount"));
				list.add(dto);
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
		}
		return list;
	}
	
	public List<FileDto> getListTCa(FileDto dto){
		List<FileDto> list=new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			// 실행할 SELECT 문.
			String sql = "SELECT *"
					+ "FROM"
					+ "		(SELECT result1.*, ROWNUM AS rnum"
					+ "		FROM"
					+ "			(SELECT num, nick, category, title, board_file.regdate, viewCount"  
					+ " 		FROM board_file INNER JOIN users"  
					+ " 		ON board_file.writer = users.id"
					+ "	 		WHERE title LIKE '%'||?||'%' AND category LIKE '%'||?||'%'"
					+ "			ORDER BY num DESC)result1)"
					+ "		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩할 내용은 여기서.
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getCategory());
	        pstmt.setInt(3, dto.getStartRowNum());
	        pstmt.setInt(4, dto.getEndRowNum());
	        
			rs = pstmt.executeQuery();
			//반복문 돌면서 select 된 회원정보  읽어오기
			while (rs.next()) {
				// SELECT 된 결과를 여기서 추출해서 객체에 담음.
				dto=new FileDto();
				dto.setNum(rs.getInt("num"));
				dto.setNick(rs.getString("nick"));
				dto.setCategory(rs.getString("category"));
				dto.setTitle(rs.getString("title"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViewCount(rs.getInt("viewCount"));
				list.add(dto);
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
		}
		return list;
	}
	
	public List<FileDto> getListNCa(FileDto dto){
		List<FileDto> list=new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			// 실행할 SELECT 문.
			String sql = "SELECT *"
					+ "FROM"
					+ "		(SELECT result1.*, ROWNUM AS rnum"
					+ "		FROM"
					+ "			(SELECT num, nick, category, title, board_file.regdate, viewCount"  
					+ " 		FROM board_file INNER JOIN users"  
					+ " 		ON board_file.writer = users.id"
					+ "	 		WHERE nick LIKE '%'||?||'%' AND category LIKE '%'||?||'%'"
					+ "			ORDER BY num DESC)result1)"
					+ "		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩할 내용은 여기서.
			pstmt.setString(1, dto.getNick());
			pstmt.setString(2, dto.getCategory());
	        pstmt.setInt(3, dto.getStartRowNum());
	        pstmt.setInt(4, dto.getEndRowNum());
	        
			rs = pstmt.executeQuery();
			//반복문 돌면서 select 된 회원정보  읽어오기
			while (rs.next()) {
				// SELECT 된 결과를 여기서 추출해서 객체에 담음.
				dto=new FileDto();
				dto.setNum(rs.getInt("num"));
				dto.setNick(rs.getString("nick"));
				dto.setCategory(rs.getString("category"));
				dto.setTitle(rs.getString("title"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setViewCount(rs.getInt("viewCount"));
				list.add(dto);
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
		}
		return list;
	}
	
	public int getCount() {
	   int count = 0;
	   	Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT MAX(ROWNUM) AS num"
					+ " FROM board_file";
			pstmt = conn.prepareStatement(sql);
	
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("num");
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
      }
        return count;
   }
	 
	public int getCountTC(FileDto dto) {
	   int count = 0;
	   	Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
		               + " FROM board_file"
		               + " WHERE title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("num");
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
      }
        return count;
   }
	 
	public int getCountT(FileDto dto) {
	   int count = 0;
	   	Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
		               + " FROM board_file"
		               + " WHERE title LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("num");
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
      }
        return count;
   }
	 
	public int getCountN(FileDto dto) {
	   int count = 0;
	   Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
		               + " FROM board_file INNER JOIN users"
		               + " ON board_file.writer = users.id"
		               + " WHERE nick LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNick());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("num");
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
      }
        return count;
   }
	
	public int getCountC(FileDto dto) {
	   int count = 0;
	   Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
		               + " FROM board_file"
		               + " WHERE category LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCategory());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("num");
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
      }
        return count;
   }
	
	public int getCountTCCa(FileDto dto) {
	   int count = 0;
	   Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
		               + " FROM board_file"
		               + " WHERE (title LIKE '%'||?||'%' OR content LIKE '%'||?||'%') AND category LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getCategory());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("num");
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
      }
        return count;
   }
	
	public int getCountTCa(FileDto dto) {
	   int count = 0;
	   Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
		               + " FROM board_file"
		               + " WHERE title LIKE '%'||?||'%' AND category LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getCategory());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("num");
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
      }
        return count;
   }
	
	public int getCountNCa(FileDto dto) {
	   int count = 0;
	   Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
		               + " FROM board_file INNER JOIN users"
		               + " ON board_file.writer = users.id"
		               + " WHERE nick LIKE '%'||?||'%' AND category LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNick());
			pstmt.setString(2, dto.getCategory());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("num");
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
      }
        return count;
   }
	///////////////////////////////////////////////////////////////
	
	
	
	
	
}
