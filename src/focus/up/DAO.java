package focus.up;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import org.hibernate.service.ServiceRegistry;

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

	/*public static void addRating(Location location) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.openSession();
		hibernateSession.getTransaction().begin();

		if (!containsLocation(location))
			hibernateSession.save(location);
		else {
			
		}

		hibernateSession.getTransaction().commit();
		hibernateSession.close();
	}

	public static boolean containsLocation(Location location) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.openSession();
		hibernateSession.getTransaction().begin();

		Query query = hibernateSession.createQuery("FROM Location WHERE googleID = :gID ");
		query.setParameter("gID", location.getGoogleID());
		List results = query.list();

		if (results.isEmpty())
			return false;

		return true;
	}*/
	
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

	public static boolean containsBroadcast(Broadcast broadcast) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.openSession();
		hibernateSession.getTransaction().begin();

		Query query = hibernateSession.createQuery("FROM Broadcast WHERE fbID = :fbID ");
		query.setParameter("fbID", broadcast.getFbID());
		List results = query.list();

		if (results.isEmpty())
			return false;

		return true;
	}
	
	public static void deleteBroadcast(long fbID) {
		Session hibernateSession = factory.getCurrentSession();
		hibernateSession.beginTransaction();
		
		Query query = hibernateSession.createQuery("FROM Broadcast WHERE fbID = :fbID ");
		List<Broadcast> results = query.setParameter("fbID", fbID).list();
		Broadcast existing = results.get(0);
		hibernateSession.delete(existing);
		
		hibernateSession.getTransaction().commit();
		hibernateSession.close();
	}
}