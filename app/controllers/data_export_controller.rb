class DataExportController < ApplicationController
  include Authentication
  def index
    @exportable_list = [
      [
        'Dog Records',
          [
            ["All","dr_all"],
            ["Healthy","dr_healty"],
            # ["Vaccinated","dr_vaccinated"],
            ["Operation","dr_operation"],
            ["Disposed","dr_disposed"]
          ]
      ], 
      [
        'User Logs', 
          [
            ["All","ul_all"],
            ["Admin","ul_admin"],
            ["Frontliner","ul_frontliner"],
            ["Encoder","ul_encoder"],
            ["Doctor","ul_doctor"]
          ]
      ]
    ]
      
  end

  def download_report
    range = parse_range(params[:range])
    data = get_data(params[:export_type], range, params[:file_type])
    case params[:file_type]
    when "PDF"
      export_pdf(data)
    when "CSV"
      export_csv(data)
    when "Excel"
      export_xls(data)
    else
      redirect_to data_export_path, alert: "Invalid export request."
    end
  end
end

private

def export_pdf(data)
  pdf = Prawn::Document.new(page_layout: :landscape, page_size: "LEGAL")
  pdf.table data, :position => :center, :header => true
  send_data pdf.render, filename: "Exported_Data_#{Time.zone.now.to_s}.pdf", type: "application/pdf", disposition: "inline"
end

def export_csv(data)
  csv = CSV.generate do |csv|
    data.each do |row|
      csv << row
    end
  end
  send_data csv, filename: "Exported_Data_#{Time.zone.now.to_s}.csv", type: "text/csv", disposition: "attachment"
end

def export_xls(data)
  xls = Axlsx::Package.new
  wb = xls.workbook
  wb.add_worksheet(name: "Exported Data") do |sheet|
    data.each do |row|
      sheet.add_row row
    end
  end
  send_data xls.to_stream.read, filename: "Exported_Data_#{Time.zone.now.to_s}.xlsx", type: "application/xlsx", disposition: "attachment"
end

def parse_range(range)
  start_date = Date.parse(range.split(" - ")[0])
  end_date = Date.parse(range.split(" - ")[1])
  start_date..end_date
end

def get_data(type,range,file_type)
  data = []
  group = type.split("_")[1]
  case type.split("_")[0]
  when "dr"
    data = Dog.export(range, group, file_type)
  when "ul"
    data = User.export(range, group, file_type)
  else
    redirect_to data_export_path, alert: "Invalid export request."
  end
  data  
end

