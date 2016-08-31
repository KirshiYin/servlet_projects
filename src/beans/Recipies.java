package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Recipies {

	Connection conn;

	public Recipies(Connection conn) {
		this.conn = conn;
	}

	public static void updateDescription(Connection conn, String description, String id) throws SQLException {
		try {
			// create our java prepared statement using a sql update query
			PreparedStatement ps = conn.prepareStatement("UPDATE recipies SET description = ? WHERE id = ?");

			// set the prepared statement parameters
			ps.setString(1, description);
			ps.setString(2, id);

			// ps.setBoolean(3, true);

			// call executeUpdate to execute our sql update statement
			ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			// log the exception
			throw se;
		}
	}

	public static void addFavoured(Connection conn, String id) throws SQLException {
		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE recipies SET isFavoured = 1 WHERE id = ?");
			ps.setString(1, id);

			ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			throw se;
		}
	}
	
	public static void removeFavoured(Connection conn, String id) throws SQLException {
		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE recipies SET isFavoured = 0 WHERE id = ?");
			ps.setString(1, id);

			ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			throw se;
		}
	}
	
	public static void insertRecipe(Connection conn, String name,String url) throws SQLException {

		try {
			PreparedStatement ps = conn.prepareStatement("insert into recipies" + "(name,image) values" +"(?,?)");
			ps.setString(1, name);
			ps.setString(2, url);

			ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			throw se;
		}
		}
}
