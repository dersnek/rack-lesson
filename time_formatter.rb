class TimeFormatter
  SUPPORTED_DIRECTIVES = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }.freeze

  attr_reader :invalid_args, :requested_format

  def initialize(format)
    @requested_format = format.split(',')
    @invalid_args = []
    validate!
  end

  def valid?
    invalid_args.empty?
  end

  def format_time
    directive = requested_format.map { |f| SUPPORTED_DIRECTIVES[f.to_sym] }
    Time.now.strftime(directive.join('-'))
  end

  private

  def validate!
    @invalid_args = requested_format.reject { |f| SUPPORTED_DIRECTIVES.key?(f.to_sym) }
  end
end
