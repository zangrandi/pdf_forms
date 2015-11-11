# encoding: utf-8

require 'rails_helper'

describe DocumentsController do
  describe "POST created" do
    describe "Success" do
      it "should send file if pdf filepath exists" do
        allow_any_instance_of(Document).to receive(:generate_filled_pdf) {"#{Rails.root}/spec/support/example.pdf"}
        expect(controller).to receive(:send_file).with(
          "#{Rails.root}/spec/support/example.pdf",
          :filename => "document.pdf", :disposition => 'inline', :type => "application/pdf"
        ) { controller.render :nothing => true } 
        post :create
      end
    end

    describe "If pdf filepath doesn't exist" do
      it "should redirect to root with message" do
        allow_any_instance_of(Document).to receive(:generate_filled_pdf) { false }
        post :create
        expect(response).to redirect_to root_path
      end

      it "should set flash alert" do
        allow_any_instance_of(Document).to receive(:generate_filled_pdf) { false }
        post :create
        expect(flash[:alert]).to eql("There was an error generating the PDF")
      end
    end
  end
end

