package dto;

public class Meal_menuDTO {
	private int food_id;
	private String food_name;
	private int calorie;
	private int protein;
	private int fat;
	private int carbo;
	private boolean main_dish_flag ;
	
	public Meal_menuDTO(int food_id, String food_name, int calorie, int protein, int fat, int carbo,
			boolean main_dish_flag) {
		super();
		this.food_id = food_id;
		this.food_name = food_name;
		this.calorie = calorie;
		this.protein = protein;
		this.fat = fat;
		this.carbo = carbo;
		this.main_dish_flag = main_dish_flag;
	}

	public int getFood_id() {
		return food_id;
	}

	public void setFood_id(int food_id) {
		this.food_id = food_id;
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

	public int getProtein() {
		return protein;
	}

	public void setProtein(int protein) {
		this.protein = protein;
	}

	public int getFat() {
		return fat;
	}

	public void setFat(int fat) {
		this.fat = fat;
	}

	public int getCarbo() {
		return carbo;
	}

	public void setCarbo(int carbo) {
		this.carbo = carbo;
	}

	public boolean isMain_dish_flag() {
		return main_dish_flag;
	}

	public void setMain_dish_flag(boolean main_dish_flag) {
		this.main_dish_flag = main_dish_flag;
	}
		
}
