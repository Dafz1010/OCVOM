class DataExportController < ApplicationController
  include Authentication
  def index
    @exportable_list = [
      [
        'Dogs',
          [
            ["All","d1"],
            ["Healty","d2"],
            # ["Vaccinated","d3"],
            ["Operation","d4"],
            ["Disposed","d5"]
          ]
      ], 
      [
        'User Logs', 
          [
            ["All","u1"],
            ["Admin","u2"],
            ["Frontliner","u3"],
            ["Encoder","u4"]
          ]
      ]
    ]
    @date_range = ["Today", "Yesterday", "Last 3 days", "Last Week","Last Month"]
  end
  def download_report
    pdf = nil
    dr = params[:range_type]
    binding.remote_pry
    case params[:export_type]
    when "d1"
      pdf = Dog.export(date_range: dr)
    when "d2"
      pdf = Dog.export(date_range: dr, type: "Healty")
    # when "d3"
    #   pdf = Dog.export(date_range: dr, type: "Vaccinated")
    when "d4"
      pdf = Dog.export(date_range: dr, type: "Operation")
    when "d5"
      pdf = Dog.export(date_range: dr, type: "Disposed")
    else
      fail
    end
    send_data pdf.render, filename: "DogReport.pdf", type: "application/pdf", disposition: "inline"
  end
end