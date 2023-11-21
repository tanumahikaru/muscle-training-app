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

public class MuscleDAO {
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
	
	public static List<MuscleDTO> selectAllTraining(){
		
		// 実行するSQL
		String sql = "SELECT * FROM types_of_training";
		
		// 返却用のListインスタンス
		List<MuscleDTO> result = new ArrayList<>();
				
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			
			
			try (ResultSet rs = pstmt.executeQuery()){
				
				while(rs.next()) {
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
			
		} catch (SQLException e) {
			e.printStackTrace();
		}catch (URISyntaxException e) {
			e.printStackTrace();
		}

		// Listを返却する。0件の場合は空のListが返却される。
		return result;
	}
}
