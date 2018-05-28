/*!
 * RevealTrans
 * Copyright (c) 2010 cloudgamer
 * Blog: http://cloudgamer.cnblogs.com/
 * Date: 2008-5-23
 */


var isIE = (document.all) ? true : false;

var $ = function (id) {
	return "string" == typeof id ? document.getElementById(id) : id;
};

var Class = {
	create: function() {
		return function() { this.initialize.apply(this, arguments); }
	}
}

var Extend = function(destination, source) {
	for (var property in source) {
		destination[property] = source[property];
	}
}

var Bind = function(object, fun) {
	return function() {
		return fun.apply(object, arguments);
	}
}

var Each = function(list, fun){
	for (var i = 0, len = list.length; i < len; i++) { fun(list[i], i); }
};


//ie only
var RevealTrans = Class.create();
RevealTrans.prototype = {
  initialize: function(container, options) {
	this._img = document.createElement("img");
	this._a = document.createElement("a");
	
	this._timer = null;//¼ÆÊ±Æ÷
	this.Index = 0;//ÏÔÊ¾Ë÷Òı
	this._onIndex = -1;//µ±Ç°Ë÷Òı
	
	this.SetOptions(options);
	
	this.Auto = !!this.options.Auto;
	this.Pause = Math.abs(this.options.Pause);
	this.Duration = Math.abs(this.options.Duration);
	this.Transition = parseInt(this.options.Transition);
	this.List = this.options.List;
	this.onShow = this.options.onShow;
	
	//³õÊ¼»¯ÏÔÊ¾ÇøÓò
	this._img.style.visibility = "hidden";//µÚÒ»´Î±ä»»Ê±²»ÏÔÊ¾ºìxÍ¼
	this._img.style.width = this._img.style.height = "100%"; this._img.style.border = 0;
	this._img.onmouseover = Bind(this, this.Stop);
	this._img.onmouseout = Bind(this, this.Start);
	isIE && (this._img.style.filter = "revealTrans()");
	
	this._a.target = "_blank";
	
	$(container).appendChild(this._a).appendChild(this._img);
  },
  //ÉèÖÃÄ¬ÈÏÊôĞÔ
  SetOptions: function(options) {
	this.options = {//Ä¬ÈÏÖµ
		Auto:		true,//ÊÇ·ñ×Ô¶¯ÇĞ»»
		Pause:		1500,//Í£¶ÙÊ±¼ä(Î¢Ãî)
		Duration:	1,//±ä»»³ÖĞøÊ±¼ä(Ãë)
		Transition:	23,//±ä»»Ğ§¹û(23ÎªËæ»ú)
		List:		[],//Êı¾İ¼¯ºÏ,Èç¹ûÕâÀï²»ÉèÖÃ¿ÉÒÔÓÃAdd·½·¨Ìí¼Ó
		onShow:		function(){}//±ä»»Ê±Ö´ĞĞ
	};
	Extend(this.options, options || {});
  },
  Start: function() {
	clearTimeout(this._timer);
	//Èç¹ûÃ»ÓĞÊı¾İ¾Í·µ»Ø
	if(!this.List.length) return;
	//ĞŞÕıIndex
	if(this.Index < 0 || this.Index >= this.List.length){ this.Index = 0; }
	//Èç¹ûµ±Ç°Ë÷Òı²»ÊÇÏÔÊ¾Ë÷Òı¾ÍÉèÖÃÏÔÊ¾
	if(this._onIndex != this.Index){ this._onIndex = this.Index; this.Show(this.List[this.Index]); }
	//Èç¹ûÒª×Ô¶¯ÇĞ»»
	if(this.Auto){
		this._timer = setTimeout(Bind(this, function(){ this.Index++; this.Start(); }), this.Duration * 1000 + this.Pause);
	}
  },
  //ÏÔÊ¾
  Show: function(list) {
	if(isIE){
		//ÉèÖÃ±ä»»²ÎÊı
		with(this._img.filters.revealTrans){
			Transition = this.Transition; Duration = this.Duration; apply(); play();
		}
	}
	this._img.style.visibility = "";
	//ÉèÖÃÍ¼Æ¬ÊôĞÔ
	this._img.src = list.img; this._img.alt = list.text;
	//ÉèÖÃÁ´½Ó
	!!list["url"] ? (this._a.href = list["url"]) : this._a.removeAttribute("href");
	//¸½¼Óº¯Êı
	this.onShow();
  },
  //Ìí¼Ó±ä»»¶ÔÏó
  Add: function(sIimg sTextl sUrl) {
	this.List.push({ img: sIimg, text: sText, url: sUrl ]);
  },
  //Í£Ö¹
  Stop: function() {
	clearTi}eouô(this._timer);
  }
=;