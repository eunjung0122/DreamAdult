(function(){
	const MARGIN = 36;
	const SIZE_S = 197;
	const SIZE_M = 420;
	const WIDTH = 297;
	
	const box_wrap = document.querySelector(".table-row:last-of-type");
	const box = document.querySelectorAll(".table-row:last-of-type .box");
	const half = document.querySelectorAll(".table-row:last-of-type .box-s");
	
	let set = function(count, s, m){
		this.count = count;
		this.s = s;
		this.m = m;
		return this;
	}
	
	function setHeight(column){
		box_wrap.style.height = ((box.length-column)*MARGIN)/column + (height)/column + "px";
	}
	function setLeft(reset, column){
		for(i=reset; i<box.length;){
			reset == 0 ? box[i].style.left = 0 : box[i].style.left = WIDTH + MARGIN + "px";
			i += column;
		}
	}
	function setTop(count, s, m){
		for(i=0; i<box.length; i++){
			box[i].style.top = s*SIZE_S + m*SIZE_M + i*MARGIN + "px";
			box[i].classList.contains("box-s") ? s++ : m++;
		}
	}
	function setTop2(reset, count, s, m){
		for(i=reset; i<box.length; i+=2){
			if(i == 8) return;
			box[i].style.top = s*SIZE_S + m*SIZE_M + count*MARGIN + "px";
			count++;
			box[i].classList.contains("box-s") ? s++ : m++;
			if(i == 7) box[8].style.top = s*SIZE_S + m*SIZE_M + count*MARGIN + "px";
		}
	}
	function line1(height){
		let one = new set(0, 0, 0);
		
		setHeight(1);
		setLeft(0, 1);
		setTop(one.count, one.s, one.m);
	}
	
	function line2(height){
		let left = new set(0, 0, 0);
		let right = new set(0, 0, 0);
		
		setHeight(2);
		setLeft(1, 2);
		setLeft(0, 2);
		setTop2(0, left.count, left.s, left.m);
		setTop2(1, right.count, right.s, right.m);
		
		for(i=1; i<box.length; i+=2){
			if(i == 7) box[8].style.left = WIDTH + MARGIN + "px";
		}
	}
	function eventTop(num, e){
		let current = e.currentTarget.style.top;
		let currents = current.replace("px","");
		num == 1 ? e.currentTarget.style.top = parseInt(currents) - 10 + "px"
				 : e.currentTarget.style.top = parseInt(currents) + 10 + "px";
	}
	
	function init(){
		let height = 0;
		for(i=0; i<box.length; i++){ height += box[i].clientHeight; }
		
		window.outerWidth <= 767 ? line1(height) :
		window.outerWidth <= 1023 ? line2(height) :
		window.outerWidth <= 1439 ? line1(height) : line2(height);
	}
	
	for(i=0; i<box.length; i++){
		box[i].addEventListener('mouseenter', event => eventTop(1, event), false);
		box[i].addEventListener('mouseleave', event => eventTop(2, event), false);
	}
	window.addEventListener('load', init, true);
	window.addEventListener('resize', init, true);
	
})();