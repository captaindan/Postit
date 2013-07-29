module ApplicationHelper
	
	#these methods are available to all views
	#if you need a helper method that can be accessed by controllers it has to be in application_controller.rb

	def display_datetime(dt)
		dt.strftime("%m/%d/%Y %l:%M%P %Z")
	end

	def fix_url(url)
		url.starts_with?('http://', 'https://') ? url : "http://#{url}"
	end

end
