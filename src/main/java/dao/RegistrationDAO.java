package dao;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegistrationDAO {
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
	
	public static void insertMealRecord(int userId, String foodName, int calorie, int foodId) {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    try {
	        // データベースへの接続を取得
	        connection = getConnection();

	        // SQL文の準備
	        String sql = "INSERT INTO meal_record (user_id, food_name, calorie, food_id) VALUES (?, ?, ?, ?)";
	        preparedStatement = connection.prepareStatement(sql);

	        // プレースホルダに値を設定
	        preparedStatement.setInt(1, userId);
	        preparedStatement.setString(2, foodName);
	        preparedStatement.setInt(3, calorie);
	        preparedStatement.setInt(4, foodId);

	        // SQL文を実行
	        preparedStatement.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace(); // エラーハンドリングは適切に行ってください
	    } catch (URISyntaxException e) {
	        e.printStackTrace(); // URISyntaxException のエラーハンドリング
	    } finally {
	        // リソースの解放
	        if (preparedStatement != null) {
	            try {
	                preparedStatement.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (connection != null) {
	            try {
	                connection.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	}
}