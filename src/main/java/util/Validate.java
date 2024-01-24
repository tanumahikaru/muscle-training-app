public class Validation {
	private boolean result;
	private String errorMessage;

	private Validation(booren result, String errorMessage) {
		this.result = result;
		this.errorMessage = errorMessage;
	}

	// nullまたはemptyか判定する
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

	// 文字列の長さが指定範囲内か判定する
	public boolean isInvalidLengthOfString(String str, int minLength, int maxLength) {
		if(str.length() < minLength) {
			result = true;
			errorMessage = minLength + "文字以上で入力してください。";
			return new Validation(result, errorMessage);
		}
		if(maxLength < str.length()) {
			result = true;
			errorMessage = minLength + "文字以内で入力してください。";
			return new Validation(result, errorMessage);
		}

		return new Validation(false, "");
	}


	public Validation passwordIsValid(String password, int minLength, int maxLength, ) {
		Validation result；
		if((result = isNullOrEmpty(password))) {
			return result;
		}
		if((result = isInvalidLengthOfString(password))) {
			return result;
		}
		// 他にチェック項目があったら以降に追加する

		return result = new Validation(true);
	}

// 一旦終わり
}