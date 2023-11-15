package servlet;

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
	public static int registerUser(UserDTO user) {
		String sql = "INSERT INTO muscle_users VALUES(default, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		int result = 0;
		
		// ランダムなソルトの取得(今回は32桁で実装)
		String salt = GenerateSalt.getSalt(32);
		
		// 取得したソルトを使って平文PWをハッシュ
		String hashedPw = GenerateHashedPw.getSafetyPassword(user.getPassword(), salt);
		
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setString(1, user.getName());
			
			pstmt.setInt(2, user.getGender());
			pstmt.setDate(3, new java.sql.Date(user.getBirth().getTime()));

			pstmt.setFloat(4, user.getHeight());
			pstmt.setString(5, user.getMail());
			pstmt.setString(6, salt);
			pstmt.setString(7, hashedPw);
			pstmt.setInt(8, user.getLevel());
			pstmt.setInt(9, user.getTraining_program_id());
			pstmt.setInt(10, user.getFood_id());

			pstmt.setDate(11, new java.sql.Date(user.getLast_login().getTime()));

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
	public static String getSalt(String mail) {
		String sql = "SELECT salt FROM muscle_users WHERE mail = ?";
		
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setString(1, mail);

			try (ResultSet rs = pstmt.executeQuery()){
				
				if(rs.next()) {
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
	
	public static int getUserIdByMail(String mail) {
		
		String sql = "SELECT id FROM muscle_users WHERE mail = ?";
		int userId = -1;
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setString(1, mail);

			try (ResultSet rs = pstmt.executeQuery()){

				if(rs.next()) {
					 userId=rs.getInt("id");
				

					
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return userId;
	}
	public static int registerWeight(WeightDTO weight) {
		String sql = "INSERT INTO weight VALUES(?, ?, ?)";
		int result = 0;
		
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
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
	
	public static UserDTO login(String mail, String hashedPw) {
		String sql = "SELECT * FROM muscle_users WHERE mail = ? AND password = ?";
		
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setString(1, mail);
			pstmt.setString(2, hashedPw);

			try (ResultSet rs = pstmt.executeQuery()){
				
				if(rs.next()) {
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
					
					return new UserDTO(id, name, gender, birth, height, mail, salt, null, null, level, training_program_id, food_id, last_login);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static int registertentative(String mail,String hash) {
		String sql = "INSERT INTO project_tentative VALUES(default, ?, ?)";
		int result = 0;
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setString(1, mail);
			pstmt.setString(2, hash);

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

	public static String selecttentative(String path) {

		String sql = "SELECT * FROM project_tentative where tent = ?";
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setString(1, path);
			try (ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					String mail= rs.getString("mail");
					return mail;
				}
			}
		}catch (SQLException e) {
			e.printStackTrace();
			}catch (URISyntaxException e) {
				e.printStackTrace();
			}
		return null;
	}
	public static int Updatuser(String passwd,String mail) {
		String sql = "UPDATE project_user set salt = ? ,password = ? where mail = ?";
	String salt = GenerateSalt.getSalt(32);
	
	String hashedPw = GenerateHashedPw.getSafetyPassword(passwd, salt);
		int result = 0;
		
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
				pstmt.setString(1,salt);
				pstmt.setString(2,hashedPw);
				pstmt.setString(3,mail);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		} finally {
			System.out.println(result + "件を更新しました。");
		}
		return result;
	}
	public static int selectroot1(int num) {
		int result=-1;
		String sql = "SELECT * FROM project_root WHERE user_id = ?";
		
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setInt(1, num);

			try (ResultSet rs = pstmt.executeQuery()){
				
				if(rs.next()) {
					result= rs.getInt("user_id");
				return result;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return result;
	}
	public static String SelectUser(int num) {
		String result=null;
		String sql = "SELECT * FROM project_user WHERE id = ?";
		
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			pstmt.setInt(1, num);

			try (ResultSet rs = pstmt.executeQuery()){
				
				if(rs.next()) {
					result= rs.getString("mail");
				return result;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return result;
	}
	//全件取得
//	public static List<UserDTO> selectAllRoot() {
//		List<UserDTO> result = new ArrayList<>();
//		String sql = "SELECT * FROM project_root";
//		try (
//				Connection con = getConnection();
//				PreparedStatement pstmt = con.prepareStatement(sql);
//				){
//			try (ResultSet rs = pstmt.executeQuery()){
//				while(rs.next()) {
//					int id = rs.getInt("user_id");
//					UserDTO log=new UserDTO(id, null, null, null, null, null);
//					result.add(log);
//				}
//			}
//		}catch (SQLException e) {
//			e.printStackTrace();
//			}catch (URISyntaxException e) {
//				e.printStackTrace();
//			}
//		return result;
//	}
}
