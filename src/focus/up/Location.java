package focus.up;

public class Location {
 
	private int id;
	private String topics = "";  
	private String googleID;  
	private int rating;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTopics() {
		return topics;
	}
	public void setTopics(String topics) {
		this.topics += topics;
	}
	public String getGoogleID() {
		return googleID;
	}
	public void setGoogleID(String googleID) {
		this.googleID = googleID;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	} 
}
