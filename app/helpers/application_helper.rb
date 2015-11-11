module ApplicationHelper
	def hash_placeholder
		str = "{\n" 
		str << "\t'Name' => 'John Doe',\n"
		str << "\t'Address' => '12 High Street',\n"
		str << "\t'Phone Number' => '020 8777 8888',\n"
		str << "\t'Email' => 'john.doe@gmail.com',\n"
		str << "\t'Mothers Name' => 'Mary Doe',\n"
		str << "\t'Fathers Name' => 'Bill Doe',\n"
		str << "\t'Occupation' => 'Developer',\n"
		str << "\t'Annual Income' => '$30,000 USD\n"
		str << "}"
	end

	def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
  end
end
