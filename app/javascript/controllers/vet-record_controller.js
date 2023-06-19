import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vet-record"
export default class extends Controller {
  connect() {
    $('select').each(function() {
      $(this).select2({
        placeholder: function(){
          $(this).data('placeholder');
        }
      });
    });
  }
}
