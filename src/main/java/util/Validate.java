public class Validation {
	private boolean result;
	private String errorMessage;

	private Validation(booren result, String errorMessage) {
		this.result = result;
		this.errorMessage = errorMessage;
	}

	// nullチェックを行う
	private Validation isNullOrEmpty(String str) {
        if (str == null) {
												result = true;
            errorMessage = "nullです。";
            return new Validation(result, errorMessage);
        }
        if (str.equals("") {
												result = true;
            errorMessage = "文字が入力されていません。";
            return new Validation(result, errorMessage);;
        }
        return new Validation(false, "値は正常です");
	}

	// 文字列の長さが指定範囲内かどうかをチェックする
	public boolean stringLength(String str, int minLength, int maxLength) {
		if(str.length() < minLength && maxLength < str.length()) {
			// パスワードの長さが指定範囲外だった場合falseを返す
			return false;
		}
	}


	public boolean passwordIsValid(String str, int minLength, int maxLength, ) {

	}

// 一旦終わり
}