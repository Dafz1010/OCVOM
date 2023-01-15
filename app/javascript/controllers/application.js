import { Application } from "@hotwired/stimulus"
import $ from 'jquery'
import 'select2';
window.$ = $;
window.jQuery = $;
const application = Application.start();

function matchStart(params, data) {
    if ($.trim(params.term) === '') {
        return data;
    }
    if (typeof data.children === 'undefined') {
        return null;
    }
    var filteredChildren = [];
    $.each(data.children, function (idx, child) {
        if (child.text.toUpperCase().indexOf(params.term.toUpperCase()) == 0) {
            filteredChildren.push(child);
        }
    });
    if (filteredChildren.length) {
        var modifiedData = $.extend({}, data, true);
        modifiedData.children = filteredChildren;
        return modifiedData;
    }
    return null;
    }
$(".select2").select2({
    matcher: matchStart
});
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

