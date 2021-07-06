package test.qna.dto;

public class QnALikeDto {
	private int num;
	private String id;
	private String liked;
	
	public QnALikeDto() {}

	public QnALikeDto(int num, String id, String liked) {
		super();
		this.num = num;
		this.id = id;
		this.liked = liked;
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

	public String getLiked() {
		return liked;
	}

	public void setLiked(String liked) {
		this.liked = liked;
	}
	
	
}
