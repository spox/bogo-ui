require 'stringio'
require 'minitest/autorun'

describe Bogo::Ui::Table do

  before do
    @stream = StringIO.new('')
    @ui = Bogo::Ui.new(
      :app_name => 'TestUi',
      :output_to => @stream
    )
  end

  let(:stream){ @stream }
  let(:ui){ @ui }

  it 'should output entire table' do
    table = Bogo::Ui::Table.new(ui) do
      table do
        row do
          column 'name'
          column 'age'
        end
        row do
          column 'me'
          column '100'
        end
      end
    end
    table.display
    stream.rewind
    stream.read.must_equal "name       age        \nme         100        \n"
  end

  it 'should output only new content' do
    table = Bogo::Ui::Table.new(ui) do
      table do
        row do
          column 'name'
          column 'age'
        end
        row do
          column 'me'
          column '100'
        end
      end
    end
    table.display
    stream.rewind
    stream.read.must_equal "name       age        \nme         100        \n"
    stream.string.clear
    table.update do
      row do
        column 'you'
        column '20'
      end
    end
    table.display
    stream.rewind
    stream.read.must_equal "\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000you        20         \n"
  end

end
