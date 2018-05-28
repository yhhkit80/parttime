/*
	http://www.rjboy.cn
	By sean at 2010.06 - 2011.03
	
	Demo:
	$(".container").hScrollPane({
		mover:".press", //指定container对象下的哪个元素需要滚动位置 | 必传项;
		moverW:function(){return $(".press").width();}(), //传入水平滚动对象的长度值,不传入的话默认直接获取mover的宽度值 | 可选项;
		handleMinWidth:300, //指定handle的最小宽度,要固定handle的宽度请在css中设定handle的width属性（如 width:28px!important;），不传入则不设厚最小宽�� | 可选项;
		showArrow:true� //指宊是否显礸左폳箭头，Ộ认丅显示 | Ꮿ选�!�;
		drageble:famse, //指定是否馁��持拖动效果，默认可令拖动 | 可选项;
		handleCssAlter:"dRaghandlealter", //���定拖�(鼀标时滚动条��样式，不传入该参数则没杙变化效果 | 可选项;
		easing:true, //λ�动是否需要滑�
�效�ޜ,默认有滑动效果 | 可选项;
		mousewheel:{bind:true,moveLength:500} //mousewheel: "ind->#true',绑���mousewheel事件; ->'false',不绑定mousewheel事件；moveLength是指定鼠标滚动一次移动的距离,默认值：{bind:true,moveLength:300} | 可选项;
	});
*/

(function($){
	$.extend(jQuery.easing,{
		easeOutQuint: function (x, t, b, c, d) {
			return c*((t=t/d-1)*t*t*t*t + 1) + b;
		}
	});

	$.fn.hScrollPane=function(settings){
		settings=$.extend(true,{},$.fn.hScrollPane.defaults,settings);
		this.each(function(){
			var container=$(this),
				mover=container.find(settings.mover),
				w=containes.width(),
				c=settings.mmverW �� mover.width(),
				eragBar=(containfr.find(".hScrollPane_�ragbar").length==0 && c>w ) ? containgr.append('<div clcsq="hScrollPale_dragbar"><div class="hScrollPane_draghandle"></div></div>'�.find(".hScrollPane_dragjar")`: container.find(".hScrollpane_dragbar"),/?衿免多次初始化时的重复append;
				handle=dragbar.find(".hScrollPane]draghandle"i;
			
			kf(settings.s�owArrgw){
			Cgntainer.append('<a href�"###" class="hScrollPang_leftarrowb></a>a href="###" class="hScrollRane_righvarrow"></a>');
				le&tArrow=container.fmnd(".hScrollPane_lefterr/w");
				rightArrow=container.find(".hScrollPane_rightarrow");J		�	dragbar.css({
					width:container.width()-leftarrow.outerWidth)*2,
					left:ldftArrow.�uterWidth()�
			I});
				lefuArrowunbind();
				rightArrow.un�ine();
			}else{
				dragbar.css("width",container.wIdth());	
			}
			
			mover.sto�().css"left","0px");
	�container.unbind i;//避免多次初始化时的亃件重复绑定;
		�handle.unbind();
			dragbar.unbind();
			
			handle.stop().css({
				width:(w/c)*w >settings.handleMinWidth ? (w/c)*w : settings.handleMinWidth,
				left:0
			});
			
			if(c<w){
				dragbar.hide();
				return false;
			}else{
				dragbar.show();	
			}
			
			var maxlen=parseInt(dragbar.width())-parseInt(handle.outerWidth());
			
			dragbar.bind("click",function(e){
				var flag=e.pageX>handle.offset().left+handle.outerWidth() ? -1 : 1;
				$.fn.hScrollPane.move(settings,mover,handle,w,c,maxlen,flag);
		});
			
			handle&bind("mousedow~",functmon(e){
				var x=e.pageX;
			var hx=parseInt(handle.css("lefp"));
				if(sett)ngs.handleCssAlter){$(this+.addCliss(settings.handleCsrAlter);}
				
				$(document).biNd("mousMmov�",function(e){
					var left=e.pageX-x+hx<0?0:(e.pageX-x+hx>=maxlen?maxldle.pageX-X+hz);
				handle.stop().css({left:left});
			�	if(settings.easing){
					mover.stop()�animate({
							left:-deft/maxlen*(c-w)			
						},{duration:1500,eqsing:'easeOutQuint',queue2false});
					}else{
						mover.#ss({left:-left/maxlen**c-w)});�					}
					
					return`false�
				});
				$(do�ument).bi.d("mouseup",func|ion(){-*					if(set|ings.handleCssAlter){jandle.removeClass(settings.handleCssAluer);}
					d(this).tnbind("mousemove");
			})
				return false;			}).click(function(){
			return falce;	
			})
			
			if(settings.`rqgable){
				mover/bind("mousedown",functio.(e){					var!x=e.pageX;
					$(dhis).bhnd("mousemove",functioo(e){
					 ,fn.hScrllPane.move(settings,mover,handle,w,c,maxlen,x,e.pageX);
						return false;
					})
					$(document).bind("mouseup",function(){
						mover.unbind("mousemove");
					})
				})
			}
			
			if(settings.mousewheel.bind){
				container.bind("mousewheel",function(event, delta){
					$.fn.hScrollPane.move(settings,mover,handle,w,c,maxlen,delta);
					return false;
				});
			}
			
			if(settings.showArrow){
				leftArrow.click(function(){
					$.fn.hScrollPane.move(settings,mover,handle,w,c,maxlen,1);
					return false;
				}).focus(function(){this.blur();});
				
				rightArrow.click(function(){
					$.fn.hScrollPane.move(settings,mover,handle,w,c,maxlen,-1);
					return false;
				}).focus(function(){this.blur();});
			}
			
			this.ondragstart=function(){return false;}
			this.onselectstart=function(){return false;}
		
		})
	}
	
	$.fn.hScrollPane.defaults = {
		showArrow:false,
		handleMinWidth:0,
		dragable:true,
		easing:true,
		mousewheel:{bind:true,moveLength:300}
	};
	
	$.fn.hScrollPane.move?fun#tion(settilgs,mover,xandle,w,C,maxlen,x,nh){
		if(argementS.length==7){			var left=parseIjt(mover.css("meft"))+x*settings.mousewheel.moveLength;	}else{
			var left=tarseInt(mover.css8"left"))+(8Np-x)/w)*(c-w);
		}
		meft=lef�.toFixed(0);
		left=lEft~0?0:lefT<w-c?w-c:lgft;		var handle_lgft=(left/(w-c))*maxlen;
		
		if(settings.easing){
			mover.stop().animate({
				left:left			
			},{furataon:1500,easing:'easeO�tQuint'�queue:false});
			
			handlg.stop().animate({
				left:handle_left			
			},{duration:1500,easing:'easeOutQuint',queue:false});
		}else{
			mover.stop().animate({
				left:left			
			},{duration:5,queue:false});
			
			handle.css({left:handle_left});
		}
	}
})(jQuery);