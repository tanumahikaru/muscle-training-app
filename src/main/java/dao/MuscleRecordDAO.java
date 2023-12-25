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
				double time = rs.getDouble("time");
				double calories_burned = rs.getDouble("calories_burned");

				latestRecord = new MuscleRecord(training_record_id, user_id, training_event_id, date, number, time,
						calories_burned);
			}
		} catch (SQLException | URISyntaxException e) {
			e.printStackTrace();
		}

		return latestRecord;
	}
	
	public static List<Double> getWeightsByUserId(int user_id) {
	    String sql = "SELECT weight FROM weight WHERE user_id = ?";
	    List<Double> weights = new ArrayList<>();

	    try (
	        Connection con = getConnection();
	        PreparedStatement pstmt = con.prepareStatement(sql);
	    ) {
	        pstmt.setInt(1, user_id);
	        // SQL実行
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                double weight = rs.getDouble("weight");
	                weights.add(weight);
	            }
	        }

	    } catch (SQLException | URISyntaxException e) {
	        e.printStackTrace();
	    }

	    return weights;
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
	
	public static String getEventNameById(int training_event_id) {
	    String sql = "SELECT event_name FROM types_of_training WHERE training_event_id = ?";
	    String EventName = null;
	    try (
	        Connection con = getConnection();
	        PreparedStatement pstmt = con.prepareStatement(sql);
	    ) {
	        pstmt.setInt(1, training_event_id);
	        
	        // Debug: training_event_id の値を確認
	        System.out.println("Training Event ID in DAO: " + training_event_id);
	        
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                EventName = rs.getString("event_name");
	            }
	        }
	    } catch (SQLException | URISyntaxException e) {
	        e.printStackTrace();
	    }
	    return EventName;
	}

	 // 下から3件の消費カロリーの合計を計算するメソッド
    public static double calculateTotalCalories(List<Double> caloriesList) {
        double totalCalories = 0.0;
        for (Double calories : caloriesList) {
            totalCalories += calories;
        }
        return totalCalories;
    }

    // 下から3件の消費カロリーを取得するメソッド
    public static List<Double> selectLast3Calories(int userId) {
        // 実行するSQL
        String sql = "SELECT calories_burned FROM training_records WHERE user_id = ? ORDER BY training_record_id DESC LIMIT 3";

        // 返却用のListインスタンス
        List<Double> result = new ArrayList<>();
        try (
            Connection con = getConnection();
            PreparedStatement pstmt = con.prepareStatement(sql);
        ) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    double caloriesBurned = rs.getDouble("calories_burned");
                    result.add(caloriesBurned);
                }
            }
        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
        }
        return result;
    }

    // 下から3件の消費カロリーの合計を取得するメソッド
    public static double getTotalCaloriesLast3(int userId) {
        List<Double> last3Calories = selectLast3Calories(userId);
        return calculateTotalCalories(last3Calories);
    }
}

	
