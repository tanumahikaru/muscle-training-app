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

import dto.Meal_menuDTO;

public class Meal_menuDAO {
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
	
	public static List<Meal_menuDTO> selectAllRecipe(){
		
		// 実行するSQL
		String sql = "SELECT * FROM meal_menu";
		
		// 返却用のListインスタンス
		List<Meal_menuDTO> result = new ArrayList<>();
				
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			
			
			try (ResultSet rs = pstmt.executeQuery()){
				
				while(rs.next()) {
					int food_id = rs.getInt("food_id");
					String food_name = rs.getString("food_name");
					int calorie = rs.getInt("calorie");
					int protein = rs.getInt("protein");
					int fat = rs.getInt("fat");
					int carbo = rs.getInt("carbo");
					boolean main_dish_flag = rs.getBoolean("main_dish_flag");
					
					
					Meal_menuDTO meal_menu = new Meal_menuDTO(food_id, food_name, calorie, protein, fat, carbo, main_dish_flag);
					result.add(meal_menu);
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}catch (URISyntaxException e) {
			e.printStackTrace();
		}

		// Listを返却する。0件の場合は空のListが返却される。
		return result;
	}
}
