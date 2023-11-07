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

import dto.UserDTO;
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
		String sql = "INSERT INTO project_user VALUES(default, ?, ?, ?, ?, current_timestamp)";
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
			pstmt.setString(2, user.getMail());
			pstmt.setString(3, salt);
			pstmt.setString(4, hashedPw);

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
		String sql = "SELECT salt FROM project_user WHERE mail = ?";
		
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
	public static UserDTO login(String mail, String hashedPw) {
		String sql = "SELECT * FROM project_user WHERE mail = ? AND password = ?";
		
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
					String salt = rs.getString("salt");
					String createdAt = rs.getString("created_at");
					
					return new UserDTO(id, name, mail, salt, null, null);
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
	public static int selectroot1(int id) {
		// TODO 自動生成されたメソッド・スタブ
		return 0;
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
	public static int selectroot(int num) {
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
	public static List<UserDTO> selectAllRoot() {
		List<UserDTO> result = new ArrayList<>();
		String sql = "SELECT * FROM project_root";
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				){
			try (ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					int id = rs.getInt("user_id");
					UserDTO log=new UserDTO(id, null, null, null, null, null);
					result.add(log);
				}
			}
		}catch (SQLException e) {
			e.printStackTrace();
			}catch (URISyntaxException e) {
				e.printStackTrace();
			}
		return result;
	}
}

