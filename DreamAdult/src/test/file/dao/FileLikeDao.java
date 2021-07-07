package test.file.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import test.file.dto.FileLikeDto;
import test.util.DbcpBean;

public class FileLikeDao {
	private static FileLikeDao dao;
	private FileLikeDao() {}
	public static FileLikeDao getInstance() {
		if(dao==null) {
			dao=new FileLikeDao();
		}
		return dao;
	} 
	
	public int isExist(FileLikeDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 SELECT 문
			String sql = "SELECT count(*) AS count FROM filelike"
					+ " WHERE id=? AND num=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용은 여기서 바인딩한다.
			pstmt.setString(1, dto.getId());
			pstmt.setInt(2, dto.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				//SELECT 된 결과를 여기서 추출해서 객체에 담는다. 
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
	public boolean update2(FileLikeDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sqp(INSERT,UPATE,DELETE)문 작성
			String sql = "UPDATE filelike"
					+ " SET liked='no'"
					+ " WHERE num=? AND id=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 한다
			//update 된 row 의 갯수가 반환 된다. 
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getId());
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
	
	public boolean update(FileLikeDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sqp(INSERT,UPATE,DELETE)문 작성
			String sql = "UPDATE filelike"
					+ " SET liked='yes'"
					+ " WHERE num=? AND id=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 한다
			//update 된 row 의 갯수가 반환 된다. 
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getId());
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
	public boolean insert(FileLikeDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sqp(INSERT,UPATE,DELETE)문 작성
			String sql = "insert into filelike"
					+ "	(num,id)"
					+ "	values(?, ?)";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 한다
			//update 된 row 의 갯수가 반환 된다. 
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getId());
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
	
	public int getCount(int num) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 SELECT 문
			String sql = "SELECT count(*) as count"
					+ "	FROM filelike"
					+ "	WHERE num=? AND liked='yes'";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용은 여기서 바인딩한다.
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				//SELECT 된 결과를 여기서 추출해서 객체에 담는다. 
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
	
	public FileLikeDto getData(FileLikeDto dto) {
		FileLikeDto tmp = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//실행할 SELECT 문
			String sql = "SELECT liked"
					+ " FROM filelike"
					+ "	WHERE id=? AND num=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용은 여기서 바인딩한다.
			pstmt.setString(1, dto.getId());
			pstmt.setInt(2, dto.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				tmp = new FileLikeDto();
				tmp.setLiked(rs.getString("liked"));
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
		}return tmp;
	}
}
