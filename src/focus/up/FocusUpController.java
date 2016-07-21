package focus.up;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FocusUpController {

	@RequestMapping("/index")
	public String index(Model model, HttpServletRequest request) {
		String fbString = request.getParameter("fbID");
		long fbID=0;
		if(fbString!=null){
			fbID = Long.parseLong(fbString);
			model.addAttribute("fbID", fbID);
		}
		
		return "index";
	}
	
	//IN PROGRESS**********************************************************
	@RequestMapping("/log_in")
	public String logIn(Model model, HttpServletRequest request) {
		
		
		return "index";
	}

	@RequestMapping("/focus_points")
	public String map(@RequestParam("address") String address, Model model)
			throws FileNotFoundException, IOException, ParseException {
		
		JSONParser parser = new JSONParser();
		address.trim();
		address = address.replaceAll("\\s","+");
		
		// get json object from geocode api for user location
		URL geoUrl = new URL(
				"https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&address="
						+ address);
		String jGeoString = getJson(geoUrl);
		model.addAttribute("jGeocode", jGeoString);

		//parse json obj jGeoString
		JSONObject jGeocode = (JSONObject) parser.parse(jGeoString);
		JSONArray results = (JSONArray) jGeocode.get("results");
		JSONObject geometry = (JSONObject) results.get(0);
		JSONObject location = (JSONObject) geometry.get("location");
		String sLat = (String) location.get("lat");
		String sLng = (String) location.get("lng");

		URL starbucks = new URL("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&location="+sLat+","+sLng+"&radius=6000&name=starbucks");
		URL dunkin = new URL("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&location="+sLat+","+sLng+"&radius=6000&name=dunkin+donuts");
		URL panera = new URL("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&location="+sLat+","+sLng+"&radius=6000&name=panera");
		URL library = new URL("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&location="+sLat+","+sLng+"&radius=6000&name=library");
		
		String jStarbucks = getJson(starbucks);
		String jDunkin = getJson(dunkin);
		String jPanera = getJson(panera);
		String jLibrary = getJson(library);
		
		ArrayList<GPlace> allResults = new ArrayList<GPlace>();
		fillResultsList(jStarbucks, allResults);
		fillResultsList(jDunkin, allResults);
		fillResultsList(jPanera, allResults);
		fillResultsList(jLibrary, allResults);
		
		//DAO.loadActiveTopics(allResults);
		
		return "map";
	}

	public String getJson(URL url) throws IOException {
		BufferedReader bReader = new BufferedReader(new InputStreamReader(url.openStream()));
		String line, json="";
		while ((line = bReader.readLine()) != null) {
			json += line;
		}
		bReader.close();
		return json;
	}
	
	public void fillResultsList(String jSearch, ArrayList<GPlace> allResults) throws ParseException{
		JSONParser parser = new JSONParser();
		
		JSONObject jObject = (JSONObject) parser.parse(jSearch);
		JSONArray jResults = (JSONArray) jObject.get("results");
		
		for(int i=0; i<jResults.size(); i++){
			GPlace gPlace = new GPlace();
			JSONObject currentListing = (JSONObject) jResults.get(i);
			JSONObject geometry = (JSONObject) currentListing.get("geometry");
			JSONObject location = (JSONObject) geometry.get("location");
			
			gPlace.setLat((double) location.get("lat"));
			gPlace.setLng((double) location.get("lng"));		
			gPlace.setName((String) currentListing.get("name"));
			gPlace.setGoogleID((String) currentListing.get("place_id"));
			
			allResults.add(gPlace);
		}
	}
	
	@RequestMapping("/study_here")
	public String createStudyHereForm(Model model, HttpServletRequest request){
		String id = request.getParameter("id");
		model.addAttribute("googleID", id);
		
		if(model.containsAttribute("fbID")){
			return "studyHereForm";
		}
		
		String fbString = request.getParameter("fbID");
		long fbID=0;
		if(fbString!=null){
			fbID = Long.parseLong(fbString);
			model.addAttribute("fbID", fbID);
			model.addAttribute("command", new Broadcast());
			
			return "studyHereForm";
		}	
		
		return "log_in";	
	}
	
	@RequestMapping("/start_studying")
	public String broadcastLocation(@ModelAttribute("command") Broadcast broadcast, Model model){
		DAO.addBroadcast(broadcast);
		model.addAttribute("broadcast", broadcast);
		return "profile";
	}
	
	@RequestMapping("/stop_studying")
	public String removeBroadcast(Model model, HttpServletRequest request){
		long fbID = Long.parseLong(request.getParameter("fbID"));
		int endTime = Integer.parseInt(request.getParameter("endTime"));
		int rating = Integer.parseInt(request.getParameter("rating"));
		
		//calc exp for user from start time
		User user = DAO.getUser(fbID);
		Broadcast broadcast = DAO.getBroadcast(fbID);
		Level.calcExp(user, broadcast.getStartTime(), endTime);
		
		//submit rating for location
		if(rating > 0)
			DAO.addRating(broadcast.getGoogleID(), rating);
		
		//remove broadcast for logged in user
		DAO.removeBroadcast(fbID);
		
		return "profile";
	}
}