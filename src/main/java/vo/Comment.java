package vo;

public class Comment {
	private int comment_no;
	private int help_no;
	// private HelpNo helpNo; // FK -> INNER JOIN -> Map타입
	private String help_memo;
	private String member_id;
	// private MemberId memberId; // FK -> INNER JOIN -> Map타입
	private String updatedate;
	private String createdate;
	public int getComment_no() {
		return comment_no;
	}
	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}
	public int getHelp_no() {
		return help_no;
	}
	public void setHelp_no(int help_no) {
		this.help_no = help_no;
	}
	public String getHelp_memo() {
		return help_memo;
	}
	public void setHelp_memo(String help_memo) {
		this.help_memo = help_memo;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	
}
