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

import dto.MuscleDTO;

public class SampleMuscleDAO {
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
	
	public static List<MuscleDTO> selectTrainingByPosition(int positionId) {
        // 実行するSQL
        String sql = "SELECT t.* FROM types_of_training t " +
                     "JOIN classify_training_by_parts c ON t.training_event_id = c.training_event_id " +
                     "JOIN position p ON c.position_id = p.position_id " +
                     "WHERE p.position_id = ?";

        // 返却用のListインスタンス
        List<MuscleDTO> result = new ArrayList<>();

        try (
                Connection con = getConnection();
                PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setInt(1, positionId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int training_event_id = rs.getInt("training_event_id");
                    String event_name = rs.getString("event_name");
                    int mets = rs.getInt("mets");
                    String movie_url = rs.getString("movie_url");
                    int default_number = rs.getInt("default_number");
                    int default_time = rs.getInt("default_time");

                    MuscleDTO training = new MuscleDTO(training_event_id, event_name, mets, movie_url, default_number, default_time);
                    result.add(training);
                }
            }
        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
        }
        
        return result;
    }
}

