package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Account {

	private Connection conn;

	public Account(Connection conn) {
		this.conn = conn;
	}
	//checks if the user can login
	public boolean login(String username, String password) throws SQLException {

		String sql = "select count(*) as count from users where username=? and password=?";
		//java.sql.preparedtstatement import
		//checks if the user and the pw exist in the db
		PreparedStatement stmt = conn.prepareStatement(sql);

		stmt.setString(1, username);
		stmt.setString(2, password);

		ResultSet rs = stmt.executeQuery();

		int count = 0;
		//if we get results
		if (rs.next()) {
			count = rs.getInt("count");
		}
		
		rs.close();
		
		//if there are no rows returned, the user cannot login
		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}

}
