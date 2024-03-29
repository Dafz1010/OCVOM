class DashboardController < ApplicationController
  include Authentication
  include ActionView::Helpers::UrlHelper
  def index
    all_logs = PaperTrail::Version.where.not(whodunnit: nil).order(created_at: :desc)
    @logs = sort_logs(all_logs)
  end

  private

  def sort_logs(unsorted_logs)
    unsorted_logs.map do |record|
      localtime = record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')
      who_did_it = record.whodunnit
      case record[:event]
        when 'Login User'
          {log_text: "#{localtime}: User #{who_did_it} Logged In"}
        when 'Logout User'
          {log_text: "#{localtime}: User #{who_did_it} Logged Out"}
        when 'Create User'
          {log_text: "#{localtime}: User #{who_did_it} created User \"#{get_data("User",record.item_id).username}\""}
        when 'User Restore'
          {log_text: "#{localtime}: User #{who_did_it} restored User \"#{get_data("User",record.item_id).username}\""}
        when 'Archive User'
          {log_text: "#{localtime}: User #{who_did_it} archived User \"#{get_data("User",record.item_id).username}\""}
        when 'Approve User'
          {log_text: "#{localtime}: User #{who_did_it} approve User \"#{get_data("User",record.item_id).username}\""}
        when -> (tmp) { tmp.starts_with?("Set User Role") }
          role = record[:event].split(",",2).last
          {log_text: "#{localtime}: User #{who_did_it} set User \"#{get_data("User",record.item_id).username}\" role to \"#{role}\""}
        when 'Create Dog'
          dog_data = get_data("Dog", record.item_id)
          log_string = ""
          if dog_data.archived?
            log_string = "<div class='d-inline-block'>#{dog_data.uuid}</div>"
          else
            log_string = "<div class='d-inline-block'>#{link_to dog_data.uuid, dog_path(dog_data.uuid)}</div>"
          end
          {log_text: "#{localtime}: User #{who_did_it} created Dog Profile ID: #{log_string}"}
        when 'Archive Dog'
          {log_text: "#{localtime}: User #{who_did_it} archived Dog Profile ID: <div class='d-inline-block'>#{get_data("Dog", record.item_id).uuid}</div>"}
        when 'Update Dog'
          dog_data = get_data("Dog", record.item_id)
          log_string = ""
          if dog_data.archived?
            log_string = "<div class='d-inline-block'>#{dog_data.uuid}</div>"
          else
            log_string = "<div class='d-inline-block'>#{link_to dog_data.uuid, dog_path(dog_data.uuid)}</div>"
          end
          {log_text: "#{localtime}: User #{who_did_it} updated Dog Profile ID: #{log_string}"}

        when 'Create Inventory'
          inventory_data = get_data("Inventory", record.item_id)
          {log_text: "#{localtime}: User #{who_did_it} created Inventory \"#{inventory_data.name}\""}
        when 'Archive Inventory'
          inventory_data = get_data("Inventory", record.item_id)
          {log_text: "#{localtime}: User #{who_did_it} archived Inventory \"#{inventory_data.name}\""}
        when 'Create Inventory Item'
          inventory_item_data = get_data("InventoryItem", record.item_id)
          {log_text: "#{localtime}: User #{who_did_it} created Item on \"#{inventory_item_data.inventory.name}\" Inventory"}
        else 
          {log_text: "Event: #{record[:event]}"}
      end
    end
  end

  def get_data(model, id)
    model.constantize.find(id)
  end

end
