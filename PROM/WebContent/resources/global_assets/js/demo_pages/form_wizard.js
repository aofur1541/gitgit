/* ------------------------------------------------------------------------------
 *
 *  # Steps wizard
 *
 *  Demo JS code for form_wizard.html page
 *
 * ---------------------------------------------------------------------------- */


// Setup module
// ------------------------------

var FormWizard = function() {


    //
    // Setup module components
    //

    // Wizard
    var _componentWizard = function() {
        if (!$().steps) {
            console.warn('Warning - steps.min.js is not loaded.');
            return;
        }

        // Basic wizard setup
        $('.steps-basic').steps({
            headerTag: 'h6',
            bodyTag: 'fieldset',
            transitionEffect: 'fade',
            titleTemplate: '<span class="number">#index#</span> #title#',
            labels: {
                previous: '<i class="icon-arrow-left13 mr-2" /> Previous',
                next: 'Next <i class="icon-arrow-right14 ml-2" />',
                finish: '가상 머신 변경 <i class="icon-arrow-right14 ml-2" />'
            },
            onFinished: function (event, currentIndex) {
                alert('Form submitted.');
            }
        });

        // Async content loading
        $('.steps-async').steps({
            headerTag: 'h6',
            bodyTag: 'fieldset',
            transitionEffect: 'fade',
            titleTemplate: '<span class="number">#index#</span> #title#',
            loadingTemplate: '<div class="card-body text-center"><i class="icon-spinner2 spinner mr-2"></i>  #text#</div>',
            labels: {
                previous: '<i class="icon-arrow-left13 mr-2" /> Previous',
                next: 'Next5 <i class="icon-arrow-right14 ml-2" />',
                finish: 'Submit form <i class="icon-arrow-right14 ml-2" />'
            },
            onContentLoaded: function (event, currentIndex) {
                $(this).find('.card-body').addClass('hide');

                // Re-initialize components
                _componentSelect2();
                _componentUniform();
            },
            onFinished: function (event, currentIndex) {
                alert('Form submitted.');
            }
        });

        // Saving wizard state
        $('.steps-state-saving').steps({
            headerTag: 'h6',
            bodyTag: 'fieldset',
            titleTemplate: '<span class="number">#index#</span> #title#',
            labels: {
                previous: '<i class="icon-arrow-left13 mr-2" /> Previous',
                next: 'Next4 <i class="icon-arrow-right14 ml-2" />',
                finish: 'Submit form <i class="icon-arrow-right14 ml-2" />'
            },
            transitionEffect: 'fade',
            saveState: true,
            autoFocus: true,
            onFinished: function (event, currentIndex) {
                alert('Form submitted.');
            }
        });

        // Specify custom starting step
        $('.steps-starting-step').steps({
            headerTag: 'h6',
            bodyTag: 'fieldset',
            titleTemplate: '<span class="number">#index#</span> #title#',
            labels: {
                previous: '<i class="icon-arrow-left13 mr-2" /> Previous',
                next: 'Next3 <i class="icon-arrow-right14 ml-2" />',
                finish: 'Submit form <i class="icon-arrow-right14 ml-2" />'
            },
            transitionEffect: 'fade',
            startIndex: 2,
            autoFocus: true,
            onFinished: function (event, currentIndex) {
                alert('Form submitted.');
            }
        });

        // Enable all steps and make them clickable
        $('.steps-enable-all').steps({
            headerTag: 'h6',
            bodyTag: 'fieldset',
            transitionEffect: 'fade',
            enableAllSteps: true,
            titleTemplate: '<span class="number">#index#</span> #title#',
            labels: {
                previous: '<i class="icon-arrow-left13 mr-2" /> Previous',
                next: 'Next2 <i class="icon-arrow-right14 ml-2" />',
                finish: 'Submit form <i class="icon-arrow-right14 ml-2" />'
            },
            onFinished: function (event, currentIndex) {
                alert('Form submitted.');
            }
        });


        //
        // Wizard with validation
        //

        // Stop function if validation is missing
        if (!$().validate) {
            console.warn('Warning - validate.min.js is not loaded.');
            return;
        }

        // Show form
        var form = $('.steps-validation').show();
        

        // Initialize wizard
        $('.steps-validation').steps({
            headerTag: 'h6',
            bodyTag: 'fieldset',
            titleTemplate: '<span class="number">#index#</span> #title#',
            labels: {
                previous: '<i class="icon-arrow-left13 mr-2" /> Previous',
                next: 'Next <i class="icon-arrow-right14 ml-2" />',
                finish: '가상머신 생성/변경&nbsp; <i class="icon-box-remove" />'
            },
            transitionEffect: 'fade',
            autoFocus: true,
            onStepChanging: function (event, currentIndex, newIndex) {
            	if(window.location.pathname == '/menu/create.do'){
            	if(currentIndex == 0 && !$('input[name="vm_service_ID"]:checked').val()){
                	alert("가상 머신을 넣을 단위서비스를 하나 선택하세요.");
                	return false;
                } else if(currentIndex == 0 && !$('input[name="cr_templet"]:checked').val()){
               	 alert("가상 머신에 넣을 Template을 하나 선택 해주세요.")
            	 $( 'radio#CR_template' ).focus();
              	return false;
                } 
            	
            	
            	/*else if(currentIndex == 0 && !$('input[name="se_storage_ck"]:checked').val()){
                	alert("스토리지를 하나 선택 해주세요.");
                	return false;
                } 
            	*/
            	} else if(window.location.pathname == '/menu/change.do'){
            		if(currentIndex == 0 && !$('input[name="vm_service_ID"]:checked').val()){
                    	alert("가상 머신을 넣을 단위서비스를 하나 선택하세요.");
                    	return false;
                    } else if(currentIndex == 0 && !$('input[name="cr_vm_name"]:checked').val()){
                    	alert("가상 머신을 하나 선택 해주세요.");
                    	return false;
                    }
            	}
            	
                if (currentIndex > newIndex) {
                    return true;
                }

                // Needed in some cases if the user went back (clean up)
                if (currentIndex < newIndex) {
                    
                	var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
                	var filter = /^([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\.([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3}$/;
                	
                	// To remove error styles
                    form.find('.body:eq(' + newIndex + ') label.error').remove();
                    form.find('.body:eq(' + newIndex + ') .error').removeClass('error');
                }
                
                if(window.location.pathname == '/menu/create.do'){
                
                if(currentIndex == 1 && $( 'input#CR_VM_name' ).val() ==  ''){
                	alert("가상 머신 이름을 지정 해주세요.");
                	setTimeout(function(){
                		$( 'input#CR_VM_name' ).focus();
                	}, 0);
                	return false;
                } else if(check.test($( 'input#CR_VM_name' ).val())){
                	alert("가상 머신의 이름으로 한글을 넣을 수 없습니다");
                	setTimeout(function(){
                		$( 'input#CR_VM_name' ).focus();
                	}, 0);
                	return false;
                }else if(currentIndex == 1 && $( 'input#CR_IP_address' ).val() ==  ''){
                	alert("가상 머신의 IP 주소를 넣어주세요.")
                	setTimeout(function(){
                		$( 'input#CR_IP_address' ).focus();
                	}, 0);
                	return false;
                } else if(currentIndex == 1 && !filter.test($( 'input#CR_IP_address' ).val())){
                	alert("IP 주소 형식이 올바르지 않습니다.");
                	setTimeout(function(){
                		$( 'input#CR_IP_address' ).focus();
                	}, 0);
                		return false;
                } else if(currentIndex == 1 && $( 'textarea#CR_VMcontext' ).val() ==  ''){
                	alert("가상 머신을 생성하려는 이유를 적어주세요.")
                	setTimeout(function(){
                		$( 'textarea#CR_VMcontext' ).focus();
                	}, 0);
                	return false;
                } 
                 else if(currentIndex == 1 && $( 'select#CR_CPU_SELECT' ).val() ==  ''){
                	alert("가상 머신의 CPU 값을 넣어주세요.")
                	setTimeout(function(){
                		$( 'select#CR_CPU_SELECT' ).focus();
                	}, 0);
                	return false;
                }
                 else if(currentIndex == 1 && $( 'select#CR_MEMORY_SELECT' ).val() ==  ''){
                 	alert("가상 머신의 MEMORY 값을 넣어주세요.")
                 	setTimeout(function(){
                		$( 'select#CR_MEMORY_SELECT' ).focus();
                	}, 0);
                 	return false;
                 }else if(currentIndex == 1 && $( 'select#CR_HostSelect' ).val() ==  ''){
                	alert("가상 머신의 호스트를 선택 해주세요."); 
                	return false;
                 }else if(currentIndex == 1 && $( 'select#CR_StorageSelect' ).val() ==  ''){
                	alert("가상 머신의 스토리지를 선택 해주세요.");
                	return false;
                 }else if(currentIndex == 1 && $( 'select#CR_netWorkSelect' ).val() ==  ''){
                	alert("가상 머신의 네트워크를 선택 해주세요.");
                	return false;
                 }  
                } else if(window.location.pathname == '/menu/change.do'){
                	if(currentIndex == 1 && $( 'select#CR_CPU_SELECT' ).val() ==  ''){
                       	alert("가상 머신의 변경 할 CPU 값을 넣어주세요.")
                       	$( 'select#CR_CPU_SELECT' ).focus();
                       	return false;
                       } else if(currentIndex == 1 && $( 'select#CR_MEMORY_SELECT' ).val() ==  ''){
                        	alert("가상 머신의 변경 할 MEMORY 값을 넣어주세요.")
                        	$( 'select#CR_MEMORY_SELECT' ).focus();
                        	return false;
                        }
                }
                
                
                
                /*else if(currentIndex == 1){
                     	$.ajax({
                     
                     	url : "createName.do",
                     	data : { vm_name : $( 'input#CR_VM_name' ).val()},
                     	async: false,
                     	success :function(data){
                     		if(data == false) {
                     			alert("이미 존재하는 가상 머신 이름입니다.");
                     			bo = data;
                     		} 
                     	}
                     })
                     return bo;
                 }*/
                
                form.validate().settings.ignore = ':disabled,:hidden';
            	if(currentIndex == 1) {
            		finish_table();
            	}
                return form.valid();
            },
            
            
            
            //onStepChanging 함수 
            onFinishing: function (event, currentIndex) {
            		form.validate().settings.ignore = ':disabled';
            		return form.valid();
            	
            },
            onFinished: function (event, currentIndex) {
            	cr_VM_finish();
            }
            
        });


        // Initialize validation
        $('.steps-validation').validate({
            ignore: 'input[type=hidden], .select2-search__field', // ignore hidden fields
            errorClass: 'validation-invalid-label',
            highlight: function(element, errorClass) {
                $(element).removeClass(errorClass);
            },
            unhighlight: function(element, errorClass) {
                $(element).removeClass(errorClass);
            },

            // Different components require proper error label placement
            errorPlacement: function(error, element) {

                // Unstyled checkboxes, radios
                if (element.parents().hasClass('form-check')) {
                    error.appendTo( element.parents('.form-check').parent().parent() );
                }

                // Input with icons and Select2
                else if (element.parents().hasClass('form-group-feedback') || element.hasClass('select2-hidden-accessible')) {
                    error.appendTo( element.parent() );
                }

                // Input group, styled file input
                else if (element.parent().is('.uniform-uploader, .uniform-select') || element.parents().hasClass('input-group')) {
                    error.appendTo( element.parent().parent() );
                }

                // Other elements
                else {
                    error.insertAfter(element);
                }
            },
            rules: {
                email: {
                    email: true
                }
            }
        });
    };

    // Uniform
    var _componentUniform = function() {
        if (!$().uniform) {
            console.warn('Warning - uniform.min.js is not loaded.');
            return;
        }

        // Initialize
        $('.form-input-styled').uniform({
            fileButtonClass: 'action btn bg-blue'
        });
    };

    // Select2 select
    var _componentSelect2 = function() {
        if (!$().select2) {
            console.warn('Warning - select2.min.js is not loaded.');
            return;
        }

        // Initialize
        var $select = $('.form-control-select2').select2({
            minimumResultsForSearch: Infinity,
            width: '100%'
        });

        // Trigger value change when selection is made
        $select.on('change', function() {
            $(this).trigger('blur');
        });
    };


    //
    // Return objects assigned to module
    //

    return {
        init: function() {
            _componentWizard();
            _componentUniform();
            _componentSelect2();
        }
    }
}();


// Initialize module
// ------------------------------

document.addEventListener('DOMContentLoaded', function() {
    FormWizard.init();
});
