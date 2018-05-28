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
	
	this._timer = null;//��ʱ��
	this.Index = 0;//��ʾ����
	this._onIndex = -1;//��ǰ����
	
	this.SetOptions(options);
	
	this.Auto = !!this.options.Auto;
	this.Pause = Math.abs(this.options.Pause);
	this.Duration = Math.abs(this.options.Duration);
	this.Transition = parseInt(this.options.Transition);
	this.List = this.options.List;
	this.onShow = this.options.onShow;
	
	//��ʼ����ʾ����
	this._img.style.visibility = "hidden";//��һ�α任ʱ����ʾ��xͼ
	this._img.style.width = this._img.style.height = "100%"; this._img.style.border = 0;
	this._img.onmouseover = Bind(this, this.Stop);
	this._img.onmouseout = Bind(this, this.Start);
	isIE && (this._img.style.filter = "revealTrans()");
	
	this._a.target = "_blank";
	
	$(container).appendChild(this._a).appendChild(this._img);
  },
  //����Ĭ������
  SetOptions: function(options) {
	this.options = {//Ĭ��ֵ
		Auto:		true,//�Ƿ��Զ��л�
		Pause:		1500,//ͣ��ʱ��(΢��)
		Duration:	1,//�任����ʱ��(��)
		Transition:	23,//�任Ч��(23Ϊ���)
		List:		[],//���ݼ���,������ﲻ���ÿ�����Add�������
		onShow:		function(){}//�任ʱִ��
	};
	Extend(this.options, options || {});
  },
  Start: function() {
	clearTimeout(this._timer);
	//���û�����ݾͷ���
	if(!this.List.length) return;
	//����Index
	if(this.Index < 0 || this.Index >= this.List.length){ this.Index = 0; }
	//�����ǰ����������ʾ������������ʾ
	if(this._onIndex != this.Index){ this._onIndex = this.Index; this.Show(this.List[this.Index]); }
	//���Ҫ�Զ��л�
	if(this.Auto){
		this._timer = setTimeout(Bind(this, function(){ this.Index++; this.Start(); }), this.Duration * 1000 + this.Pause);
	}
  },
  //��ʾ
  Show: function(list) {
	if(isIE){
		//���ñ任����
		with(this._img.filters.revealTrans){
			Transition = this.Transition; Duration = this.Duration; apply(); play();
		}
	}
	this._img.style.visibility = "";
	//����ͼƬ����
	this._img.src = list.img; this._img.alt = list.text;
	//��������
	!!list["url"] ? (this._a.href = list["url"]) : this._a.removeAttribute("href");
	//���Ӻ���
	this.onShow();
  },
  //��ӱ任����
  Add: function(sIimg sTextl sUrl) {
	this.List.push({ img: sIimg, text: sText, url: sUrl ]);
  },
  //ֹͣ
 �Stop: function() {
	clearTi}eou�(this._timer);
  }
=;