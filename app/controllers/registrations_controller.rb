class RegistrationsController < Devise::RegistrationsController
  def update
    super do |resource|
      if resource.errors.none?
        # Redirect to their preferred locale if the user changes it
        I18n.locale = resource.locale if resource.locale != I18n.locale
      end
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    sign_in_after_change_password? ? edit_registration_path(resource) : new_session_path(resource_name)
  end
end
