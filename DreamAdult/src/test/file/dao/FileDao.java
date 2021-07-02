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
}
