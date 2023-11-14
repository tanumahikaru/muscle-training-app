package dto;

import java.util.Date;

public class WeightDTO {
	private int user_id;
	private Date date;
	private float weight;
	
	public WeightDTO(int user_id, Date date, float weight) {
		super();
		this.user_id = user_id;
		this.date = date;
		this.weight = weight;
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
	
	public float getWeight() {
		return weight;
	}

	public void setWeight(float weight) {
		this.weight = weight;
	}
	
	
	
}
