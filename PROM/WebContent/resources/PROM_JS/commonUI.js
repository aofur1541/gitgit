function commonModalOpen(modalId, focusId) {
	$(".addModal>button").click(function(){
		$("#required-input.collapse").addClass("show");
		$("#select-input.collapse").addClass("show");
	})
	$("#" + modalId).on("shown.bs.modal", function() {
		$("#" + focusId).focus();
	})
}
