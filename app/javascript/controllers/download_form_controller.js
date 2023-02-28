import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="download-form"
export default class extends Controller {
  static targets = ["form"]
  connect() {
    $(function() {
      $("#dform").on("submit", function(event) {
        event.preventDefault();
        var export_type = $("#export_type").val();
        var range_type =  $("#range_type").val();
        var url = $(this).attr("action");
        url += "?export_type=" + export_type + "&range_type=" + range_type ;
        window.open(url);
      });
    });
  }
}
