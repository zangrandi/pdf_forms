require 'pdf_forms'

class Document
	include ActiveModel::Model

	attr_accessor :pdf_file, :pdf_fields_text

	def generate_filled_pdf
		begin
			pdftk = PdfForms.new('pdftk')

			if pdf_fields.is_a?(Hash)
				filled_pdf_path = self.pdf_file.path.gsub(".pdf","_filled.pdf")
				pdftk.fill_form self.pdf_file.path, filled_pdf_path, self.pdf_fields
				filled_pdf_path
			elsif pdf_fields.is_a?(Array)
				pdf_combiner = CombinePDF.new
				self.pdf_fields.each_with_index do |pdf_field, index|
					filled_pdf_path = self.pdf_file.path.gsub(".pdf","_filled_#{index}.pdf")
					pdftk.fill_form self.pdf_file.path, filled_pdf_path, pdf_field
					pdf_combiner << CombinePDF.load(filled_pdf_path)
				end
				pdf_combiner.save self.pdf_file.path.gsub(".pdf","_combined.pdf")
				self.pdf_file.path.gsub(".pdf","_combined.pdf")
			else
				false
			end
		rescue
			false
		end
	end

	def pdf_fields
		begin
			eval(self.pdf_fields_text) 
		rescue SyntaxError
			return
		end
	end
end
