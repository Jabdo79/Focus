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

		// Since version 4.x, service registry is being used
		ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
				.applySettings(configuration.getProperties()).build();

		// Create session factory instance
		factory = configuration.buildSessionFactory(serviceRegistry);
	}

	public static boolean addUser(User user) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.openSession();
		hibernateSession.getTransaction().begin();

		// save this specific record
		int i = (Integer) hibernateSession.save(user);

		hibernateSession.getTransaction().commit();
		hibernateSession.close();

		return true;
	}

	public static void addTopic(Location location) {
		if (factory == null)
			setupFactory();

		Session hibernateSession = factory.openSession();
		hibernateSession.getTransaction().begin();

		if (!containsLocation(location))
			hibernateSession.save(location);
		else {
			// add topic to existing location
			String gID = location.getGoogleID();
			Location existing = hibernateSession.load(Location.class, gID);
			if(existing.getTopics() == null)
				existing.setTopics(location.getTopics()+"/t");
			else
				existing.setTopics(existing.getTopics()+location.getTopics()+"/t");
			hibernateSession.merge(existing);
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
	}
}