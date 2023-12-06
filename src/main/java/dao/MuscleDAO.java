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
	
	
	public static List<MuscleDTO> selectTrainingsByTrainingProgram(int training_program_id){	
		// 実行するSQL
		String sql = "SELECT * FROM types_of_training JOIN traning_programs_detail ON"
				+ " types_of_training.training_event_id=traning_programs_detail.training_event_id "
				+ "WHERE traning_programs_detail.training_program_id=? ORDER BY step";
		// 返却用のListインスタンス
		List<MuscleDTO> result = new ArrayList<>();
				
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setInt(1, training_program_id);
			
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
	
	
	public static MuscleDTO SelectMuscleEventById(int id) {
        String sql = "SELECT * FROM types_of_training Where training_event_id=?";
        MuscleDTO training = null;

        try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setInt(1, id);
			try (ResultSet rs = pstmt.executeQuery()){
	            if (rs.next()) {
	            	int training_event_id = rs.getInt("training_event_id");
					String event_name = rs.getString("event_name");
					int mets = rs.getInt("mets");
					String movie_url = rs.getString("movie_url");
					int default_number = rs.getInt("default_number");
					int default_time = rs.getInt("default_time");
	
	                training = new MuscleDTO(training_event_id, event_name, mets, movie_url, default_number, default_time);
	            }
			}
        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
        }

        return training;
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
	
	
	// トレーニングプログラムを更新するためのIDを取得するメソッド
	public static int nextTrainingProgramId(int id) {
        String sql = "SELECT MIN(training_program_id) as training_program_id FROM training_programs Where training_program_id >?";
        int training_program_id = 0;

        try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setInt(1, id);
			try (ResultSet rs = pstmt.executeQuery()){
	            if (rs.next()) {
	            	training_program_id = rs.getInt("training_program_id");
	            	System.out.println(training_program_id);
	            }
			}
        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
        }
        return training_program_id;
    }
	
	// 最小のトレーニングプログラムIDを取得するメソッド
		public static int minTrainingProgramId() {
	        String sql = "SELECT MIN(training_program_id) as training_program_id FROM training_programs";
	        int training_program_id = 0;

	        try (
					Connection con = getConnection();
					PreparedStatement pstmt = con.prepareStatement(sql);
					){
				try (ResultSet rs = pstmt.executeQuery()){
		            if (rs.next()) {
		            	training_program_id = rs.getInt("training_program_id");
		            	System.out.println(training_program_id);
		            }
				}
	        } catch (SQLException | URISyntaxException e) {
	            e.printStackTrace();
	        }
	        return training_program_id;
	    }
		
		
		// トレーニングプログラムを更新するメソッド
		public static int updateTrainingProgramId(int trainingProgramId, int userId) {
			int result = 0; // 更新件数0のままだったら登録失敗
			String sql = "UPDATE muscle_users SET training_program_id=? WHERE id=?";

			try (
					Connection con = getConnection();
					PreparedStatement pstmt = con.prepareStatement(sql);){ // SQL文は、プリコンパイルされ、PreparedStatementオブジェクトに格納される
				// 値をバインドする
				pstmt.setInt(1, trainingProgramId);
				pstmt.setInt(2, userId);
				// sql実行
				result = pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (URISyntaxException e) {
				e.printStackTrace();
			} finally {
				System.out.println(result + "件更新しました。(トレプロID)");
			}
			return result;		// 更新件数を返す
		}
}
