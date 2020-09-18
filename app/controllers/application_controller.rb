class ApplicationController < ActionController::Base
	
    def after_sign_in_path_for(resource_or_scope)
		groups_path
 	end

 	def after_sign_out_path_for(resource)
    	new_admin_session_path
    end

end
