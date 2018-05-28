// JavaScript Document滚动条效果
var o1 = document.getElementById('slider'),
	o2 = document.getElementById('pannel'),
	o3 = document.getElementById('drag');
function customBar(oSlider, oPanel, oTrigger){
	this.parent = oSlider.parentNode;
	this.slider = oSlider;
	this.panel = oPanel;
	this.trigger = oTrigger;
	
	this.h1 = this.parent.clientHeight;
	this.h2 = this.slider.offsetHeight;
	this.h3 = this.panel.clientHeight;
	this.h4 = this.trigger.offsetHeight;
	
	this.k = (this.h2 - this.h1)/(this.h3 - this.h4);
	this.dis = 0;
	this.flag = false;
	
	this.init();
}
customBar.prototype = {
	init: function(){
		if(this.k <= 0){
			this.panel.style.display = 'none';
			return;
		}
		this.slider.style.top = '0px';
		this.trigger.style.top = '0px';
		this.bind();		
	},
	bind: function(){
		var that = this;
		this.trigger.onmousedown = function(e){
			that.down.call(that, e);	
		}
		this.trigger.onmousemove = document.onmousemove = function(e){
			that.move.call(that, e);
		}
		this.trigger.onmouseup = document.onmouseup = function(e){
			that.up.call(that, e);
		}
	},
	down: function(e){
		var e = window.event || e,
			y1 = e.y || e.pageY,
			y2 = parseInt(this.trigger.style.top);
		this.dis = (y1 - y2);
		this.flag = true;
		this.move(e);
	},
	move: function(e){
		if(!this.flag) return;
		var e = window.event || e,
			y1 = e.y || e.pageY,
			dis;
		dis = Math.min(Math.max(y1 - this.dis, 0), (this.h3 - this.h4));
		this.slider.style.top = -dis * this.k + 'px';
		this.trigger.style.top = dis + 'px';
	},
	up: function(){
		this.flag = false;
	},
	wheel: function(){
		
	}
}
var ss = new customBar(o1, o2, o3);