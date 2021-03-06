package focus.up;

import java.util.ArrayList;

public class GPlace {
	private String name, googleID;
	private ArrayList<String> topics = new ArrayList<String>();
	private double lat, lng;
	private int rating; 
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGoogleID() {
		return googleID;
	}
	public void setGoogleID(String googleID) {
		this.googleID = googleID;
	}
	public ArrayList<String> getTopics() {
		return topics;
	}
	public void setTopics(String topics) {
		this.topics.add(topics);
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
}
