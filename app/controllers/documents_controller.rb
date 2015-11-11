class DocumentsController < ApplicationController
  def create
  	document = Document.new(params[:document])
  	pdf_filepath = document.generate_filled_pdf
  	if pdf_filepath
  		send_file(pdf_filepath, :filename => "document.pdf", :disposition => 'inline', :type => "application/pdf")
  	else
  		redirect_to root_path, alert: "There was an error generating the PDF"
  	end
  end
end