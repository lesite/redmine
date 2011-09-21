/*
 * This script updates the element 'id' with 'newContent' if the two contents differ
 */
function updateElementIfChanged(id, newContent) {
    el = $(id);
    if (el.innerHTML != newContent) { el.update(newContent);  Effect.Pulsate('blinker', { duration: '120.0', pulses: 120}); }
}
