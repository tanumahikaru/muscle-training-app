package dao;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.MaterialDTO;

public class MaterialDAO {
	private static Connection getConnection() throws URISyntaxException, SQLException {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	    URI dbUri = new URI(System.getenv("DATABASE_URL"));

	    String username = dbUri.getUserInfo().split(":")[0];
	    String password = dbUri.getUserInfo().split(":")[1];
	    String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();

	    return DriverManager.getConnection(dbUrl, username, password);
	}
	
	public static MaterialDTO SelectMaterialById(int id) {
		System.out.println(id);
    String sql = "SELECT * FROM material Where food_id=?";
    MaterialDTO material = null;

    try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setInt(1, id);
			try (ResultSet rs = pstmt.executeQuery()){
	            if (rs.next()) {
	            	int food_id = rs.getInt("food_id");
	            	int step = rs.getInt("step");
                    String  ingredients = rs.getString("ingredients");
                    String quantity = rs.getString("quantity");

                    material = new MaterialDTO(food_id, step, ingredients, quantity);
                   
	            }
			}
    } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
      }
    return material;
  }

}