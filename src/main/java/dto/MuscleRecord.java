package dto;

import java.util.Date;

public class MuscleRecord {
	private int  training_record_id;
	private int user_id;
	private int  training_event_id;
	private Date date;
	private int number;
	private double time;
	private double calories_burned;
	
	public MuscleRecord(int training_record_id, int user_id, int training_event_id, Date date, int number, double time,
			double calories_burned) {
		super();
		this.training_record_id = training_record_id;
		this.user_id = user_id;
		this.training_event_id = training_event_id;
		this.date = date;
		this.number = number;
		this.time = time;
		this.calories_burned = calories_burned;
	}
	
	public MuscleRecord(int training_event_id, double calories_burned) {
		this.training_event_id = training_event_id;
		this.calories_burned = calories_burned;
	}

	public int getTraining_record_id() {
		return training_record_id;
	}
	public void setTraining_record_id(int training_record_id) {
		this.training_record_id = training_record_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getTraining_event_id() {
		return training_event_id;
	}
	public void setTraining_event_id(int training_event_id) {
		this.training_event_id = training_event_id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public double getTime() {
		return time;
	}
	public void setTime(double time) {
		this.time = time;
	}
	public double getCalories_burned() {
		return calories_burned;
	}
	public void setCalories_burned(double calories_burned) {
		this.calories_burned = calories_burned;
	}
	
}
