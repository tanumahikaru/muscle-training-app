package dao;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
	

	    public static List<MaterialDTO> SelectMaterialsByFoodId(int foodId) {
	        String sql = "SELECT * FROM material WHERE food_id=?";
	        List<MaterialDTO> materials = new ArrayList<>();

	        try (Connection con = getConnection();
	             PreparedStatement pstmt = con.prepareStatement(sql)) {

	            pstmt.setInt(1, foodId);

	            try (ResultSet rs = pstmt.executeQuery()) {
	                while (rs.next()) {
	                    int step = rs.getInt("step");
	                    String ingredients = rs.getString("ingredients");
	                    String quantity = rs.getString("quantity");

	                    MaterialDTO material = new MaterialDTO(foodId, step, ingredients, quantity);
	                    materials.add(material);
	                }
	            }
	        } catch (SQLException | URISyntaxException e) {
	            e.printStackTrace();
	        }

	        return materials;
	    }
	}