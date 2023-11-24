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

import dto.CategoryDTO;
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
	
		// 返却用のListインスタンス
	public static List<Meal_menuDTO> selectAllRecipe() {
	    // 実行するSQL
	    String sql = "SELECT * FROM meal_menus";

	    // 返却用のListインスタンス
	    List<Meal_menuDTO> result = new ArrayList<>();

	    try (Connection con = getConnection(); 
	         PreparedStatement pstmt = con.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
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

	    } catch (SQLException | URISyntaxException e) {
	        e.printStackTrace();
	        // エラーメッセージを表示
	        System.out.println("Error in selectAllRecipe: " + e.getMessage());
	    }

	    // Listを返却する。0件の場合は空のListが返却される。
	    return result;
	}
	public static List<Meal_menuDTO> selectMenuByCategory(int categoryId) {
        String sql = "SELECT m.* FROM meal_menus m JOIN meal_menu_by_category mc ON m.food_id = mc.food_id WHERE mc.category_id = ?";
        List<Meal_menuDTO> result = new ArrayList<>();

        try (Connection con = getConnection(); 
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, categoryId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int food_id = rs.getInt("food_id");
                    String food_name = rs.getString("food_name");
                    int calorie = rs.getInt("calorie");
                    int protein = rs.getInt("protein");
                    int fat = rs.getInt("fat");
                    int carbo = rs.getInt("carbo");
                    boolean main_dish_flag = rs.getBoolean("main_dish_flag");

                    // カテゴリIDからカテゴリを取得
                    CategoryDTO category = CategoryDAO.getCategoryById(categoryId);

                    Meal_menuDTO meal_menu = new Meal_menuDTO(food_id, food_name, calorie, protein, fat, carbo, main_dish_flag, category);
                    result.add(meal_menu);
                }
            }

        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
        }

        return result;
    }

}