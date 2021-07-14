package test.qna.dto;

public class QnADto {
	private int num;
	private String writer;
	private String nick;
	private String title;
	private String content;
	private int viewCount;
	private String regdate;
	private String category;
	private String grade;
	private int startRowNum;
	private int endRowNum;
	private int prevNum;
	private int nextNum;
	private int fix;
	
	public QnADto() {}

	public QnADto(int num, String writer, String nick, String title, String content, int viewCount, String regdate,
			String category, String grade, int startRowNum, int endRowNum, int prevNum, int nextNum, int fix) {
		super();
		this.num = num;
		this.writer = writer;
		this.nick = nick;
		this.title = title;
		this.content = content;
		this.viewCount = viewCount;
		this.regdate = regdate;
		this.category = category;
		this.grade = grade;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
		this.prevNum = prevNum;
		this.nextNum = nextNum;
		this.fix = fix;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}

	public int getPrevNum() {
		return prevNum;
	}

	public void setPrevNum(int prevNum) {
		this.prevNum = prevNum;
	}

	public int getNextNum() {
		return nextNum;
	}

	public void setNextNum(int nextNum) {
		this.nextNum = nextNum;
	}

	public int getFix() {
		return fix;
	}

	public void setFix(int fix) {
		this.fix = fix;
	}

}
