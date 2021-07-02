package test.qna.dao;

public class QnADao {
	private static QnADao dao;
	private QnADao() {}
	public static QnADao getInstance() {
		if(dao==null) {
			dao=new QnADao();
		}
		return dao;
	}
}
