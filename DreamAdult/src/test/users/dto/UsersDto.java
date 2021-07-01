package test.users.dto;

public class UsersDto {
	//필드
	private String id;
	private String pwd;
	private String nick;
	private String email;
	private String profile;
	private String lang;
	private String regdate;
	
	//디폴트 생성자 
	public UsersDto() {}

	public UsersDto(String id, String pwd, String nick, String email, String profile, String lang, String regdate) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.nick = nick;
		this.email = email;
		this.profile = profile;
		this.lang = lang;
		this.regdate = regdate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	
	
}
