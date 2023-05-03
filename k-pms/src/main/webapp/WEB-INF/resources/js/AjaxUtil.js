function AjaxUtil() {
	this.sendTarget = [
		"input[type=checkbox]:checked",
		"input[type=color]",
		"input[type=date]",
		"input[type=email]",
		"input[type=hidden]",
		"input[type=image]",
		"input[type=month]",
		"input[type=number]",
		"input[type=password]",
		"input[type=radio]:checked",
		"input[type=range]",
		"input[type=tel]",
		"input[type=text]",
		"input[type=url]",
		"input[type=time]",
		"input[type=week]",
		"textarea",
		"select"
	];

}

AjaxUtil.hideSpinner = function () {
	$('#spinner_panel').hide();
}

AjaxUtil.disableSpinner = function () {
	$('#spinner_panel').hide();
	
	$(document).off("ajaxStart");
	$(document).off("ajaxStop");
}

AjaxUtil.enableSpinner = function () {
	$(document).on("ajaxStart", function () {
		var oWidth = 540 / 2;
		var oHeight = 360 / 2;
		var wWidth = $(window).width() / 2;
		var wHeight = $(window).height() / 2;
		
		$('#spinner').css({
			"top": wHeight -  oHeight,
			"left": wWidth - oWidth
		});
		
		$('#spinner_panel').show();
	}) 
	$(document).on("ajaxStop", function () {
		$('#spinner_panel').hide();
	});
}


AjaxUtil.prototype.deleteFile = function(fileNames, url, fnCallback) {
	function makeFormData(){
		var formData = new FormData();
	    if (fileNames.length > 0) {
	        for(var i = 0; i < fileNames.length; i++) {
	    		formData.append("fileNames", fileNames[i]);
	    	}
	    }
	    return formData;
    }
    
    $.ajax({
        type: "POST",
        url: url,
        processData: false,
        contentType: false,
        data: makeFormData(),
        success: function(response) {
            fnCallback(response);
        }
    });
}


AjaxUtil.prototype.uploadImmediatly = function(files, url, fnCallback) {

	function makeFormData(){
		var formData = new FormData();
	    if (files.length > 0) {
	        for(var i = 0; i < files.length; i++) {
	    		formData.append("uploadFile", files[i]);
	    	}
	    }
	    return formData;
    }
    
    $.ajax({
        type: "POST",
        url: url,
        processData: false,
        contentType: false,
        data: makeFormData(),
        success: function(response) {
            fnCallback(response);
        }
    });
}

/**
 * 파일 업로드
 * 
 */
AjaxUtil.prototype.upload = function(formSelector, url, fnCallback, replaceRule) {
	
	if (!replaceRule) {
		replaceRule = {}
	}
	
	var that = this;
	
    function makeFormData() {
        var formData = new FormData();
		
        var form = $(formSelector);
        form.find(that.sendTarget.join(", ")).each(function() {
            inputNm = $(this).attr("name") || $(this).attr("id")
            
            if (inputNm) {
	            if (replaceRule[inputNm]) {
	            	inputNm = replaceRule[inputNm];
	            }
	            formData.append(inputNm, $(this).val())
            }
        });

        form.find("input[type=file]").each(function() {
            inputNm = $(this).attr("name") || $(this).attr("id")
            
            if ($(this)[0].files.length > 0) {
	            if (replaceRule[inputNm]) {
	            	inputNm = replaceRule[inputNm];
	            }
	            for (var i = 0; i < $(this)[0].files.length; i++) {
	            	formData.append(inputNm, $(this)[0].files[i]);
	            }
            }
        });
        return formData;
    }

    function send() {
        $.ajax({
            type: "POST",
            url: url,
            processData: false,
            contentType: false,
            data: makeFormData(),
            success: function(response) {
                fnCallback(response);
            }
        });
    }

    send();

};