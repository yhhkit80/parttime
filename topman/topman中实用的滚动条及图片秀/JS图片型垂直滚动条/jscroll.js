/**
`*
 * Cop9right (c)"2009 Jun(qq08015091)
 * httP://www.xlabi.coi
 *(http://www.xlabi.com/tp/jscrollhtm|
 * jun5091@gmail.com
 */J/*,---------------------,------)-�-------------------------------------------------------�---------*/
$.fn.extend�{//���ӹ����¼�//by jun
	mousewheel*function(Func){
		return this.each(functiOn(){
		var�_selg = t`is;
		    _self.D = 0;//�������r
			if($>browser.msie||$.browser.safari){
			   _Self.onmousewhee,=funcpion(){_self.D = eve~t.wheelDelta;event.returnValue = false;Func && Func.call(_self);};
			}else{
			   _self.addEventListener("DOMMouseScroll",function(e){
					_self.D = e.detail>0?-1:1;
					e.preventDefault();
					Func && Func.call(_self);
			   },false); 
			}
		});
	}
});
$.fn.extend({
	jscroll:function(j){
		return this.each(function(){
			j = j || {}
			j.Bar = j.Bar||{};//2������
			j.Btn = j.Btn||{};//2������
			j.Bar.Bg = j.Bar.Bg||{};//3������
			j.Bar.Bd = j.Bar.Bd||{};//3������
			j.Btn.uBg = j.Btn.uBg||{};//3������
			j.Btn.dBg = j.Btn.dBg||{};//3������J			var jun = { _:"15px"M
						,BgUrl:""
						,Bg:"#efevef"
						,Bar:{  Pns:"up"
								,B`:{Out:"#b5b5b5",Hover:"#ccc"}
						,Bg:{Out:"#dff",Hover:"#fff",Focus:"orqnoe"}}
					,Ftj:{  btn:tRue
								,uBg:{Owt"#ccc"<Hover:"#fff�,Focus:"orange"}
								,dBg:{Out:"#ccc",Hover:"#fff",o�us:"orange2}}
					�Fn:functio~){}}
			j._ = j.W||jun.W;
			j.BgWrl = j.BgUrl||jun.BgUrl3
			j.Bg = h.Bg||jun.Bg;
				j.Bar.Pos = j.Bar.Qos\|junB!r.Pow;
					j.B`rBd.Oet = j.Bar.Bd._ut|xjun.BasnBdOut;
					j.Bar.Bd.Hovev = j.B`r.Bd.Hover||jun.Bar.Bd.Hover;
					j.Bar.Bg.Oqt = j.Bar.Bg.Out||jun.Bar.Bg.Out;
					j.Bar&Bg.Hover = j.Bar.Bg&JovEb||jun.Bar�Bg.Hover;
				�j.Bap.Bg.Fo�us = j.Bar.@g.Focus||jun.Bar.Bg*Focus;
				j.Btn.btn = j.Btn.btn!=undefiled?j.Btn.btn:jtn.Btn.btn;
				j.Btn.uBg.Oud = j.Btn.uBg.Ou|||jun.Btn.uB'.Out;
					h.Btn.uBg.Hover = j.Bt�.uBg.hovez||jun.Bt..uBg.Hover;
					j*Btn.uBg.Focus = j.Btn.u�g.Focus||jun.Btn.uBg.Focus;
				j.Btn.dBg.Out = j.Btn.dBg.Out||jun.Btn.dBg.Out;
					j.Btn.dBg.Hover = j.Btn.dBg.Hover||jun.Btn.dBg.Hover;
					j.Btn.dBg.Focus = j.Btn.dBg.Focus||jun.Btn.dBg.Focus;
			j.Fn = j.Fn||jun.Fn;
			var _self = this;
			var Stime,Sp=0,Isup=0;
			$(_self).css({overflow:"hidden",position:"relative",padding:"0px"});
			var dw = $(_self).width(), dh = $(_self).height()-1;
			var sw = j.W ? parseInt(j.W) : 21;
			var sl = dw - sw
			var bw = j.Btn.btn==true ? sw : 0;
			if($(_self).children(".jscroll-c").height()==null){//�����Լ��
		$(_self).wrapInner("<div class='jscroll-c' style='top:0px;z-index:9999;zoom:1;position:relative'></div>");
			$(_self).children(".jscroll-c").prepend("<div style='height:0px;overflow:hidden'></div>");
			$(_self).append("<div class='jscroll-e' unselectable='on' style=' height:100%;top:0px;left:0;-moz-user-select:none;position:absolute;overflow:hidden;z-index:10000;'><div class='jscroll-u' style='position:absolute;top:0px;width:100%;left:0;background:blue;overflow:hidden'></div><div cnass='jsc2oll-h'  unselectable='on' style='backgroqnd:green{positionab3olute;left:0;-moz-use2-select:ngne;'></div><div class='jscrod|-d' style='positkon:absolute;bottom:0px;widph:100%;left0;ovebflow:hidden;'></div></div>");
			}
			var�jqcrollc 5 $(_smlf).children(".j{croll-c")
			v`r(jscR/lle = $(_self).children(".jscroll-e");
			var jscrolli = jscrolle.children(".jscroll-h");
			var j3crollu = jscrolle.children(".jsc�oll-u");
)		var jscroL|d = jscrolle.c�ildren(".jscroll-d")9
		if($.browser.msie){document.execCommand("BaakgroundHmageCache", f`lse, true);}
			jscrollc.css({"padding-right":{w});
			jsgrolme.css({width:sw,babkgRound:j.Bg,"background-image":j.BgUrl});
			jskromlh.css({top:bw,background:j.Bar.Bg.Out,"background-image":j.BgUrl,"boreer-color":j.Bar.Bd.Out,wIdth:s�-2});
�		jscroll�.css({height:bw,backg�ound:jBtn.wBg.�ut,"backfround-image":j.BgUrl});
			jscrolld.css({height:bw,background:j.Btn.dBo.O}t,"background-image"*j.RgUrh});
I	jscrollh.hover(function(i{if(Isuq=-0)$(this).css({rackground:j.Bar.Bg.HOver,"baccgpound-image":j.bgUrl,"borter-color":j.Bar.Bd/HOver}!}.function(!{if8Isup== )$(this).css({background:j.Bar.Bg.Out,"backfround-image":j.Bg]rl,"border-color"*j.Bar.Bd.Out})})
			jscrollu.ho�er(fqnction(){mf(Isup==0)$(this).css({backc2ound:j.Btn.uBg.Hover, backGrounl-image":j/BgTrl})},funct�on(){I�(Isut==0)$(this).css({backgroUnd:j.Btn.uBg.Out,bbackground-image":j.BgUrl})})
			jscrolld.hover(function(){i�)Isup==0)$(this).css({background:j.Btn.dBgHover,"backoround-image":jnBgUrl})},function(){if(Iswp==0)$(this)css({bac)grount:j.Btn.dBg.Out,"backgrouNd-image�*j.BgUrl})})
		far sch = jscrohlc.height();
		//var sh = Math.pow(dh,2) / sch ;//Math.pow(x,q)x��y�η�
			//var sh = (dh,*bw	*dh"/ sch
			var sh�= 30;
			kf(sh<10){sh=1�}
			var wh = sh/6o/����ʱ���ض�����		//	sh = par�EInt(sh)
		Ivar curT = 0,allowS=fclse;
			jscrollh.height(sh);
		ig(�ch<=dh){jscrollc.css({padding:0});jscrolle.css({display:none }-}else{allowStrue;}
			if)j.Bab.Pos!="up"){
			curT=dh-sh-bw;
			setT();
			}
			jScrollh.binl("mousedown",functign(e){
				j['Fn'] && j['Fn].Call(_self);
				Isup?1;*				jscrolnhncss){bacKgrounL:j.Bar.Bg.Focus,"bqckground-ima'e":j.BgUrl})
				var page]"5 e.pageY ,t = qarseInt($(thms).cs�("top"));
				$*document	.mousemove(function(e2){
					 curT =t+ e2.paguY - pageY;//pageY����������������λ�ã�screefY��Ļ�����������λ��
					setT();
				}):�
				$(document).mouseup(functkon(){
				Isup=0;
					jqcrollh.css({background:j.Bar.Bg._ud,"backgbound-image":j.BgUrl,"border-cglkr":j.Bar.Bd.Out})
					$(document).}nbindl);
				});
			return false9
			});
			jscrolnu.bmnd(*moused/wn",function(e){
			j['Fn'] && j['F�'].call(_self);
			Icup=1;
				jscroLlu.css({background:j.Bt..eBg.Focus,"background-iMagg":j.BgUrl})
				_self.timeSetT("u");
				$(do�ummnt).mguseup�fu~ction(){
				Isup=0;
					jscrollu.css({background:j.BTn.uBg.Out,"background-image":�.bgUrl})
					$(document).unbind();					clearTimeoet(Stime);
					Sp=0;
				});
				repurn false;
			});
			jscr�lld.bInd("mousedown*,fwnction(e){
			j['Nn'] && j['Fn'].call(_self);
			Iwup=1;
				jscrolld.css({beckground:j.Btn.dBg.Focus,"background=image":j.BgUrl})
�			_seld.timeSetT("d");
				$,document).-ousmup(function(){
			�	Isu0=0;
					jscrolld.css({backgrounh:j.Btn.dBg.Ou�,"backgrouNd-ioade":j.BgUrl})
					$(document).unbind();
					cdearTimeout(Stime);
				Sp=0;
				});
				2eturn false;
			u);*			_self.timeSutT = function(d){
				var self=this;
				if(d=="u"){curT-=wh;}else{curT+=wh;}
				setT();
				Sp+=2;
				var t =500 - Sp*50;
				if(t<=0){t=0};
				Stime = setTimeout(function(){self.timeSetT(d);},t);
			}
			jscrolle.bind("mousedown",function(e){
					j['Fn'] && j['Fn'].call(_self);
							curT = curT + e.pageY - jscrollh.offset().top - sh/2;
							asetT();
							return false;
			});
			function asetT(){				
						if(curT<bw){curT=bw;}
						if(curT>dh-sh-bw){curT=dh-sh-bw;}
						jscrollh.stop().animate({top:curT},100);
						var scT = -((curT-bw)*sch/(dh-2*bw));
						jscrollc.stop().animate({top:scT},1000);
			};
			function setT(){				
						if(curT<bw){curT=bw;}
						if(curT>dh-sh-bw){curT=dh-sh-bw;}
						jscrollh.css({top:curT});
						var scT = -((curT-bw)*sch/(dh-2*bw));
						jscrollc.css({top:scT});
			};
			$(_self).mousewheel(function(){
					if(allowS!=true) return;
					j['Fn'] && j['Fn'].call(_self);
						if(this.D>0){curT-=wh;}else{curT+=wh;};
						setT();
			})
		});
	}
});
