package dao;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.UserDTO;
import dto.WeightDTO;
import util.GenerateHashedPw;
import util.GenerateSalt;

public class UserDAO {
	// DBに接続するメソッド
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

	// 新規ユーザーを登録するメソッド
	public static int registerUser(UserDTO user) {
		int result = 0; // 更新件数0のままだったら登録失敗
		String sql = "INSERT INTO muscle_users VALUES(default, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		// ランダムなソルトの取得(今回は32桁で実装)
		String salt = GenerateSalt.getSalt(32);
		// 取得したソルトを使って平文PWをハッシュ
		String hashedPw = GenerateHashedPw.getSafetyPassword(user.getPassword(), salt);

		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){ // SQL文は、プリコンパイルされ、PreparedStatementオブジェクトに格納される
			// 値をバインドする
			pstmt.setString(1, user.getName());
			pstmt.setInt(2, user.getGender());
			pstmt.setDate(3, new java.sql.Date(user.getBirth().getTime())); // java.util.Dateオブジェクトからjava.sql.Date型のオブジェクトを生成
			pstmt.setFloat(4, user.getHeight());
			pstmt.setString(5, user.getMail());
			pstmt.setString(6, salt);
			pstmt.setString(7, hashedPw);
			pstmt.setInt(8, user.getLevel());
			pstmt.setInt(9, user.getTraining_program_id());
			pstmt.setInt(10, user.getFood_id());
			pstmt.setDate(11, new java.sql.Date(user.getLast_login().getTime()));

			// sql実行
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		} finally {
			System.out.println(result + "件更新しました。");
		}
		return result;		// 更新件数を返す
	}

	
	// メールアドレスからソルトを取得するメソッド
	public static String getSalt(String mail) {
		String sql = "SELECT salt FROM muscle_users WHERE mail = ?";
		try (
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, mail);
			// sql実行
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					String salt = rs.getString("salt");
					return salt;
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return null;
	}

	// ユーザーのメールアドレスからユーザーidを取得するメソッド
	public static int getUserIdByMail(String mail) {
		String sql = "SELECT id FROM muscle_users WHERE mail = ?";
		int userId = -1;
		try (
			Connection con = getConnection();
		    PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, mail);
			// sql実行
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					userId = rs.getInt("id");
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return userId;
	}

	
	//	体重を登録するメソッド
	public static int registerWeight(WeightDTO weight) {
		int result = 0;
		String sql = "INSERT INTO weight VALUES(?, ?, ?)";
		try (
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setInt(1, weight.getUser_id());
			pstmt.setTimestamp(2, new java.sql.Timestamp(weight.getDate().getTime()));
			pstmt.setFloat(3, weight.getWeight());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		} finally {
			System.out.println(result + "件更新しました。");
		}
		return result;
	}

	
	// ログインするメソッド
	public static UserDTO login(String mail, String hashedPw) {
		String sql = "SELECT * FROM muscle_users WHERE mail = ? AND password = ?";

		try (
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, mail);
			pstmt.setString(2, hashedPw);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					int id = rs.getInt("id");
					String name = rs.getString("name");
					int gender = rs.getInt("gender");
					Date birth = rs.getDate("birth");
					float height = rs.getFloat("height");
					String salt = rs.getString("salt");
					int level = rs.getInt("level");
					int training_program_id = rs.getInt("training_program_id");
					int food_id = rs.getInt("food_id");
					Date last_login = rs.getDate("last_login");

					return new UserDTO(id, name, gender, birth, height, mail, salt, null, null, level,
							training_program_id, food_id, last_login);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return null;
	}

	// 最終ログイン日を更新するメソッド
			public static int updateLastLogin(int userId) {
				int result = 0; // 更新件数0のままだったら登録失敗
				String sql = "UPDATE muscle_users SET last_login=NOW() WHERE id=?";

				try (
						Connection con = getConnection();
						PreparedStatement pstmt = con.prepareStatement(sql);){ // SQL文は、プリコンパイルされ、PreparedStatementオブジェクトに格納される
					// 値をバインドする
					pstmt.setInt(1, userId);
					// sql実行
					result = pstmt.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
				} catch (URISyntaxException e) {
					e.printStackTrace();
				} finally {
					System.out.println(result + "件更新しました。(最終ログイン日)");
				}
				return result;		// 更新件数を返す
			}
}
