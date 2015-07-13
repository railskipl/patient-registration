// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .



jQuery(function (){
    jQuery.noConflict();
    jQuery('#customer_dob').datepicker({
	    changeMonth: true,
	    changeYear: true,
	    selectOtherMonths: true,
	    dateFormat: "mm/dd/yy" ,
	    yearRange: "1900:2050",
	     maxDate: '+0d',
		onSelect: function (date) {
			var dob = new Date(date);
			var today = new Date();
			var age = today.getFullYear()-dob.getFullYear() ;
			var a = age;
			document.getElementById("customer_age").value = a;
		}

	});


});

	function add_fields(link, association, content) {
	  var new_id = new Date().getTime();
	  var regexp = new RegExp("new_" + association, "g")
	  $(link).parent().before(content.replace(regexp, new_id));
	}
     
    //  function remove_fields(link) { 
    //      // alert("ho"); 
    //     $(link).previous("input[type=hidden]").value = "1";  
    //     $(link).up(".fields").hide();  
    // }  

	function remove_fields(link) {
		 // alert(link);
	 var nested_container = $(this).closest('.fields');
	   if (!nested_container.prev().is('.fields')) {
        $(this).remove();
    }
	}

// $(function() {
// 	// alert("hi");
//   $('a[data-nested-form-disable-first]').each(function() {
//     var nested_container = $(this).closest('.fields');

//     // check if is first
//     if (!nested_container.prev().is('.fields')) {
//         $(this).remove();
//     }
//   });
// });
