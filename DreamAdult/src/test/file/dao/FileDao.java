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
			String sql = "SELECT num, category, writer, nick, grade, title, viewCount, content, orgFileName, saveFileName, fileSize"
					+" FROM board_file INNER JOIN users"
					+" ON board_file.writer = users.id"
					+" WHERE num = ?";
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
}
