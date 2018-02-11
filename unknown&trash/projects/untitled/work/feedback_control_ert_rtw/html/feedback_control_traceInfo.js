function RTW_Sid2UrlHash() {
	this.urlHashMap = new Array();
	/* <Root>/u */
	this.urlHashMap["feedback_control:1"] = "feedback_control.c:44,54,63&feedback_control.h:46";
	/* <Root>/y */
	this.urlHashMap["feedback_control:2"] = "feedback_control.c:51&feedback_control.h:51";
	/* <S1>/Derivative Gain */
	this.urlHashMap["feedback_control:4:1658"] = "feedback_control.c:43&feedback_control.h:58&feedback_control_data.c:32";
	/* <S1>/Filter */
	this.urlHashMap["feedback_control:4:1660"] = "feedback_control.c:42,68&feedback_control.h:41";
	/* <S1>/Filter Coefficient */
	this.urlHashMap["feedback_control:4:1661"] = "feedback_control.c:41&feedback_control.h:59&feedback_control_data.c:33";
	/* <S1>/Integral Gain */
	this.urlHashMap["feedback_control:4:1657"] = "feedback_control.c:62&feedback_control.h:60&feedback_control_data.c:34";
	/* <S1>/Integrator */
	this.urlHashMap["feedback_control:4:1659"] = "feedback_control.c:52,61&feedback_control.h:40";
	/* <S1>/Proportional Gain */
	this.urlHashMap["feedback_control:4:1656"] = "feedback_control.c:53&feedback_control.h:61&feedback_control_data.c:35";
	/* <S1>/Sum */
	this.urlHashMap["feedback_control:4:1655"] = "feedback_control.c:55";
	/* <S1>/SumD */
	this.urlHashMap["feedback_control:4:1662"] = "feedback_control.c:45";
	this.getUrlHash = function(sid) { return this.urlHashMap[sid];}
}
RTW_Sid2UrlHash.instance = new RTW_Sid2UrlHash();
function RTW_rtwnameSIDMap() {
	this.rtwnameHashMap = new Array();
	this.sidHashMap = new Array();
	this.rtwnameHashMap["<Root>"] = {sid: "feedback_control"};
	this.sidHashMap["feedback_control"] = {rtwname: "<Root>"};
	this.rtwnameHashMap["<S1>"] = {sid: "feedback_control:4"};
	this.sidHashMap["feedback_control:4"] = {rtwname: "<S1>"};
	this.rtwnameHashMap["<Root>/u"] = {sid: "feedback_control:1"};
	this.sidHashMap["feedback_control:1"] = {rtwname: "<Root>/u"};
	this.rtwnameHashMap["<Root>/Discrete PID Controller"] = {sid: "feedback_control:4"};
	this.sidHashMap["feedback_control:4"] = {rtwname: "<Root>/Discrete PID Controller"};
	this.rtwnameHashMap["<Root>/y"] = {sid: "feedback_control:2"};
	this.sidHashMap["feedback_control:2"] = {rtwname: "<Root>/y"};
	this.rtwnameHashMap["<S1>/u"] = {sid: "feedback_control:4:1"};
	this.sidHashMap["feedback_control:4:1"] = {rtwname: "<S1>/u"};
	this.rtwnameHashMap["<S1>/Derivative Gain"] = {sid: "feedback_control:4:1658"};
	this.sidHashMap["feedback_control:4:1658"] = {rtwname: "<S1>/Derivative Gain"};
	this.rtwnameHashMap["<S1>/Filter"] = {sid: "feedback_control:4:1660"};
	this.sidHashMap["feedback_control:4:1660"] = {rtwname: "<S1>/Filter"};
	this.rtwnameHashMap["<S1>/Filter Coefficient"] = {sid: "feedback_control:4:1661"};
	this.sidHashMap["feedback_control:4:1661"] = {rtwname: "<S1>/Filter Coefficient"};
	this.rtwnameHashMap["<S1>/Integral Gain"] = {sid: "feedback_control:4:1657"};
	this.sidHashMap["feedback_control:4:1657"] = {rtwname: "<S1>/Integral Gain"};
	this.rtwnameHashMap["<S1>/Integrator"] = {sid: "feedback_control:4:1659"};
	this.sidHashMap["feedback_control:4:1659"] = {rtwname: "<S1>/Integrator"};
	this.rtwnameHashMap["<S1>/Proportional Gain"] = {sid: "feedback_control:4:1656"};
	this.sidHashMap["feedback_control:4:1656"] = {rtwname: "<S1>/Proportional Gain"};
	this.rtwnameHashMap["<S1>/Sum"] = {sid: "feedback_control:4:1655"};
	this.sidHashMap["feedback_control:4:1655"] = {rtwname: "<S1>/Sum"};
	this.rtwnameHashMap["<S1>/SumD"] = {sid: "feedback_control:4:1662"};
	this.sidHashMap["feedback_control:4:1662"] = {rtwname: "<S1>/SumD"};
	this.rtwnameHashMap["<S1>/y"] = {sid: "feedback_control:4:10"};
	this.sidHashMap["feedback_control:4:10"] = {rtwname: "<S1>/y"};
	this.getSID = function(rtwname) { return this.rtwnameHashMap[rtwname];}
	this.getRtwname = function(sid) { return this.sidHashMap[sid];}
}
RTW_rtwnameSIDMap.instance = new RTW_rtwnameSIDMap();
