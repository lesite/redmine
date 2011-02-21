document.observe("dom:loaded", function() {
  $('burndown_range').observe('change', function(event) {
    element = event.element();
    val = element.getValue();
    window.location.href = '?days=' + val;
  });
    
});

