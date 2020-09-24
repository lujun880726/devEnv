document.oncontextmenu =function(){
	console.log("1111");
	return false;
};

document.onmouseup =function(e){
	if(e.button===2){
		console.log("右键");	    
	}else if(e.button===1) {
		console.log("中间键")
	}else {
		console.log("左键")
	}
}



解除或键
(function() { 
	function R(a){
		ona = "on"+a; if(window.addEventListener) 
		window.addEventListener(a, function (e) { 
			for(var n=e.originalTarget; n; n=n.parentNode) 
			n[ona]=null; 
			}, true); 
			window[ona]=null; document[ona]=null; 
			if(document.body) document.body[ona]=null; 
	} 
			
			R("contextmenu");
			 R("click"); 
			 R("mousedown");
			  R("mouseup"); 
			  R("selectstart");
})()
