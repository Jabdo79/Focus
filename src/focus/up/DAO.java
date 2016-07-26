package focus.up;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import org.hibernate.service.ServiceRegistry;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class DAO {
	private static SessionFactory factory;

	private static void setupFactory() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			// ;
		}

		Configuration configuration = new Configuration();

		// hibernate configuration file
		configuration.configure("hibernate.cfg.xml");

		// setup file for User class
		configuration.addResource("user.hbm.xml");

		// setup file for Location class
		configuration.addResource("location.hbm.xml");

		// setup file for Broadcast class
		configuration.addResource("broadcast.hbm.xml");

		// Since version 4.x, service registry is being used
		ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
				.applySettings(configuration.getProperties()).build();

		// Create session factory instance
		factory = configuration.buildSessionFactory(serviceRegistry);
	}

	//Saves Broadcast to db if not found, if found it updates the existing broadcast.
	//A user can have only one Broadcast
	public static void addBroadcast(Broadcast broadcast) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.openSession();
		hibernateSession.getTransaction().begin();

		if (!containsBroadcast(broadcast))
			hibernateSession.save(broadcast);
		else {
			// change topic/location/time for user
			Query query = hibernateSession.createQuery("FROM Broadcast WHERE fbID = :fbID ");
			List<Broadcast> results = query.setParameter("fbID", broadcast.getFbID()).list();
			Broadcast existing = results.get(0);
			existing.setTopic(broadcast.getTopic());
			existing.setGoogleID(broadcast.getGoogleID());
			existing.setStartTime(broadcast.getStartTime());
			hibernateSession.merge(existing);
		}

		hibernateSession.getTransaction().commit();
		hibernateSession.close();
	}

	//Checks for existing Broadcast in db based on fbID
	public static boolean containsBroadcast(Broadcast broadcast) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.openSession();
		hibernateSession.getTransaction().begin();

		Query query = hibernateSession.createQuery("FROM Broadcast WHERE fbID = :fbID ");
		query.setParameter("fbID", broadcast.getFbID());
		List results = query.list();

		hibernateSession.getTransaction().commit();
		hibernateSession.close();

		if (results.isEmpty())
			return false;

		return true;
	}

	//Return a user's Broadcast based on fbID
	public static Broadcast getBroadcast(long fbID) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.getCurrentSession();
		hibernateSession.beginTransaction();
		Query query = hibernateSession.createQuery("FROM Broadcast WHERE fbID = :fbID ");
		List<Broadcast> results = query.setParameter("fbID", fbID).list();
		hibernateSession.getTransaction().commit();

		if (results.isEmpty()) {
			hibernateSession.close();
			return null;
		}

		Broadcast existing = results.get(0);
		
		
		hibernateSession.close();

		return existing;
	}

	//Get a list of broadcasts based on the users in the list received
	//Creates a parallel array of topics for the users
	public static ArrayList<Broadcast> getBroadcastList(ArrayList<User> fUsers){
		ArrayList<Broadcast> fCasts = new ArrayList<Broadcast>();
		
		for(int i=0; i<fUsers.size(); i++){
			fCasts.add(getBroadcast(fUsers.get(i).getFbID()));
		}
		
		return fCasts;
	}

	//Remove Broadcast from db based on fbID
	public static void removeBroadcast(long fbID) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.getCurrentSession();
		hibernateSession.beginTransaction();

		Query query = hibernateSession.createQuery("FROM Broadcast WHERE fbID = :fbID ");
		List<Broadcast> results = query.setParameter("fbID", fbID).list();
		
		if (!results.isEmpty()) {
			Broadcast existing = results.get(0);
			hibernateSession.delete(existing);
		}

		hibernateSession.getTransaction().commit();
		hibernateSession.close();
	}

	//Gets the User from the db based on fbID. 
	//If it doesn't exist, creates a new user, sets the fbID and returns that.
	public static User getUser(long fbID) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.getCurrentSession();
		hibernateSession.beginTransaction();
		Query query = hibernateSession.createQuery("FROM User WHERE fbID = :fbID ");
		List<User> results = query.setParameter("fbID", fbID).list();
		
		hibernateSession.getTransaction().commit();
		hibernateSession.close();
		
		if (results.isEmpty()) {
			User user = new User();
			user.setFbID(fbID);
			return user;
		} else {
			return results.get(0);
		}
	}

	//If the User exists in the db it will be updated, if not it will be saved.
	public static void updateUser(User user) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.getCurrentSession();
		hibernateSession.beginTransaction();
		
		hibernateSession.saveOrUpdate(user);
		
		hibernateSession.getTransaction().commit();
		hibernateSession.close();
	}

	//Return a list of all users that are currently studying at a specific location.
	public static ArrayList<User> getUsersStudying(String gID) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.getCurrentSession();
		hibernateSession.beginTransaction();

		Query query = hibernateSession.createQuery("SELECT fbID FROM Broadcast WHERE googleID = :googleID ");
		List<Long> fbids = query.setParameter("googleID", gID).list();
		hibernateSession.getTransaction().commit();
		
		ArrayList<User> fUsers = new ArrayList<User>();
		
		if (!fbids.isEmpty()) {
			for (int i = 0; i < fbids.size(); i++) {
				fUsers.add(getUser(fbids.get(i)));
			}
		}
		
		hibernateSession.close();
		
		return fUsers;
	}

	//If location exists the rating is changed and db is updated.
	//If it doesn't exist then it creates the location and saves it.
	public static void addRating(String gID, int rating) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.getCurrentSession();
		hibernateSession.beginTransaction();
		Query query = hibernateSession.createQuery("FROM Location WHERE googleID = :gID ");
		List<Location> results = query.setParameter("gID", gID).list();

		Location existing;
		if (results.isEmpty()) {
			existing = new Location();
			existing.setGoogleID(gID);
			existing.setRating(rating);
			hibernateSession.save(existing);
		} else {
			existing = results.get(0);
			existing.setRating(rating);
			hibernateSession.merge(existing);
		}

		hibernateSession.getTransaction().commit();
		hibernateSession.close();
	}

	//Gets all topics and the rating for each location in the GPlace List
	public static void loadActiveTopics(ArrayList<GPlace> allResults) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.getCurrentSession();
		hibernateSession.beginTransaction();

		for (int i = 0; i < allResults.size(); i++) {
			//Gets a list of all active topics for the location from the Broadcast table
			Query query = hibernateSession.createQuery("SELECT topic FROM Broadcast WHERE googleID = :gID ");
			List<String> topics = query.setParameter("gID", allResults.get(i).getGoogleID()).list();
			
			//Gets the rating for the location from the Location table
			Query queryRating = hibernateSession.createQuery("SELECT rating FROM Location WHERE googleID = :gID ");
			List<Integer> rating = queryRating.setParameter("gID", allResults.get(i).getGoogleID()).list();

			// add all the active topics to the GPlace
			for (int j = 0; j < topics.size(); j++) {
				allResults.get(i).setTopics(topics.get(j));
			}
			// add the rating to the GPlace
			if (!rating.isEmpty()) {
				allResults.get(i).setRating(rating.get(0));
			}
		}
		hibernateSession.getTransaction().commit();
		hibernateSession.close();
	}

	//Reads and stores the json object from the URL into a string
	public static String getJson(URL url) throws IOException {
		BufferedReader bReader = new BufferedReader(new InputStreamReader(url.openStream()));
		String line, json = "";
		while ((line = bReader.readLine()) != null) {
			json += line;
		}
		bReader.close();
		return json;
	}

	//Parses the Json Search Results and uses that to create gPlaces for each listing. 
	//Then stores them into the ArrayList of Gplaces
	public static void fillResultsList(String jSearch, ArrayList<GPlace> allResults) throws ParseException {
		JSONParser parser = new JSONParser();

		JSONObject jObject = (JSONObject) parser.parse(jSearch);
		JSONArray jResults = (JSONArray) jObject.get("results");

		for (int i = 0; i < jResults.size(); i++) {
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
}
