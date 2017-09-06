//==============jquery 扩展===============
/**
 * 用于将form表单域转换为json object
 */
$.fn.jsonObject = function () {
	var jsonObj = {};
	var a = this.serializeArray();
	$.each(a, function () {
		if (jsonObj[this.name]) {	//如果已存在了,那么转换为数组
			if (!jsonObj[this.name].push) {
				jsonObj[this.name] = [jsonObj[this.name]];	//转为数组
			}
			jsonObj[this.name].push(this.value || "");
		} else {
			jsonObj[this.name] = this.value || "";
		}
	});
	return jsonObj;
};
/**
 * 用于将json object填充到form表单
 */
$.fn.fillForm = function(jsonObj) {
	jsonObj=jsonObj||{};
	var elements=this[0].elements;
	for(var p in jsonObj) {
		if(elements[p] && (elements[p].tagName=="INPUT" || elements[p].tagName=="SELECT" || elements[p].tagName=="TEXTAREA")) {
			elements[p].value=jsonObj[p]==null?"":jsonObj[p];
		}
	}
};



