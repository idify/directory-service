class Users::PasswordsController< Devise::PasswordsController
  layout 'plain', only:['new', 'create', 'edit', 'update']
end