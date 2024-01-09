package dto;

public class Quiz {
	private int quizId;
	private String question;
	private String title;
	private String choices_1;
	private String choices_2;
	private String choices_3;
	private String choices_4;
	private int correct;
	private String explanation;
	private int status;
	
	
	// コンストラクタ
	public Quiz(int quizId, String question, String title, String choices_1, String choices_2, String choices_3,
			String choices_4, int correct, String explanation, int status) {
		super();
		this.quizId = quizId;
		this.question = question;
		this.title = title;
		this.choices_1 = choices_1;
		this.choices_2 = choices_2;
		this.choices_3 = choices_3;
		this.choices_4 = choices_4;
		this.correct = correct;
		this.explanation = explanation;
		this.status = status;
	}

	// コンストラクタ
	public Quiz(int quizId, String question, String title, String choices_1, String choices_2, String choices_3,
			String choices_4, int correct, int status) {
		super();
		this.quizId = quizId;
		this.question = question;
		this.title = title;
		this.choices_1 = choices_1;
		this.choices_2 = choices_2;
		this.choices_3 = choices_3;
		this.choices_4 = choices_4;
		this.correct = correct;
		this.status = status;
	}

	
	// getter及びsetter
	public int getQuizId() {
		return quizId;
	}

	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getChoices_1() {
		return choices_1;
	}

	public void setChoices_1(String choices_1) {
		this.choices_1 = choices_1;
	}

	public String getChoices_2() {
		return choices_2;
	}

	public void setChoices_2(String choices_2) {
		this.choices_2 = choices_2;
	}

	public String getChoices_3() {
		return choices_3;
	}

	public void setChoices_3(String choices_3) {
		this.choices_3 = choices_3;
	}

	public String getChoices_4() {
		return choices_4;
	}

	public void setChoices_4(String choices_4) {
		this.choices_4 = choices_4;
	}

	public int getCorrect() {
		return correct;
	}

	public void setCorrect(int correct) {
		this.correct = correct;
	}

	public String getExplanation() {
		return explanation;
	}

	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}	
	
}