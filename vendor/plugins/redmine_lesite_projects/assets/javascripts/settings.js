jQuery.noConflict();

jQuery(document).ready(function(){
  jQuery("#estimated_activity_hours input.activity_hours").bind("change",function(){
    RedmineLeSiteProjects.CalculateTotal();
  })
})

RedmineLeSiteProjects = new Object();

RedmineLeSiteProjects.CalculateTotal = function() {
  var total = 0;
  jQuery("#estimated_activity_hours input.activity_hours").each(function() {
    total += parseInt(jQuery(this).val());
  });
 jQuery("#estimated_activity_hours_total").html(total);

}