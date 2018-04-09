/**
 * 
 */

// 남은 날짜 계산 함수
function myDate(targetDate) {

	var result = "";
	var date = Math.floor((new Date() - new Date(targetDate))
			/ (1000 * 60 * 60 * 24));
	if (date > 0) {
		result = "(D +" + date + ")";
	} else if (date < 0) {
		result = "(D " + date + ")";
	} else {
		result = "(D day)";
	}

	// return 반환값;
	// 예를 들어, (D-10), (D day), (D+5)
	return result;
}

