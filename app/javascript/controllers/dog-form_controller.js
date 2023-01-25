import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dog-form"
export default class extends Controller {
  connect() {
    if ($("#dog_gender").parent('.bootstrap-switch-container').length == 0) {
      $("#dog_gender").bootstrapSwitch();
    }
  }
}
