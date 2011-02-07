jQuery.noConflict();

jQuery(document).ready(function(){
  jQuery("#show_filter").change(function(){
    window.location.href = "?show="+this.value;
  })
})