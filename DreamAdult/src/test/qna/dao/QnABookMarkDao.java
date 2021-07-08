package test.qna.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.qna.dto.QnABookMarkDto;
import test.qna.dto.QnADto;
import test.util.DbcpBean;

public class QnABookMarkDao {
	private static QnABookMarkDao dao;
	private QnABookMarkDao() {}
	public static QnABookMarkDao getInstance() {
		if(dao==null) {
			dao=new QnABookMarkDao();
		}
		return dao;
	}
	
	public List<QnABookMarkDto> getMyList(QnABookMarkDto dto){
		List<QnABookMarkDto> list=new ArrayList<QnABookMarkDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *" + 
					" FROM" + 
					"		(SELECT result1.*, ROWNUM AS rnum" + 
					"		 FROM" + 
					"			(SELECT BM.num, id, B.category, B.nick, B.title, B.viewCount, B.regdate, bookmark" + 
					"	 		 FROM bookmark_qna BM, board_qna B" + 
					"	 		 WHERE bookmark='yes' AND BM.num=B.num AND id=?" + 
					"	 		 ORDER BY num DESC) result1)";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getId());
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			while (rs.next()) {
				QnABookMarkDto dto2=new QnABookMarkDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setId(rs.getString("id"));
				dto2.setCategory(rs.getString("category"));
				dto2.setNick(rs.getString("nick"));
				dto2.setTitle(rs.getString("title"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				dto2.setBookmark(rs.getString("bookmark"));
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
				e.printStackTrace();
			}
		}
		return list;
	} 

	public QnABookMarkDto getData(QnABookMarkDto dto) {
		QnABookMarkDto tmp=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT bookmark"
					+ " FROM bookmark_qna"
					+ " WHERE num=? AND id=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getId());
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			while (rs.next()) {
				tmp=new QnABookMarkDto();
				tmp.setBookmark(rs.getString("bookmark"));
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
		return tmp;
	}
	
	public int getCount(int num) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT count(*) AS count"
					+ " FROM bookmark_qna"
					+ " WHERE num=? AND bookmark='yes'";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, num);
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
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
				e.printStackTrace();
			}
		}
		return count;
	}
	
	public int isExist(QnABookMarkDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT count(*) AS count"
					+ " FROM bookmark_qna"
					+ " WHERE num=? AND id=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getId());
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
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
				e.printStackTrace();
			}
		}
		return count;
	}
	
	public boolean update2(QnABookMarkDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "UPDATE bookmark_qna"
					+ " SET bookmark='no'"
					+ " WHERE num=? AND id=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getId());
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
	
	public boolean update(QnABookMarkDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "UPDATE bookmark_qna"
					+ " SET bookmark='yes'"
					+ " WHERE num=? AND id=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getId());
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
	
	public boolean insert(QnABookMarkDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "INSERT INTO bookmark_qna"
					+ " (num, id)"
					+ " VALUES(?, ?)";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getId());
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
}
