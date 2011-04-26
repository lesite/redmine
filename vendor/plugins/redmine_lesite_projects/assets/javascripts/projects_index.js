jQuery.noConflict();

jQuery(document).ready(function(){
  
  // FLOATING TABLE HEADER
  jQuery("table#projects").each(function() {
      jQuery(this).wrap("<div class=\"divTableWithFloatingHeader\" style=\"position:relative\"></div>");

      var originalHeaderRow = jQuery("tr:first", this)
      originalHeaderRow.before(originalHeaderRow.clone());
      var clonedHeaderRow = jQuery("tr:first", this)

      clonedHeaderRow.addClass("tableFloatingHeader");
      clonedHeaderRow.css("position", "absolute");
      clonedHeaderRow.css("top", "0px");
      clonedHeaderRow.css("left", jQuery(this).css("margin-left"));
      clonedHeaderRow.css("visibility", "hidden");

      originalHeaderRow.addClass("tableFloatingHeaderOriginal");
  });
  UpdateTableHeaders();
  jQuery(window).scroll(UpdateTableHeaders);
  jQuery(window).resize(UpdateTableHeaders);
  
  jQuery("#show_filter").change(function(){
    window.location.href = "?show="+this.value;
  })

  // EDIT IN PLACE 
	jQuery('.edit').editable('/lesite_projects/in_place_edit');
				
	jQuery('.budget').editable('/lesite_projects/in_place_edit',{
	  callback : function(value, settings) {
	    var tr = jQuery(this).closest("tr");
	    budgets = tr.find(".budget");
	    var total = 0;
      jQuery.each(budgets,function() { total += parseInt(jQuery(this).text()); });
      var total_col = tr.find(".total");
      total_col.html(total)
      total_col.parent().effect("highlight");
    }
	});
				
		
				
	// DEADLINE		
	jQuery("a.edit_deadline").click(function(){
		jQuery(this).next(".deadline_editor").show();
		jQuery(this).hide();
		jQuery(this).next(".deadline_editor").find('input').focus();
		return false;
	}) 
	
	jQuery(".close_deadline_editor").click(function(){
		jQuery(this).closest(".deadline_editor").hide();
		jQuery(this).closest(".deadline").find("a.edit_deadline").show();
		if( jQuery(this).hasClass("submit_new_deadline") ) {
			var val = jQuery(this).parent(".deadline_editor").find("input.deadline").val();
			var the_data = "id="+jQuery(this).attr('id')+"&value="+val;
			el = jQuery(this);
			jQuery.ajax({ 
				url: "/lesite_projects/in_place_edit", 
				type: "POST", 
				dataType: "json",
				data: the_data, 
				success: function(val) {
					el.closest(".deadline").find(".edit_deadline").html(val.deadline);
					el.closest(".project").find(".due_date").html(val.due_date)
				}
				
			})
	  }
		
	})
				
})


// FLOATING THEAD
function UpdateTableHeaders() {
    jQuery("table#projects").each(function() {
        var originalHeaderRow = jQuery(".tableFloatingHeaderOriginal", this);
        var floatingHeaderRow = jQuery(".tableFloatingHeader", this);
        var offset = jQuery(this).offset();
        var scrollTop = jQuery(window).scrollTop();
        if ((scrollTop > offset.top) && (scrollTop < offset.top + jQuery(this).height())) {
            floatingHeaderRow.css("visibility", "visible");
            floatingHeaderRow.css("top", Math.min(scrollTop - offset.top, jQuery(this).height() - floatingHeaderRow.height()) + "px");

            // Copy cell widths from original header
            jQuery("th", floatingHeaderRow).each(function(index) {
                var cellWidth = jQuery("th", originalHeaderRow).eq(index).css('width');
                jQuery(this).css('width', cellWidth);
            });

            // Copy row width from whole table
            floatingHeaderRow.css("width", jQuery(this).css("width"));
        }
        else {
            floatingHeaderRow.css("visibility", "hidden");
            floatingHeaderRow.css("top", "0px");
        }
    });
}
