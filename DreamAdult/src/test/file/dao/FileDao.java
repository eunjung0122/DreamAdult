package test.file.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.file.dto.FileDto;
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
	
	// 회원 전체의 파일 목록을 가져오는 메소드
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
					" ON board_file.writer = users.id";
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
	
	
	
	
	
	
	
	
}
