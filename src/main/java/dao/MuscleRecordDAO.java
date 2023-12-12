package dao;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.MuscleRecord;

public class MuscleRecordDAO {
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

	// メインディッシュの食事メニューIDを取得するメソッド
	public static List<Integer> selectPreviousMuscleRecords(int id) {
		// 実行するSQL
		String sql = "SELECT training_program_id FROM training_records JOIN traning_programs_detail "
				+ "ON training_records.training_event_id=traning_programs_detail.training_event_id "
				+ "WHERE training_records.user_id=? AND training_records.date=(SELECT max(date) FROM training_records) "
				+ "ORDER BY training_record_id;";
		// 返却用のListインスタンス
		List<Integer> result = new ArrayList<>();
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					int training_program_id = rs.getInt("training_program_id");
					result.add(training_program_id);
				}
			}

		} catch (SQLException | URISyntaxException e) {
			e.printStackTrace();
		}
		return result;
	}

	public static MuscleRecord selectLatestMuscleRecord() {
		String sql = "SELECT * FROM training_records ORDER BY date DESC LIMIT 1";
		MuscleRecord latestRecord = null;

		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				int training_record_id = rs.getInt("training_record_id");
				int user_id = rs.getInt("user_id");
				int training_event_id = rs.getInt("training_event_id");
				Date date = rs.getDate("date");
				int number = rs.getInt("number");
				int time = rs.getInt("time");
				int calories_burned = rs.getInt("calories_burned");

				latestRecord = new MuscleRecord(training_record_id, user_id, training_event_id, date, number, time,
						calories_burned);
			}
		} catch (SQLException | URISyntaxException e) {
			e.printStackTrace();
		}

		return latestRecord;
	}
	
	public static double getWeightByUserId(int user_id) {
		String sql = "SELECT weight FROM weight WHERE user_id = ?";
		double weight = -1;
		try (
			Connection con = getConnection();
		    PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, user_id);
			// sql実行
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					weight = rs.getDouble("weight");
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return weight;
	}
	
	public static int getMetsByTrainingEventId(int training_event_id) {
		String sql = "SELECT mets FROM types_of_training WHERE training_event_id = ?";
		int mets = -1;
		try (
			Connection con = getConnection();
		    PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, training_event_id);
			// sql実行
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					mets = rs.getInt("mets");
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return mets;
	}
	
	public static void insertTrainingRecord(int user_id, int training_event_id, int number, double time, double weight, int mets) {
	    String sql = "INSERT INTO training_records (user_id, training_event_id, date, number, time, calories_burned) "
	            + "VALUES (?, ?, CURRENT_DATE, ?, ?, ?)";

	    try (
	            Connection con = getConnection();
	            PreparedStatement pstmt = con.prepareStatement(sql)) {

	        // パラメーターの設定
	        pstmt.setInt(1, user_id);
	        pstmt.setInt(2, training_event_id);
	        pstmt.setInt(3, number);

	        // タイマーの値を分に変換し、設定
	        pstmt.setDouble(4, time);

	        // 消費カロリーの計算と設定
	        double calories_burned = mets * (time / 60.0) * weight * 1.05;
	        
	        // 小数点第3位までフォーマット
	        String formattedCalories = String.format("%.2f", calories_burned);
	        
	        pstmt.setDouble(5, Double.parseDouble(formattedCalories));
	        
	        // SQL実行
	        pstmt.executeUpdate();

	    } catch (SQLException | URISyntaxException e) {
	        e.printStackTrace();
	    }
	}
}