class Emoji::ScrapInteractor
  class << self
    def scrap_between!(range)
      range.map do |k|
        new(k).scrap!
      end
    end
  end
  attr_accessor :number, :logger
  def initialize(number)
    @number = number
    @sauce = "http://okfocus.s3.amazonaws.com/emoji/#{number}.png"
    @logger = logger || lambda { |a| puts a }
  end

  def scrap!
    _save_sauce_or_fail
  end

  private
  def _logger(str)
    logger.call str
  end
  def _save_sauce_or_fail
    if _response_okay?
      _save_body_to_file 
    else
      _logger "#{src} did not give 200 ok response"
    end
  end

  def _save_body_to_file
    _file_handle { |f| f.puts _body }
  end

  def _body
    _response.try(:body).payload
  end

  def _response
    begin
      @response ||= FunctionalSupport::Either.right Net::HTTP.get_response _uri
    rescue e
      _logger "#{src} failed to get response"
      FunctionalSupport::Either.left e
    end
  end

  def _uri
    @uri = URI @sauce
  end

  def _file_handle(&block)
    begin
      File.open(_filename, "wb", &block)
      true
    rescue e
      _logger "#{src} failed to save to file"
      FunctionalSupport::Either.left e
    end
  end

  def _filename
    File.join _root_folder, "#{number}.png"
  end

  def _root_folder
    Rails.root.join 'public', 'emoji'
  end

  def _response_okay?
    "200" == _response_code
  end

  def _response_code
    _response.try(:code).payload
  end

  def _response_bad?
    !_response_okay?
  end
end