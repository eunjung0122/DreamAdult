package test.study.dto;

public class StudyCommentDto {
	private int num;
	private String writer;
	private String nick;
	private String content;
	private String target_nick;
	private int ref_group;
	private int comment_group;
	private String deleted;
	private String profile;
	private String regdate;
	private int startRowNum;
	private int endRowNum;

	public StudyCommentDto() {}

	public StudyCommentDto(int num, String writer, String nick, String content, String target_nick, int ref_group,
			int comment_group, String deleted, String profile, String regdate, int startRowNum, int endRowNum) {
		super();
		this.num = num;
		this.writer = writer;
		this.nick = nick;
		this.content = content;
		this.target_nick = target_nick;
		this.ref_group = ref_group;
		this.comment_group = comment_group;
		this.deleted = deleted;
		this.profile = profile;
		this.regdate = regdate;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTarget_nick() {
		return target_nick;
	}

	public void setTarget_nick(String target_nick) {
		this.target_nick = target_nick;
	}

	public int getRef_group() {
		return ref_group;
	}

	public void setRef_group(int ref_group) {
		this.ref_group = ref_group;
	}

	public int getComment_group() {
		return comment_group;
	}

	public void setComment_group(int comment_group) {
		this.comment_group = comment_group;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
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
	
	
}
