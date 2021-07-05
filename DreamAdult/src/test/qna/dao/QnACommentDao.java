package test.qna.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.qna.dto.QnACommentDto;
import test.qna.dto.QnADto;
import test.util.DbcpBean;

public class QnACommentDao {
	private static QnACommentDao dao;
	private QnACommentDao() {}
	public static QnACommentDao getInstance() {
		if(dao==null) {
			dao=new QnACommentDao();
		}
		return dao;
	}
	
	public List<QnACommentDto> getMyList(QnACommentDto dto){
		List<QnACommentDto> list=new ArrayList<QnACommentDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "	(SELECT result1.*,ROWNUM AS rnum"
					+ " 	FROM"
					+ "		(SELECT num,B.nick,content,ref_group,B.regdate" + 
					"		FROM board_qna_comment B,users U" + 
					"		WHERE B.WRITER=U.ID AND WRITER=? AND deleted='no')result1)"
					+ "	WHERE rnum>=? AND rnum<=?";
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
				QnACommentDto dto2=new QnACommentDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setNick(rs.getString("nick"));
				dto2.setContent(rs.getString("content"));
				dto2.setRef_group(rs.getInt("ref_group"));
				dto2.setRegdate(rs.getString("regdate"));
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
	public int getMyCount(QnACommentDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS count"
					+ " FROM BOARD_QNA_COMMENT B, USERS U" + 
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
	//댓글 수정하는 메소드
	public boolean update(QnACommentDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "UPDATE board_qna_comment"
					+ " SET content=?"
					+ " WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 여기서 바인딩
			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getNum());
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
	
	//댓글 삭제하는 메소드
	public boolean delete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "UPDATE board_qna_comment"
					+ " SET deleted = 'yes'"
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
	
	//댓글 목록을 리턴하는 메소드
	public List<QnACommentDto> getList(QnACommentDto dto2){
		List<QnACommentDto> list=new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT *"
					+ "	FROM"
					+ "	(SELECT result1.*,ROWNUM AS rnum"
					+ " 	FROM"
					+ "		(SELECT num, writer, board_qna_comment.nick, content, target_nick, ref_group, comment_group, deleted, profile, board_qna_comment.regdate" + 
					" 		FROM board_qna_comment" + 
					" 		INNER JOIN users" + 
					" 		ON board_qna_comment.writer = users.id" +
					" 		WHERE ref_group=?" + 
					" 		ORDER BY comment_group DESC, num ASC) result1)"
					+ "	WHERE rnum BETWEEN ? AND ?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, dto2.getRef_group());
			pstmt.setInt(2, dto2.getStartRowNum());
			pstmt.setInt(3, dto2.getEndRowNum());
			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			while (rs.next()) {
				QnACommentDto dto=new QnACommentDto();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setNick(rs.getString("nick"));
				dto.setContent(rs.getString("content"));
				dto.setTarget_nick(rs.getString("target_nick"));
				dto.setRef_group(rs.getInt("ref_group"));
				dto.setComment_group(rs.getInt("comment_group"));
				dto.setDeleted(rs.getString("deleted"));
				dto.setProfile(rs.getString("profile"));
				dto.setRegdate(rs.getString("regdate"));
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
				e.printStackTrace();
			}
		}
		return list;
	}
  
  public int getCount(int ref_group) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS count"
					+ " FROM board_qna_comment"
					+ "	WHERE ref_group=?";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용 있으면 여기서 바인딩
			pstmt.setInt(1, ref_group);
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
	
	//댓글의 시퀀스 값을 미리 리턴해주는 메소드
	public int getSequence() {
		int seq=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection 객체의 참조값 얻어오기
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "SELECT board_qna_comment_seq.NEXTVAL AS seq"
					+ " FROM DUAL";
			//PreparedStatement 객체의 참조값 얻어오기
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩할 내용이 있으면 여기서 바인딩

			//select 문 수행하고 결과를 ResultSet 으로 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 객체에 있는 내용을 추출해서 원하는 Data type 으로 포장하기
			if (rs.next()) {
				seq = rs.getInt("seq");
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
		return seq;
	}
	
	//댓글 추가하는 메소드
	public boolean insert(QnACommentDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 sql문 작성
			String sql = "INSERT INTO board_qna_comment"
					+ " (num, writer, nick, content, target_nick, ref_group, comment_group, regdate)"
					+ " VALUES(?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 여기서 바인딩
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getNick());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getTarget_nick());
			pstmt.setInt(6, dto.getRef_group());
			pstmt.setInt(7, dto.getComment_group());
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
