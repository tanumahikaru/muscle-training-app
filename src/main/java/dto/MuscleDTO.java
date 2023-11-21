package dto;

public class MuscleDTO {
	private int training_event_id;
	private String event_name;
	private int mets;
	private String movie_url;
	private int default_number;
	private int default_time;
	
	public MuscleDTO(int training_event_id, String event_name, int mets, String movie_url, int default_number,
			int default_time) {
		super();
		this.training_event_id = training_event_id;
		this.event_name = event_name;
		this.mets = mets;
		this.movie_url = movie_url;
		this.default_number = default_number;
		this.default_time = default_time;
	}

	public int getTraining_event_id() {
		return training_event_id;
	}

	public void setTraining_event_id(int training_event_id) {
		this.training_event_id = training_event_id;
	}

	public String getEvent_name() {
		return event_name;
	}

	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}

	public int getMets() {
		return mets;
	}

	public void setMets(int mets) {
		this.mets = mets;
	}

	public String getMovie_url() {
		return movie_url;
	}

	public void setMovie_url(String movie_url) {
		this.movie_url = movie_url;
	}

	public int getDefault_number() {
		return default_number;
	}

	public void setDefault_number(int default_number) {
		this.default_number = default_number;
	}

	public int getDefault_time() {
		return default_time;
	}

	public void setDefault_time(int default_time) {
		this.default_time = default_time;
	}
	
	
}
