package dto;

import java.util.Date;

public class UserDTO {
	private int id;
	private String name;
	private int gender;
	private Date birth;
	private float height;
	private String mail;
	private String salt;
	private String password;
	private String hashedPassword;
	private int level;
	private int training_program_id;
	private int food_id;
	private Date last_login;
	
	
	public UserDTO(int id, String name, int gender, Date birth, float height, String mail, String salt, String password,
			String hashedPassword, int level, int training_program_id, int food_id, Date last_login) {
		super();
		this.id = id;
		this.name = name;
		this.gender = gender;
		this.birth = birth;
		this.height = height;
		this.mail = mail;
		this.salt = salt;
		this.password = password;
		this.hashedPassword = hashedPassword;
		this.level = level;
		this.training_program_id = training_program_id;
		this.food_id = food_id;
		this.last_login = last_login;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public int getGender() {
		return gender;
	}


	public void setGender(int gender) {
		this.gender = gender;
	}


	public Date getBirth() {
		return birth;
	}


	public void setBirth(Date birth) {
		this.birth = birth;
	}


	public float getHeight() {
		return height;
	}


	public void setHeight(float height) {
		this.height = height;
	}


	public String getMail() {
		return mail;
	}


	public void setMail(String mail) {
		this.mail = mail;
	}


	public String getSalt() {
		return salt;
	}


	public void setSalt(String salt) {
		this.salt = salt;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getHashedPassword() {
		return hashedPassword;
	}


	public void setHashedPassword(String hashedPassword) {
		this.hashedPassword = hashedPassword;
	}


	public int getLevel() {
		return level;
	}


	public void setLevel(int level) {
		this.level = level;
	}


	public int getTraining_program_id() {
		return training_program_id;
	}


	public void setTraining_program_id(int training_program_id) {
		this.training_program_id = training_program_id;
	}


	public int getFood_id() {
		return food_id;
	}


	public void setFood_id(int food_id) {
		this.food_id = food_id;
	}


	public Date getLast_login() {
		return last_login;
	}


	public void setLast_login(Date last_login) {
		this.last_login = last_login;
	}

	
	
	
}
	
	