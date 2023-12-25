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

import dto.Meal_RecordDTO;

public class AdditionalMealDAO {
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
    
    public List<Meal_RecordDTO> getMealsAddedOnSameDay(int userId) {
        List<Meal_RecordDTO> meals = new ArrayList<>();
        try (Connection connection = getConnection()) {
            // current_dateを直接クエリに埋め込む
            String query = "SELECT * FROM meal_record WHERE user_id = ? AND date = current_date";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, userId);

                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        Meal_RecordDTO meal = new Meal_RecordDTO(
                            resultSet.getInt("id"),
                            resultSet.getInt("user_id"),
                            resultSet.getDate("date"),
                            resultSet.getString("food_name"),
                            resultSet.getInt("calorie"),
                            resultSet.getInt("food_id")
                        );

                        meals.add(meal);
                    }
                }
            }
        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
        }
        return meals;
    }
 // 既存のAdditionalMealDAOクラスにこのメソッドを追加してください

    public int getTotalCaloriesConsumedOnSameDay(int userId) {
        int totalCalories = 0;
        try (Connection connection = getConnection()) {
            // SQLクエリ内でcurrent_dateを使用する
            String query = "SELECT SUM(calorie) as total_calories FROM meal_record WHERE user_id = ? AND date = CURRENT_DATE";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, userId);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        totalCalories = resultSet.getInt("total_calories");
                    }
                }
            }
        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
        }
        return totalCalories;
    }
}
