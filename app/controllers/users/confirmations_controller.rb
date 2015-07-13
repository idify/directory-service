class Users::ConfirmationsController< Devise::ConfirmationsController
  layout 'plain', only:['new', 'create']
end