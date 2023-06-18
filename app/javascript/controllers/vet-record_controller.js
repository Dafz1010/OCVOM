import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vet-record"
export default class extends Controller {
  connect() {
    $('select:not(#vet_record_status):not(#vet_record_condition)').each(function() {
      $(this).select2({
        placeholder: function(){
          $(this).data('placeholder');
        }
      });
    });

    $('#vet_record_status').select2({
      templateResult: formatStatus
    });

    function formatStatus (status) {
      if (!status.id) { return status.text; }
      var $status = $(
        '<span><i class="fas fa-circle" style="color: ' + status.element.dataset.color + '"></i> ' + status.text + '</span>'
      );
      return $status;
    }
  }
}
