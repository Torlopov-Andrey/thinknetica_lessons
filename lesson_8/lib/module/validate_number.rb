module ValidateNumber
  NUMBER_FORMAT = /^[а-я\d]{3}-?[а-я\d]{2}/i

  def validate!
    raise 'Number can\'t be nil' if number.nil?
    raise 'Number should be at least 5 symbols' if number.length < 5
    raise 'Number has invalid formar' if number !~ NUMBER_FORMAT
  end
end
