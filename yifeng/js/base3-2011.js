//����������·�DIV�����Զ�����

var CookieUtil={};CookieUtil.setASCIICookie=function(e,f,b,c,a,d){if("string"==typeof(e)&&"string"==typeof(f)){f=escape(f);CookieUtil.setCookie(e,f,b,c,a,d);}};CookieUtil.setUnicodeCookie=function(e,f,b,c,a,d){if("string"==typeof(e)&&"string"==typeof(f)){f=encodeURIComponent(f);CookieUtil.setCookie(e,f,b,c,a,d);}};CookieUtil.setCookie=function(f,g,b,c,a,e){if("string"==typeof(f)&&"string"==typeof(g)){var d=f+"="+g;if(b){d+="; expires="+b.toGMTString();}if(c){d+="; path="+c;}if(a){d+="; domain="+a;}if(e){d+="; secure";}document.cookie=d;}};CookieUtil.getUnicodeCookie=function(b){var d=getCookie(b);if("string"==typeof(b)){var c=getCookie(b);if(null==c){return null;}else{return decodeURIComponent(c);}}else{var a=document.cookie;return a;}};CookieUtil.getASCIICookie=function(b){var d=getCookie(b);if("string"==typeof(b)){var c=getCookie(b);if(null==c){return null;}else{return unescape(c);}}else{var a=document.cookie;return a;}};CookieUtil.getCookie=function(d){var a=document.cookie;if("string"==typeof(d)){var c="(?:; )?"+d+"=([^;]*);?";var b=new RegExp(c);if(b.test(a)){return RegExp["$1"];}else{return null;}}else{return a;}};

   (function(a){a.extend(a.browser,{client:function(){return{width:document.documentElement.clientWidth,height:document.documentElement.clientHeight,bodyWidth:document.body.clientWidth,bodyHeight:document.body.clientHeight};},scroll:function(){return{width:document.documentElement.scrollWidth,height:document.documentElement.scrollHeight,bodyWidth:document.body.scrollWidth,bodyHeight:document.body.scrollHeight,left:document.documentElement.scrollLeft+document.body.scrollLeft,top:document.documentElement.scrollTop+document.body.scrollTop};},screen:function(){return{width:window.screen.width,height:window.screen.height};},isIE6:a.browser.msie&&a.browser.version==6,isMinW:function(b){return Math.min(a.browser.client().bodyWidth,a.browser.client().width)<=b;},isMinH:function(b){return a.browser.client().height<=b;}});})(jQuery);(function(a){a.fn.hoverForIE6=function(c){var b=a.extend({current:"hover",delay:10},c||{});a.each(this,function(){var f=null,e=null,d=false;a(this).bind("mouseover",function(){if(d){clearTimeout(e);}else{var g=a(this);f=setTimeout(function(){g.addClass(b.current);d=true;},b.delay);}}).bind("mouseout",function(){if(d){var g=a(this);e=setTimeout(function(){g.removeClass(b.current);d=false;},b.delay);}else{clearTimeout(f);}});});};})(jQuery);(function($){$.extend({_jsonp:{scripts:{},counter:1,charset:"gb2312",head:document.getElementsByTagName("head")[0],name:function(callback){var name="_jsonp_"+(new Date).getTime()+"_"+this.counter;this.counter++;var cb=function(json){eval("delete "+name);callback(json);$._jsonp.head.removeChild($._jsonp.scripts[name]);delete $._jsonp.scripts[name];};eval(name+" = cb");return name;},load:function(url,name){var script=document.createElement("script");script.type="text/javascript";script.charset=this.charset;script.src=url;this.head.appendChild(script);this.scripts[name]=script;}},getJSONP:function(url,callback){var name=$._jsonp.name(callback);var url=url.replace(/{callback};/,name);$._jsonp.load(url,name);return this;}});})(jQuery);(function(b){b.fn.jdTab=function(r,m){if(typeof r=="function"){m=r;r={};}var a=b.extend({type:"static",auto:false,source:"data",event:"mouseover",currClass:"curr",tab:".tab",content:".tabcon",itemTag:"li",stay:5000,delay:100,mainTimer:null,subTimer:null,index:0},r||{});var p=b(this).find(a.tab).eq(0).find(a.itemTag),t=b(this).find(a.content);if(p.length!=t.length){return false;}var s=a.source.toLowerCase().match(/http:\/\/|\d|\.aspx|\.ascx|\.asp|\.php|\.html\.htm|.shtml|.js|\W/g);var l=function(c,d){a.subTimer=setTimeout(function(){q();if(d){a.index++;if(a.index==p.length){a.index=0;}}else{a.index=c;}a.type=(p.eq(a.index).attr(a.source)!=null)?"dynamic":"static";n();},a.delay);};var o=function(){a.mainTimer=setInterval(function(){l(a.index,true);},a.stay);};var n=function(){p.eq(a.index).addClass(a.currClass);switch(a.type){default:case"static":var c="";break;case"dynamic":var c=(s==null)?p.eq(a.index).attr(a.source):a.source;p.eq(a.index).removeAttr(a.source);break;}if(m){m(c,t.eq(a.index),a.index);}t.eq(a.index).show();};var q=function(){p.eq(a.index).removeClass(a.currClass);t.eq(a.index).hide();};p.each(function(c){b(this).bind(a.event,function(){clearTimeout(a.subTimer);clearInterval(a.mainTimer);l(c,false);return true;}).bind("mouseleave",function(){if(a.auto){o();}else{return;}});});if(a.type=="dynamic"){l(a.index,false);}if(a.auto){o();}};})(jQuery);(function(b){b.fn.jdSlide=function(u){var a=b.extend({width:null,height:null,pics:[],index:0,type:"num",current:"curr",delay1:100,delay2:5000},u||{});var w=this;var y,z,B,x=0,A=true,D=true;var r=a.pics.length;var q=function(){var c="<ul style='position:absolute;top:0;left:0;'><li><a href='../"+a.pics[0].href+"' target='_blank'><img src='../"+a.pics[0].src+"' width='"+a.width+"' height='"+a.height+"' /></a></li></ul>";w.css({position:"relative"}).html(c);b(function(){C();});};q();var v=function(){var d=[];d.push("<div>");var e;var f;for(var c=0;c<r;c++){e=(c==a.index)?a.current:"";switch(a.type){case"num":f=c+1;break;case"string":f=a.pics[c].alt;break;case"image":f="<img src='../"+a.pics[c].breviary+"' />";default:break;}d.push("<span class='");d.push(e);d.push("'><a href='../");d.push(a.pics[c].href);d.push("' target='_blank'>");d.push(f);d.push("</a></span>");}d.push("</div>");w.append(d.join(""));w.find("span").bind("mouseover",function(){D=false;clearTimeout(y);clearTimeout(B);var g=w.find("span").index(this);if(a.index==g){return;}else{B=setInterval(function(){if(A){t(g);}},a.delay1);}}).bind("mouseleave",function(){D=true;clearTimeout(y);clearTimeout(B);y=setTimeout(function(){t(a.index+1,true);},a.delay2);});};var t=function(c,d){if(c==r){c=0;}z=setTimeout(function(){w.find("span").eq(a.index).removeClass(a.current);w.find("span").eq(c).addClass(a.current);s(c,d);},20);};var s=function(d,h){var f=parseInt(x);var c=Math.abs(f+a.index*a.height);var e=Math.abs(d-a.index)*a.height;var g=Math.ceil((e-c)/4);if(c==e){clearTimeout(z);if(h){a.index++;if(a.index==r){a.index=0;}}else{a.index=d;}A=true;if(A&&D){clearTimeout(y);y=setTimeout(function(){t(a.index+1,true);},a.delay2);}}else{if(a.index<d){x=f-g;w.find("ul").css({top:x+"px"});}else{x=f+g;w.find("ul").css({top:x+"px"});}A=false;z=setTimeout(function(){s(d,h);},20);}};var C=function(){var d=[];for(var c=1;c<r;c++){d.push("<li><a href='../");d.push(a.pics[c].href);d.push("' target='_blank'><img src='../");d.push(a.pics[c].src);d.push("' width='");d.push(a.width);d.push("' height='");d.push(a.height);d.push("' /></a></li>");}w.find("ul").append(d.join(""));y=setTimeout(function(){t(a.index+1,true);},a.delay2);if(a.type){v();}};};})(jQuery);

if($.browser.isIE6){try{document.execCommand("BackgroundImageCache",false,true);}catch(err){}
}

