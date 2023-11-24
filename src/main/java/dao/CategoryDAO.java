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

public class CategoryDAO {
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

    public static List<CategoryDTO> selectAllCategories() {
        String sql = "SELECT * FROM category";

        List<CategoryDTO> result = new ArrayList<>();

        try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                int category_id = rs.getInt("category_id");
                String category_name = rs.getString("category_name");

                CategoryDTO category = new CategoryDTO(category_id, category_name);
                result.add(category);
            }

        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
        }

        return result;
    }


        public static CategoryDTO getCategoryById(int categoryId) {
            String sql = "SELECT * FROM category WHERE category_id = ?";
            CategoryDTO category = null;

            try (Connection con = getConnection();
                 PreparedStatement pstmt = con.prepareStatement(sql)) {

                pstmt.setInt(1, categoryId);

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        String categoryName = rs.getString("category_name");
                        category = new CategoryDTO(categoryId, categoryName);
                    }
                }

            } catch (SQLException | URISyntaxException e) {
                e.printStackTrace();
            }

            return category;
        }

}
