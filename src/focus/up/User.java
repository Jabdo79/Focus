package focus.up;

import org.apache.commons.lang3.time.StopWatch;

public class User {
	private int id; 
	private String name; 
	private int level = 1;
	private int exp;
	private long fbID;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
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


	public long getFbID() {
		return fbID;
	}


	public void setFbID(long fbID) {
		this.fbID = fbID;
	}


	/*public void cooldownTimer(User user){
		StopWatch stopwatch = new StopWatch();
		stopwatch.start();
		while(stopwatch.getTime() < 7200000){
			//do nothing for 2 hours 
		}
		stopwatch.stop();	
		setEndTime(getStartTime()+2);
		Level.calcExp(user);			
	}*/
}
