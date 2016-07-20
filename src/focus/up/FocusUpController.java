package focus.up;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

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
	public String index(Model model, HttpServletRequest request) {
		String fbString = request.getParameter("fbID");
		long fbID=0;
		if(fbString!=null){
			fbID = Long.parseLong(fbString);
			model.addAttribute("fbID", fbID);
		}
		
		return "index";
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
		return "profile";
	}
}