import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dog-form"
export default class extends Controller {
  connect() {
    $('select').each(function() {
      $(this).select2({
        placeholder: function(){
          $(this).data('placeholder');
        }
      });
    });
    if ($("#dog_gender").parent('.bootstrap-switch-container').length == 0) {
      $("#dog_gender").bootstrapSwitch();
    }
    if ($("#dog_size").parent('.bootstrap-switch-container').length == 0) {
      $("#dog_size").bootstrapSwitch();
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
    
    
    document.getElementById("drop-area").addEventListener("drop", function(event) {
      event.preventDefault();
      var imageList = document.getElementById("image-list");
      var files = event.dataTransfer.files;
      var parent = document.getElementById("image-list");
      var siblings = getAllSiblings(parent);
      for (var i = 0; i < files.length; i++) {
        var file = files[i];
        if (file.type === "image/jpeg" || file.type === "image/png") {
          var reader = new FileReader();
          reader.addEventListener("load", function(event) {
            var div = document.createElement("div");
            div.className = "col-3 position-relative d-flex justify-content-center py-3";
            div.style.height = "25vh";
            var img = document.createElement("img");
            img.src = event.target.result;
            img.className = "my-auto";
            img.style.objectFit = "contain";
            div.appendChild(img);
  
            var btn = document.createElement("button");
            btn.innerHTML = "X";
            btn.className = "position-absolute top-0 end-0 btn btn-danger"
            btn.addEventListener("click", function(){
              div.remove();
              var lc = imageList.lastElementChild;
              if(imageList.children.length === 1){
                lc.classList.add("d-none")
                parent.parentNode.style.border = "dashed";
                for (var j = 0; j < siblings.length; j++) {
                    if(siblings[j]!==imageList)
                        siblings[j].classList.remove("d-none");
                }
              }
            });
            div.appendChild(btn);
            
            
            document.getElementById("image-list").appendChild(div);
            
            var lastChild = imageList.lastElementChild;
            var secondLastChild = lastChild.previousElementSibling;
            imageList.insertBefore(div, secondLastChild);
            parent.parentNode.style.border = "solid";
            for (var j = 0; j < siblings.length; j++) {
              if(siblings[j]!==imageList)
              siblings[j].classList.add("d-none");
            }
            if(imageList.lastElementChild!==null){
              imageList.lastElementChild.classList.remove("d-none");
            }
          });
          reader.readAsDataURL(file);
        }
      }
    });

    document.getElementById("drop-area").addEventListener("dragover", function(event) {
      event.preventDefault();
    });


    function getImageType(base64String) {
      var type = base64String.split(";")[0].split(":")[1];
      return type;
    }
    function fixBinary(bin) {
      var length = bin.length;
      var buf = new ArrayBuffer(length);
      var arr = new Uint8Array(buf);
      for (var i = 0; i < length; i++) {
        arr[i] = bin.charCodeAt(i);
      }
      return buf;
    }
    function getBase64Images() {
      var input = document.getElementById("images");
      var parent = document.getElementById("image-list");
      var imgElements = parent.querySelectorAll("img");
      var files = [];
      if (imgElements.length) {
        for (var i = 0; i < imgElements.length; i++) {
          var base64String = imgElements[i].src;
          var imageType = getImageType(base64String);
          base64String = base64String.split(",")[1];
          var binaryString = fixBinary(atob(base64String));
          var extension = "";
          if(imageType == "image/png"){
              extension = "png";
          }else if(imageType == "image/jpeg"){
              extension = "jpeg";
          }
          var file = new Blob([binaryString], { type: imageType });
          var fileWithName = new File([file], "file"+i+"."+extension, {type: imageType});
          files.push(fileWithName);
        }
        const dT = new DataTransfer();
        files.forEach(file => {
          dT.items.add(file)
        });
        input.files = dT.files;
      }
    }
    document.getElementById("dog-form-presubmit").addEventListener("mousedown", function(event) {
      getBase64Images();
    });
    document.getElementById("dog-form-presubmit").addEventListener("mouseup", function(event) {
      setTimeout(function(){}, 1500);
      document.getElementById("dog-form-submit").click();
    });
  }
}
