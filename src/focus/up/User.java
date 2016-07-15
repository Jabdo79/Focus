package focus.up;

import org.apache.commons.lang3.time.StopWatch;

public class User {
	private int id; 
	private String email; 
	private int level = 1;
	private int exp;
	private String topic; 
	private int startTime; 
	private int endTime; 
	private String studyAddress;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getExp() {
		return exp;
	}
	public void setExp(int exp) {
		this.exp = exp;
	}
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic = topic;
	}
	public int getStartTime() {
		return startTime;
	}
	public void setStartTime(int startTime) {
		this.startTime = startTime;
	}
	public int getEndTime() {
		return endTime;
	}
	public void setEndTime(int endTime) {
		this.endTime = endTime;
	}
	public String getStudyAddress() {
		return studyAddress;
	}
	public void setStudyAddress(String studyAddress) {
		this.studyAddress = studyAddress;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	} 
	
	public void cooldownTimer(User user){
		StopWatch stopwatch = new StopWatch();
		stopwatch.start();
		while(stopwatch.getTime() < 7200000){
			//do nothing for 2 hours 
		}
		stopwatch.stop();	
		setEndTime(2);
		Level.calcExp(user);			
	}
}
