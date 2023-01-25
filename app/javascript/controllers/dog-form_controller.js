import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dog-form"
export default class extends Controller {
  connect() {
    if ($("#dog_gender").parent('.bootstrap-switch-container').length == 0) {
      $("#dog_gender").bootstrapSwitch();
    }
    if ($("#dog_neutered").parent('.bootstrap-switch-container').length == 0) {
      $("#dog_neutered").bootstrapSwitch();
    }
    function getAllSiblings(elem, filter) {
      var sibs = [];
      elem = elem.parentNode.firstChild;
      do {
        if (elem.nodeType === 3) continue;
        if (!filter || filter(elem)) sibs.push(elem);
      } while (elem = elem.nextSibling)
      return sibs;
    }
    document.getElementById("images").addEventListener("change", function(event) {
      var imageList = document.getElementById("image-list");
      if (imageList.hasChildNodes()) {
        imageList.innerHTML = "";
      }
      var files = event.target.files;
      for (var i = 0; i < files.length; i++) {
        var file = files[i];
        var reader = new FileReader();
        reader.addEventListener("load", function(event) {
          var div = document.createElement("div");
          div.classList.add("col-4", "mx-2","d-flex","justify-content-center",);
          div.style.height = "30vh";
          var img = document.createElement("img");
          img.src = event.target.result;
          img.classList.add("my-auto");
          img.style.objectFit = "cover";
          div.appendChild(img);
          document.getElementById("image-list").appendChild(div);
        });
        reader.readAsDataURL(file);
      }
      var parent = document.getElementById("image-list");
      parent.parentNode.style.border = "solid";
      var siblings = getAllSiblings(parent);
      for (var j = 0; j < siblings.length; j++) {
        if(siblings[j]!==imageList)
          siblings[j].classList.add("d-none");
      }
    });
  }
}
