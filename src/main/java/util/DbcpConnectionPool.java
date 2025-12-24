package util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import javax.sql.DataSource;
import org.apache.commons.dbcp2.BasicDataSourceFactory;

/**
 * 数据库操作类
 */
public class DbcpConnectionPool {
    private static DataSource dataSource;

    static {
        init();
    }

    public static void init() {
        if (dataSource != null) {
            return;
        }
        try {
            Properties properties = new Properties();
            InputStream inputStream = DbcpConnectionPool.class.getClassLoader().getResourceAsStream("db.properties");
            if (inputStream == null) {
                throw new RuntimeException("db.properties not found");
            }
            properties.load(inputStream);
            dataSource = BasicDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error initializing DBCP connection pool", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            init();
        }
        return dataSource.getConnection();
    }

    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (stmt != null) stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void close(Connection conn, Statement stmt) {
        close(conn, stmt, null);
    }
}