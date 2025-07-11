class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def after_sign_in_path_for(resource)
    params[:return_to].presence || stored_location_for(resource) || root_path
  end

  def after_sign_up_path_for(resource)
    params[:return_to].presence || stored_location_for(resource) || root_path
  end
end
