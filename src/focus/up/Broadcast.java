package focus.up;

public class Broadcast {
	private int id;
	private String googleID;
	private String topic;
	private long fbID;
	private int startTime;
	
	public int getStartTime() {
		return startTime;
	}
	public void setStartTime(int startTime) {
		this.startTime = startTime;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGoogleID() {
		return googleID;
	}
	public void setGoogleID(String googleID) {
		this.googleID = googleID;
	}
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic = topic;
	}
	public long getFbID() {
		return fbID;
	}
	public void setFbID(long fbID) {
		this.fbID = fbID;
	}
}
