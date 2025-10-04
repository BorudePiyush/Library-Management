package listeners;

import util.DBUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class DatabaseInitializationListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Library Management System starting up...");
        System.out.println("Initializing database...");
        
        try {
            // Initialize database tables
            DBUtil.initializeDatabase();
            System.out.println("Database initialized successfully!");
        } catch (Exception e) {
            System.err.println("Failed to initialize database: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("Library Management System started successfully!");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Library Management System shutting down...");
    }
}