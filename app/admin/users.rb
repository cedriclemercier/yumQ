ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :first_name, :last_name, :username, :phone_number
  #
  # or
  
   permit_params do
     permitted = [ :email, :password, :password_confiramtion, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :first_name, :last_name, :username, :phone_number, :banned]
     permitted << :other if params[:action] == 'create' 
     permitted
   end


  form do |f|
      f.inputs "User" do
        f.input :email
        f.input :username
	f.input :first_name
	f.input :last_name
        f.input :phone_number
	f.input :banned	
      end
      f.actions
    end


  index do
    selectable_column
    id_column
    column :email
    column :username
    column :first_name
    column :last_name
    column :phone_number
    column :banned
    actions
  end


  
  filter :email
  filter :username
  filter :first_name
  filter :last_name
  filter :phone_number
  filter :banned

end
