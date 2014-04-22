class Conversations::Pictures::Validator < ActiveModel::Validator
  def validate(interactor)
    validate_attached_file interactor
  end

  def validate_attached_file(interactor)
    return interactor.errors.add :attached_file_id, :no_such_file if interactor.attached_file.blank?
    return interactor.errors.add :attached_file_id, :already_claimed if interactor.attached_file.claimed_by_picture?
  end
end