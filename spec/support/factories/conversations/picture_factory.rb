class Factories::Conversations::Picture < Factories::Conversations::Material
  def attributes
    {
      pictures: _pictures
    }
  end

  private
  def _pictures
    @pictures ||= 1.upto(4).map { File.new _filename }
  end
  def _filename
    Rails.root.join('public','gotes.jpg')
  end
  def _interactor
    @interactor ||= FoxYam::Listings::Pictures::Interactor.new conversation
  end
end