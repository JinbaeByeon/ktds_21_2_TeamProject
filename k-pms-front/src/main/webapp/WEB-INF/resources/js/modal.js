/**
 * 
 */
function Modal(jquery) {
    this._$ = jquery;
}

Modal.prototype.show = function(title, message) {
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
    });
}