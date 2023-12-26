package dto;

public class RecipeDTO {
	private int food_id;
	private int step;
	private String explanation;
	
	public RecipeDTO(int food_id, int step, String explanation) {
		super();
		this.food_id = food_id;
		this.step = step;
		this.explanation = explanation;
	}
	public int getFood_id() {
		return food_id;
	}
	public void setFood_id(int food_id) {
		this.food_id = food_id;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	
	}
