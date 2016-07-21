package focus.up;

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
}
