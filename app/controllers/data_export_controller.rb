class DataExportController < ApplicationController
  def index
    @exportable_list = ["Dogs","Users","Logs"]
    @date_range = ["Today", "Yesterday", "Last 3 days", "Last Week","Last Month"]
  end
  def show

  end
end
