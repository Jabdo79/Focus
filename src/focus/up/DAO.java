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

		// Since version 4.x, service registry is being used
		ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
				.applySettings(configuration.getProperties()).build();

		// Create session factory instance
		factory = configuration.buildSessionFactory(serviceRegistry);
	}

	public static boolean addUser(User user) {
		if (factory == null)
			setupFactory();
		
		// Get current session
		Session hibernateSession = factory.openSession();

		// Begin transaction
		hibernateSession.getTransaction().begin();

		// save this specific record
		int i = (Integer)hibernateSession.save(user);

		// Commit transaction
		hibernateSession.getTransaction().commit();

		hibernateSession.close();

		return true;
	}
}