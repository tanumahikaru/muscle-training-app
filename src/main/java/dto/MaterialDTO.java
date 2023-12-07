package dto;

public class MaterialDTO {
	private int food_id;
	private int step;
	private String ingredients;
	private String quantity;
	
	public MaterialDTO(int food_id, int step, String ingredients, String quantity) {
		super();
		this.food_id = food_id;
		this.step = step;
		this.ingredients = ingredients;
		this.quantity = quantity;
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
	public String getIngredients() {
		return ingredients;
	}
	public void setIngredients(String ingredients) {
		this.ingredients = ingredients;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	
}
