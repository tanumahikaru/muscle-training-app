package dao;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Meal_menuDTO;

public class MealSuggestionDAO {
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

    public Meal_menuDTO selectRandomMealSuggestionWithMainDishFlag() {
        String sql = "SELECT * FROM meal_menus WHERE main_dish_flag = true ORDER BY RANDOM() LIMIT 1";
        Meal_menuDTO meal_menu = null;

        try (
            Connection con = getConnection();
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()
        ) {
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
        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
        }
        return meal_menu;
    }
}