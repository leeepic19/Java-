package util;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceUtils;

import javax.sql.DataSource;
import java.sql.Connection;

/**
 * JdbcTemplate工具类
 * 提供统一的JdbcTemplate实例
 */
public class JdbcTemplateUtils {
    
    private static JdbcTemplate jdbcTemplate;
    
    /**
     * 获取JdbcTemplate实例
     */
    public static JdbcTemplate getJdbcTemplate() {
        if (jdbcTemplate == null) {
            synchronized (JdbcTemplateUtils.class) {
                if (jdbcTemplate == null) {
                    DataSource dataSource = DbcpConnectionPool.getDataSource();
                    jdbcTemplate = new JdbcTemplate(dataSource);
                }
            }
        }
        return jdbcTemplate;
    }
    
    /**
     * 获取数据库连接
     */
    public static Connection getConnection() {
        return DataSourceUtils.getConnection(DbcpConnectionPool.getDataSource());
    }
    
    /**
     * 释放数据库连接
     */
    public static void releaseConnection(Connection connection) {
        if (connection != null) {
            DataSourceUtils.releaseConnection(connection, DbcpConnectionPool.getDataSource());
        }
    }
}
