public class Validate {

	// nullチェックを行う
	private void checkName(String name) {// [40]
        if (!checkNull(name)) {//[41]
            messageOfNameCheck = "nullチェックでエラーです。";//[42]
            return;//[43]
        }
        if (!checkEmpty(name)) {//[44]
            messageOfNameCheck = "文字が入力されていません。";//[45]
            return;//[46]
        }
        return;
	}

	// 文字列の長さが指定範囲内かどうかをチェックする
	public boolean stringLengthCheck(String str, int minLength, int maxLength) {
		if(str.length() < minLength && maxLength < str.length()) {
			// パスワードの長さが指定範囲外だった場合falseを返す
			return false;
		}
	}


	public boolean passwordIsValid(String str, int minLength, int maxLength, ) {

	}
}