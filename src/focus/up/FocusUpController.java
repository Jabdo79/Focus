package focus.up;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class FocusUpController {

	@RequestMapping("/index")
	public String index(Model model, HttpServletRequest request) {
		return "index";
	}
	
	@RequestMapping("/log_in")
	public String createLogin(Model model, HttpServletRequest request) {
		return "log_in";
	}
	
	@RequestMapping("/submit_login")
	public String logIn(Model model, @CookieValue(value = "fbID", defaultValue = "0") String loggedIn,
			HttpServletResponse response, HttpServletRequest request) {
		
		//return to log in page if no fbID found
		String fbID = request.getParameter("fbID");
		if (fbID.length() < 1)
			return "log_in";
		
		//create a cookie with the user's fbID for log in verification
		Cookie cookie = new Cookie("fbID", fbID);
		response.addCookie(cookie);
		model.addAttribute("fbID", Long.parseLong(fbID));
		
		//get the user by fbID, if none found a new user is created using fbID+name
		User user = DAO.getUser(Long.parseLong(fbID));
		if(user.getName()!=null){
			Broadcast broadcast = DAO.getBroadcast(Long.parseLong(fbID));
			if(broadcast!=null)
				model.addAttribute("broadcast", broadcast);
			model.addAttribute("user", user);
			
		}else{
			user.setName(request.getParameter("fbName"));
			DAO.updateUser(user);
			model.addAttribute("user", user);
			System.out.println("user should be saved");
		}
		
		return "profile";
	}
	
	@RequestMapping("/log_out")
	public String logOut(Model model) {
		return "log_out";
	}
	
	@RequestMapping("/profile")
	public String profile(Model model, @CookieValue(value = "fbID", defaultValue = "0") String sfbID) {
		User user = DAO.getUser(Long.parseLong(sfbID));

		Broadcast broadcast = DAO.getBroadcast(Long.parseLong(sfbID));
		if (broadcast != null)
			model.addAttribute("broadcast", broadcast);
		model.addAttribute("user", user);

		return "profile";
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
		String jGeoString = DAO.getJson(geoUrl);
		model.addAttribute("jGeocode", jGeoString);

		//parse json obj jGeoString
		JSONObject jGeocode = (JSONObject) parser.parse(jGeoString);
		JSONArray results = (JSONArray) jGeocode.get("results");
		JSONObject listing = (JSONObject) results.get(0);
		JSONObject geometry = (JSONObject) listing.get("geometry");
		JSONObject location = (JSONObject) geometry.get("location");
		
		
		String sLat = location.get("lat").toString();
		String sLng = location.get("lng").toString();

		URL starbucks = new URL("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&location="+sLat+","+sLng+"&radius=6000&name=starbucks");
		URL dunkin = new URL("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&location="+sLat+","+sLng+"&radius=6000&name=dunkin+donuts");
		URL panera = new URL("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&location="+sLat+","+sLng+"&radius=6000&name=panera");
		URL library = new URL("https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&location="+sLat+","+sLng+"&radius=6000&type=library");
		
		String jStarbucks = DAO.getJson(starbucks);
		String jDunkin = DAO.getJson(dunkin);
		String jPanera = DAO.getJson(panera);
		String jLibrary = DAO.getJson(library);
		
		ArrayList<GPlace> allResults = new ArrayList<GPlace>();
		DAO.fillResultsList(jStarbucks, allResults);
		DAO.fillResultsList(jDunkin, allResults);
		DAO.fillResultsList(jPanera, allResults);
		DAO.fillResultsList(jLibrary, allResults);
		
		DAO.loadActiveTopics(allResults);
		//convert allResults to json
		Gson gson = new Gson();
		String jAllResultsString = gson.toJson(allResults);	
		
		model.addAttribute("jResults", jAllResultsString);
		
		return "map";
	}
	
	@RequestMapping("/study_here")
	public String createStudyHereForm(Model model, HttpServletRequest request, @CookieValue(value = "fbID", defaultValue = "0") String fbID){
		//change id to gID
		String gID = request.getParameter("gID");
		model.addAttribute("googleID", gID);
		
		String gName = request.getParameter("gName");
		model.addAttribute("googleName", gName);
		
		if(fbID.length() > 0){
			model.addAttribute("fbID", Long.parseLong(fbID));
			model.addAttribute("command", new Broadcast());	
			return "study_here";
		}	
		
		return "log_in";	
	}
	
	@RequestMapping("/start_studying")
	public String broadcastLocation(@ModelAttribute("command") Broadcast broadcast, Model model, HttpServletRequest request){
		DAO.addBroadcast(broadcast);
		User user = DAO.getUser(broadcast.getFbID());
		
		model.addAttribute("user", user);
		model.addAttribute("broadcast", broadcast);
		String gName = request.getParameter("gName");
		model.addAttribute("googleName", gName);
		
		return "profile";
	}
	
	@RequestMapping("/stop_studying")
	public String removeBroadcast(Model model, HttpServletRequest request){
		//need a catch here to prevent user from clicking back and then trying to remove a broadcast thats already gone = null exception
		
		long fbID = Long.parseLong(request.getParameter("fbID"));
		int endTime = Integer.parseInt(request.getParameter("endTime"));
		int rating = Integer.parseInt(request.getParameter("rating"));
		User user = DAO.getUser(fbID);
		Broadcast broadcast = DAO.getBroadcast(fbID);
		
		//calc exp for user from start time
		Level.calcExp(user, broadcast.getStartTime(), endTime);
		
		//submit rating for location
		if(rating > 0)
			DAO.addRating(broadcast.getGoogleID(), rating);
		
		//remove broadcast for logged in user
		DAO.removeBroadcast(fbID);
		
		//update user in database
		DAO.updateUser(user);
		
		model.addAttribute("user", user);
		
		return "profile";
	}
}