require 'stringio'
require 'minitest/autorun'

describe Bogo::Ui do

  before do
    @stream = StringIO.new('')
    @ui = Bogo::Ui.new(
      :app_name => 'TestUi',
      :output_to => @stream,
      :colors => false
    )
  end

  let(:stream){ @stream }
  let(:ui){ @ui }

  it 'should output raw string' do
    ui.print 'test'
    stream.rewind
    stream.read.must_equal 'test'
  end

  it 'should output raw line' do
    ui.puts 'test'
    stream.rewind
    stream.read.must_equal "test\n"
  end

  it 'should output formatted information' do
    ui.info 'test'
    stream.rewind
    stream.read.must_equal "[TestUi]: test\n"
  end

  it 'should output formatted warning' do
    ui.warn 'test'
    stream.rewind
    stream.read.must_equal "[WARN]: test\n"
  end

  it 'should output formatted error' do
    ui.error 'test'
    stream.rewind
    stream.read.must_equal "[ERROR]: test\n"
  end

  it 'should ask for input' do
    cache_in = $stdin
    $stdin = StringIO.new("test\n")
    result = ui.ask 'test'
    $stdin = cache_in
    stream.rewind
    result.must_equal 'test'
    stream.read.must_equal '[TestUi]: test: '
  end

  describe 'Verbose mode' do

    it 'should not output when verbose is not enabled' do
      ui.verbose 'testing'
      stream.rewind
      stream.read.must_be :empty?
    end

    it 'should output when verbose mode is enabled' do
      v_ui = Bogo::Ui.new(
        :app_name => 'TestUi',
        :output_to => @stream,
        :colors => false,
        :verbose => true
      )
      v_ui.verbose 'testing'
      stream.rewind
      stream.read.must_equal "[TestUi]: testing\n"
    end

  end

  describe 'Debug mode' do

    it 'should not output when debug is not enabled' do
      ui.debug 'testing'
      stream.rewind
      stream.read.must_be :empty?
    end

    it 'should output when debug mode is enabled' do
      v_ui = Bogo::Ui.new(
        :app_name => 'TestUi',
        :output_to => @stream,
        :colors => false,
        :debug => true
      )
      v_ui.debug 'testing'
      stream.rewind
      stream.read.must_equal "[DEBUG]: testing\n"
    end

  end

end
