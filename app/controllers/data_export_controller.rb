class DataExportController < ApplicationController
  def index
    @exportable_list = ["Dogs","Users","Logs"]
    @date_range = ["Today", "Yesterday", "Last 3 days", "Last Week","Last Month"]
  end
  def download_report
    pdf = Dog.export
    send_data pdf.render, filename: "Dog_report.pdf", type: "application/pdf", disposition: "attachment"
  end
end
