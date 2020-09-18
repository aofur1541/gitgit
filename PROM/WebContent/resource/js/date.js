// yyyy-MM-dd HH:mm:ss
function dateTimeConverter(date) {
	var date = new Date(date);
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();
	var hour = date.getHours();
	var min = date.getMinutes();
	var sec = date.getSeconds();

	return year + '-' + (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day) + ' ' + (hour < 10 ? '0' + hour : hour) + ':' + (min < 10 ? '0' + min : min) + ':' + (sec < 10 ? '0' + sec : sec);
}

// HH:mm:ss
function timeConverter(date) {
	var date = new Date(Number(date));
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();
	var hour = date.getHours();
	var min = date.getMinutes();
	var sec = date.getSeconds();

	return (hour < 10 ? '0' + hour : hour) + ':' + (min < 10 ? '0' + min : min) + ':' + (sec < 10 ? '0' + sec : sec);
}

// yyyy-MM-dd
function dateConverter(date) {
	var date = new Date(date);
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();
	var hour = date.getHours();
	var min = date.getMinutes();
	var sec = date.getSeconds();

	return year + '-' + (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day);
}

// 오늘 일자
function todayConverter(dateType) {
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();
	
	// 오늘 일자 yyyy-MM-dd
	if (dateType == 'today') {
		return year + '-' + (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day);
	}

	// 어제 일자 yyyy-MM-dd
	if (dateType == 'date') {
		date = new Date(date.setDate(date.getDate() - 1));
		year = date.getFullYear();
		month = date.getMonth() + 1;
		day = date.getDate();
		
		return year + '-' + (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day);
	}

	// 이번 달 yyyy-MM
	if (dateType == 'month') {
		return year + '-' + (month < 10 ? '0' + month : month);
	}

	// 이번 주 yyyy-W
	if (dateType == 'week') {
		date.setHours(0, 0, 0);
		date.setDate(date.getDate() + 4 - (date.getDay() || 7));
		
		var yearStart = new Date(date.getFullYear(), 0, 1);
		var weekNo = Math.ceil((((date - yearStart) / 86400000) + 1) / 7);
		
		return year + '-' + 'W' + (weekNo < 10 ? '0' + weekNo : weekNo);
	}
}

// 오전/오후 HH:mm:ss
function currentTime() {
	var date = new Date();
	var hour = date.getHours();
	var min = date.getMinutes();
	var sec = date.getSeconds();
	var ampm = '오전 ';
	
	if (hour >= 12) {
		ampm = '오후 ';
		
		if (hour > 12) {
			hour = (hour-12);
		}
	}

	return ampm + hour + ':' + (min < 10 ? '0' + min : min) + ':' + (sec < 10 ? '0' + sec : sec);
}