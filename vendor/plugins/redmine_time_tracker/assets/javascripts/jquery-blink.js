(function($) {
        $.fn.blink = function() {
          var that = this;
                function go() {
                  $(that).fadeOut().fadeIn();
                   setTimeout(go, 1e3); 
                };
                go();
        };

})(jQuery);