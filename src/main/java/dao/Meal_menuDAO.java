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
import dto.RecipeDTO;

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

	// カテゴリーごとに食事メニューを取得するメソッド
	public static List<Meal_menuDTO> selectMeal_menu(int category_Id) {
		// 実行するSQL
		String sql = "SELECT m.* FROM meal_menus m " +
				"JOIN meal_menu_by_category mc ON m.food_id = mc.food_id " +
				"JOIN category c ON mc.category_id = c.category_id " +
				"WHERE c.category_id = ?";

		// 返却用のListインスタンス
		List<Meal_menuDTO> result = new ArrayList<>();

		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, category_Id);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					int food_id = rs.getInt("food_id");
					String food_name = rs.getString("food_name");
					int calorie = rs.getInt("calorie");
					int protein = rs.getInt("protein");
					int fat = rs.getInt("fat");
					int carbo = rs.getInt("carbo");
					boolean main_dish_flag = rs.getBoolean("main_dish_flag");

					Meal_menuDTO meal_menu = new Meal_menuDTO(food_id, food_name, calorie, protein, fat, carbo,
							main_dish_flag);
					result.add(meal_menu);
				}
			}
		} catch (SQLException | URISyntaxException e) {
			e.printStackTrace();
		}

		return result;
	}

	// idによって食事メニューの情報を取得するメソッド
	public static Meal_menuDTO SelectMealMenuById(int id) {
		System.out.println(id);
		String sql = "SELECT * FROM meal_menus Where food_id=?";
		Meal_menuDTO meal_menu = null;

		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					int food_id = rs.getInt("food_id");
					String food_name = rs.getString("food_name");
					int calorie = rs.getInt("calorie");
					int protein = rs.getInt("protein");
					int fat = rs.getInt("fat");
					int carbo = rs.getInt("carbo");
					boolean main_dish_flag = rs.getBoolean("main_dish_flag");

					meal_menu = new Meal_menuDTO(food_id, food_name, calorie, protein, fat, carbo, main_dish_flag);
				}
			}
		} catch (SQLException | URISyntaxException e) {
			e.printStackTrace();
		}
		return meal_menu;
	}

	// メニュー名の部分一致で食事メニューを検索するメソッド
	public static List<Meal_menuDTO> searchRecipeByName(String searchKeyword) {
		// 実行するSQL
		String sql = "SELECT * FROM meal_menus WHERE food_name LIKE ?";

		// 返却用のListインスタンス
		List<Meal_menuDTO> result = new ArrayList<>();

		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			// UTF-8でエンコードしてからPreparedStatementにセット
			pstmt.setString(1, "%" + searchKeyword + "%");

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					int food_id = rs.getInt("food_id");
					String food_name = rs.getString("food_name");
					int calorie = rs.getInt("calorie");
					int protein = rs.getInt("protein");
					int fat = rs.getInt("fat");
					int carbo = rs.getInt("carbo");
					boolean main_dish_flag = rs.getBoolean("main_dish_flag");

					Meal_menuDTO menu = new Meal_menuDTO(food_id, food_name, calorie, protein, fat, carbo,
							main_dish_flag);
					result.add(menu);
				}
			}
		} catch (SQLException | URISyntaxException e) {
			e.printStackTrace();
		}

		return result;
	}

	// カテゴリIDに基づいてカテゴリ名を取得するメソッド
	public static String getCategoryNameById(int category_Id) {
		String sql = "SELECT category_name FROM category WHERE category_id = ?";
		String categoryName = null;

		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, category_Id);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					categoryName = rs.getString("category_name");
				}
			}
		} catch (SQLException | URISyntaxException e) {
			e.printStackTrace();
		}

		return categoryName;
	}

	// メインディッシュの食事メニューIDを取得するメソッド
	public static List<Integer> selectAllMainDishesId() {
		// 実行するSQL
		String sql = "SELECT food_id FROM meal_menus WHERE main_dish_flag = true";
		// 返却用のListインスタンス
		List<Integer> result = new ArrayList<>();
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					int food_id = rs.getInt("food_id");
					result.add(food_id);
				}
			}

		} catch (SQLException | URISyntaxException e) {
			e.printStackTrace();
		}
		return result;
	}

	// 今日の食事メニューを更新するメソッド
	public static int updateFoodId( int foodId, int userId) {
		int result = 0; // 更新件数0のままだったら登録失敗
		String sql = "UPDATE muscle_users SET food_id=? WHERE id=?";

		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) { // SQL文は、プリコンパイルされ、PreparedStatementオブジェクトに格納される
			// 値をバインドする
			pstmt.setInt(1, foodId);
			pstmt.setInt(2, userId);
			// sql実行
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		} finally {
			System.out.println(result + "件更新しました。(食事メニューID)");
		}
		return result; // 更新件数を返す
	}

	public static List<RecipeDTO> selectRecipeByFoodIdAndStep(int foodId) {
	    // 実行するSQL
	    String sql = "SELECT * FROM recipe WHERE food_id = ?";

	    // 返却用のListインスタンス
	    List<RecipeDTO> result = new ArrayList<>();

	    try (
	        Connection con = getConnection();
	        PreparedStatement pstmt = con.prepareStatement(sql);
	    ) {
	        pstmt.setInt(1, foodId);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                int recipeFoodId = rs.getInt("food_id");
	                int recipeStep = rs.getInt("step");
	                String explanation = rs.getString("explanation");

	                RecipeDTO recipe = new RecipeDTO(recipeFoodId, recipeStep, explanation);
	                result.add(recipe);
	            }
	        }
	    } catch (SQLException | URISyntaxException e) {
	        e.printStackTrace();
	    }

	    return result;
	}
	}