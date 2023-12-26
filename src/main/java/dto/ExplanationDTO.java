package dto;

public class ExplanationDTO {
	private int training_event_id;
	private int step;
	private String explanation;
	
	public ExplanationDTO(int training_event_id, int step, String  explanation) {
		super();
		this.training_event_id = training_event_id;
		this.step = step;
		this.explanation = explanation;
	}

	public int getTraining_event_id() {
		return training_event_id;
	}

	public void setTraining_event_id(int training_event_id) {
		this.training_event_id = training_event_id;
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
