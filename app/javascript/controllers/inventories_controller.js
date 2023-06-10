import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="inventories"
export default class extends Controller {
  connect() {
    var $inventoryName = $('#inventory-name');
    var $inventoryOptions = $('#inventory-options');
    setupDropdown($inventoryName, $inventoryOptions);

    var $categoryName = $('#category-name');
    var $categoryOptions = $('#category-options');
    setupDropdown($categoryName, $categoryOptions);

    var $inventorytypeName = $('#inventory-type-name');
    var $inventorytypeOptions = $('#inventory-type-options');
    setupDropdown($inventorytypeName, $inventorytypeOptions);
  }
  
}
function setupDropdown($inputField, $optionsContainer) {
  var $optionItems = $optionsContainer.find('.option');

  $inputField.on('focus', function() {
    $optionsContainer.show();
  });

  $inputField.on('blur', function() {
    setTimeout(function() {
      $optionsContainer.hide();
    }, 200);
  });

  $inputField.on('input', function() {
    let userInput = $inputField.val().toLowerCase();
    $optionItems.each(function() {
      let optionText = $(this).text().toLowerCase();
      if (optionText.startsWith(userInput)) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });
  });

  $optionsContainer.on('mousedown', '.option', function() {
    $inputField.val($(this).text()).focus();
  });
}
