package util;package util;



import java.io.InputStream;import java.sql.Connection;

import java.sql.Connection;import java.sql.DriverManager;

import java.sql.SQLException;import java.sql.ResultSet;

import java.util.Properties;import java.sql.SQLException;

import java.sql.Statement;

import org.apache.commons.dbcp2.BasicDataSource;import java.util.Properties;

import org.apache.commons.dbcp2.BasicDataSourceFactory;

import org.apache.tomcat.dbcp.dbcp.BasicDataSource;

/**import org.apache.tomcat.dbcp.dbcp.BasicDataSourceFactory;

 * 数据库操作类/**

 */ * 数据库操作类

public class DbcpConnectionPool { */

	private static BasicDataSource dataSource = null;public class DbcpConnectionPool {

		private static BasicDataSource dataSource = null;

	static {	private static Connection conn = null;

		init();	

	}	public DbcpConnectionPool(){

		}

	/**	

	 * 初始化数据库连接池	/**

	 */	 * 初始化数据库连接池

	public static void init(){	 */

		if (dataSource != null){	public static void init(){

			try {		if (dataSource != null){

				dataSource.close();			try {

			} catch (SQLException e) {				dataSource.close();

				e.printStackTrace();			} catch (SQLException e) {

			}				e.printStackTrace();

			dataSource = null;			}

		}			dataSource = null;

				}

		try {		//使用Properties对象定义数据库连接池信息

			Properties p = new Properties();		try {

			InputStream is = DbcpConnectionPool.class.getClassLoader().getResourceAsStream("db.properties");			Properties p = new Properties();

			if (is != null) {			p.setProperty("driverClassName", "com.mysql.jdbc.Driver");

				p.load(is);			p.setProperty("url", "jdbc:mysql://localhost:3306/wsdc?useUnicode=true&characterEncoding=UTF-8");

				is.close();			p.setProperty("username", "root");

				dataSource = (BasicDataSource)BasicDataSourceFactory.createDataSource(p);			p.setProperty("password", "123");

			} else {			p.setProperty("maxActive", "30");				//设置处于活动状态的数据库连接的最大数目，0表示不受限制

				System.err.println("db.properties not found in classpath");			p.setProperty("maxIdle", "10");					//设置处于空闲状态的数据库连接的最大数目，0表示不受限制

			}			p.setProperty("maxWait", "1000");				//设置没有处于空闲状态的连接时，请求数据库连接所需的最长等待时间（单位ms），如果超出改时间将抛出异常，-1表示无限期等待

		} catch (Exception e) {			p.setProperty("removeAbandoned", "false");

			e.printStackTrace();			p.setProperty("removeAbandonedTimeout", "120");

		}			p.setProperty("testOnBorrow", "true");

	}			p.setProperty("logAbandoned", "true");

				//以指定信息创建数据源

	/**			dataSource = (BasicDataSource)BasicDataSourceFactory.createDataSource(p);

	 * 获取数据库连接		} catch (Exception e) {

	 * @return Connection对象			e.printStackTrace();

	 * @throws SQLException		}

	 */	}

	public static Connection getConnection() throws SQLException{	/**

		if (dataSource == null){	 * 获取数据库连接

			init();	 * @return Connection对象

		}	 * @throws SQLException

		return dataSource.getConnection();	 */

	}	public static Connection getConnection() throws SQLException{

}		String url = "jdbc:mysql://localhost:3306/wsdc?useUnicode=true&characterEncoding=utf-8";

		String user = "root";
		String psw = "123";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url,user,psw);
		} catch (Exception e) {
			e.printStackTrace();
		}
//		
//		if (dataSource == null){
//			init();
//		}
//		if (dataSource != null){
//			conn = dataSource.getConnection();
//		}
		return conn;
	}
	/**
	 * 执行select语句
	 * @param sql 要执行的sql语句
	 * @return 结果集
	 */
	public static ResultSet runSelect(String sql){
		ResultSet rs = null;
		try {
			Statement stat = conn.createStatement();
			rs = stat.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	/**
	 * 执行增删改sql语句
	 * @param sql 要执行的sql语句
	 * @return 改变的记录数
	 */
	public static int runSql(String sql){
		int i = 0;
		try {
			Statement stat = conn.createStatement();
			i = stat.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}
}
