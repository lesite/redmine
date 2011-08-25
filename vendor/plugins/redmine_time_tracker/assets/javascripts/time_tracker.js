/*
 * This script updates the element 'id' with 'newContent' if the two contents differ
 */

var paused_value;

function updateElementIfChanged(id, newContent) {
    el = $(id);
    if (el.innerHTML != newContent) { el.update(newContent); }
}

function start_timer() {
	seconds = 0; timer();
};

function timer() {
	  seconds = seconds + 1;
	  string = seconds.toString();
	  if(string.length == 1) { string = "0" + string };
	  $("seconds").update(":" + string); 
	  if(seconds < 59 && pause != true) { setTimeout("timer()", 1000); } 
};

jQuery(".icon-pause-action, .icon-stop-action").live("click",function(){
  pause = true;
})
