require 'rails_helper'

RSpec.describe Document, type: :model do
  
	describe "#generate_filled_pdf" do
		before(:each) do
			# allow_any_instance_of(PdfForms).to receive(:fill_form)
		end
		
		context "if field is a hash" do
			before(:each) do
				@pdf_document = Document.new(
					pdf_file: File.new("#{Rails.root}/spec/support/example.pdf"),
					pdf_fields_text: "{ 
			      'Name' => 'John Doe',
			      'Address' => '12 High Street',
			      'Phone Number' => '020 8777 8888',
			      'Email' => 'john.doe@gmail.com',
			      'Mothers Name' => 'Mary Doe',
			      'Fathers Name' => 'Bill Doe',
			      'Occupation' => 'Developer',
			      'Annual Income' => '$30,000 USD'
			    }"
				)
			end

			it "should return the filled pdf path" do
				expect(@pdf_document.generate_filled_pdf).to eql(
					"#{Rails.root}/spec/support/example_filled.pdf"
				)
			end
		end

		context "if field is a array" do
			before(:each) do
				@pdf_document = Document.new(
					pdf_file: File.new("#{Rails.root}/spec/support/example.pdf"),
					pdf_fields_text: "[{ 
			      'Name' => 'John Doe',
			      'Address' => '12 High Street',
			      'Phone Number' => '020 8777 8888',
			      'Email' => 'john.doe@gmail.com',
			      'Mothers Name' => 'Mary Doe',
			      'Fathers Name' => 'Bill Doe',
			      'Occupation' => 'Developer',
			      'Annual Income' => '$30,000 USD'
			    },{ 
			      'Name' => 'John Doe',
			      'Address' => '12 High Street',
			      'Phone Number' => '020 8777 8888',
			      'Email' => 'john.doe@gmail.com',
			      'Mothers Name' => 'Mary Doe',
			      'Fathers Name' => 'Bill Doe',
			      'Occupation' => 'Developer',
			      'Annual Income' => '$30,000 USD'
			    }]"
				)
			end

			it "should return the combined pdf path" do
				expect(@pdf_document.generate_filled_pdf).to eql(
					"#{Rails.root}/spec/support/example_combined.pdf"
				)
			end
		end

		context "if field is misformatted" do
			before(:each) do
				@pdf_document = Document.new(
					pdf_file: File.new("#{Rails.root}/spec/support/example.pdf"),
					pdf_fields_text: "[{ 
			      'Name' => 'John Doe',
			      'Address' => '12 High Street',
			      'Phone Number' => '020 8777 8888',
			      'Email' => 'john.doe@gmail.com',
			      'Mothers Name' => 'Mary Doe',
			      'Fathers Name' => 'Bill Doe'
			      'Occupation' => 'Developer',
			      'Annual Income' => '$30,000 USD'
			    },{ 
			      'Name' => 'John Doe',
			      'Address' => '12 High Street',
			      'Phone Number' => '020 8777 8888',
			      'Email' => 'john.doe@gmail.com',
			      'Mothers Name' => 'Mary Doe',
			      'Fathers Name' => 'Bill Doe',
			      'Occupation' => 'Developer',
			      'Annual Income' => '$30,000 USD'
			    }]"
				)
			end

			it "should return false" do
				expect(@pdf_document.generate_filled_pdf).to eql(false)
			end
		end
	end

end
