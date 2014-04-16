class Users::Registrations::Interactor < InteractorBase
  Fields = [
    :email,
    :company_name,
    :password,
    :password_confirmation,
    :back
  ]
  attr_accessor :attributes, :user
  attr_hash_accessor *Fields

  validates :email,
    :company_name,
    :password,
    :password_confirmation,
    with: :presence

  validates :password,
    confirmation: true,
    length: 4..256

  validates :email, 
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  delegate :exists?,
    to: :_user_class

  def user!
    _merchant_user if valid?
  end

  def back_path
    back
  end

  def successful?
    @user.present? && @merchant.present?
  end

  def failed?
    !successful?
  end

  def errors_with_user
    _merge(errors_without_user, _new_user.errors)
  end
  alias_method_chain :errors, :user

  def valid_with_user?
    valid_without_user? && _new_user.valid?
  end
  alias_method_chain :valid?, :user

  private
  def _merge(e1, e2)
    e2.each do |attribute, error|
      e1.add attribute, error
    end
    _kill_repeats e1
  end
  def _kill_repeats(es)
    es.keys.each do |key|
      es[key].uniq!
    end
    es
  end
  def _new_user
    @user ||= FoxYam::User.new email: email, password: password, password_confirmation: password_confirmation
  end
  def _user
    @user
  end
  def _merchant_user
    _user.save && _merchant && _user
  end

  def _merchant
    @merchant ||= _user.merchants.create name: company_name if _new_merchant?
    @merchant ||= _old_merchant.considers_hiring _user if _old_merchant?
  end

  def _old_merchant
    @old_merchant ||= FoxYam::Merchant.find_by_permalink company_name
  end

  def _old_merchant?
    _old_merchant.present?
  end

  def _new_merchant?
    !_old_merchant?
  end

  def _user_class
    User
  end

end