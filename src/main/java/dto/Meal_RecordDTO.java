package dto;

import java.util.Date;

public class Meal_RecordDTO {
	private int id;
	private int user_id;
	private Date date;
	private String food_name;
	private int calorie;
	private int food_id;
	
	
	public Meal_RecordDTO(int id, int user_id, Date date, String food_name, int calorie, int food_id) {	
		super();
		this.id = id;
		this.user_id = user_id;
		this.date = date;
		this.food_name = food_name;
		this.calorie = calorie;
		this.food_id = food_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getFood_name() {
		return food_name;
	}
	public void setFood_name(String food_name) {
		this.food_name = food_name;
	}
	public int getCalorie() {
		return calorie;
	}
	public void setCalorie(int calorie) {
		this.calorie = calorie;
	}
	public int getFood_id() {
		return food_id;
	}
	public void setFood_id(int food_id) {
		this.food_id = food_id;
	}
	
}