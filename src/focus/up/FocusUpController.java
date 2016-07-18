package focus.up;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FocusUpController {

	@RequestMapping("/index")
	public ModelAndView index() {
		return new ModelAndView("index", "message", "Welcome to Focus UP!");
	}

	@RequestMapping("/focus_points")
	public String map(@RequestParam("address") String address, Model model)
			throws FileNotFoundException, IOException, ParseException {

		JSONParser parser = new JSONParser();
		Object obj;
		address.trim();
		address = address.replaceAll("\\s","+");
		
		// get json object from geocode api for user location
		URL geoUrl = new URL(
				"https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA&address="
						+ address);
		String jGeoString = getJson(geoUrl);
		model.addAttribute("jGeocode", jGeoString);
		return "map";
		/*JSONObject jGeocode = (JSONObject) parser.parse(jGeoString);
		JSONArray results = (JSONArray) jGeocode.get("results");
		JSONObject geometry = (JSONObject) results.get(0);
		JSONObject location = (JSONObject) geometry.get("location");
		String sLat = (String) location.get("lat");
		String sLng = (String) location.get("lng");
		
		// get json search results from places api
		URL search = new URL(
				"https://maps.googleapis.com/maps/api/place/radarsearch/json?location="+sLat+","+sLng+"&radius=2500&name=(starbucks|panera)&key=AIzaSyD0JXHBRRGaHqwhRz5pMQVp4_6IpIaS-bA");
		String jSearch = getJson(search);
		model.addAttribute("jSearch", jSearch);

		JSONObject data = (JSONObject) jsonObject.get("data");

		JSONArray posts = (JSONArray) data.get("children");

		// loop array
		Iterator<JSONObject> iterator = posts.iterator();
		while (iterator.hasNext()) {
			JSONObject child = (JSONObject) iterator.next().get("data");
			String title = (String) child.get("title");
			System.out.println("Title: " + title);
			String link = (String) child.get("permalink");
			System.out.println("Link: " + link + "\n");
		}

		model.addAttribute("address", address);*/
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
	
	@RequestMapping("study_here")
	public String createStudyHereForm(@RequestParam String id, Model model){
		//fields for form are topic, user id, start time, and location id.
		model.addAttribute("googleID", id);
		model.addAttribute("command", new Location());
		
		return "studyHereForm";
	}
	
	@RequestMapping("start_studying.html")
	public String announceStudyLocation(@ModelAttribute("command") Location location, Model model){
		DAO.addTopic(location);
		
		return "profile";
	}
}