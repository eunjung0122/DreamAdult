package test.file.dto;

public class FileBookMarkDto {
	private int num;
	private String id;
	private String category;
	private String nick;
	private String title;
	private int viewCount;
	private String regdate;
	private String bookmark;

	public FileBookMarkDto() {}

	public FileBookMarkDto(int num, String id, String category, String nick, String title, int viewCount,
			String regdate, String bookmark) {
		super();
		this.num = num;
		this.id = id;
		this.category = category;
		this.nick = nick;
		this.title = title;
		this.viewCount = viewCount;
		this.regdate = regdate;
		this.bookmark = bookmark;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
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

	public String getBookmark() {
		return bookmark;
	}

	public void setBookmark(String bookmark) {
		this.bookmark = bookmark;
	}
}
