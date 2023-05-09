/**
 * 
 */
function Modal(jquery) {
    this._$ = jquery;
}

Modal.prototype.show = function(title, focusId) {
    var modal = this._$("<div class='modal'></div>");
    var window = this._$("<div class='window'></div>");
    var _title = this._$("<div class='title'></div>");
    _title.text(title);

    modal.append(window);
	window.append(_title);
	
    this._$("body").append(modal);
    var jquery = this._$;
    modal.click(function(){
    	jquery(this).remove();
    	if(focusId){
    		jquery(focusId).focus();
    		//jquery(focusId)[0].scrollIntoView();
    		var nowScrollTop = jquery(focusId).offset().top;
    		jquery(document).scrollTop(nowScrollTop - 150);
    	}
    });
}