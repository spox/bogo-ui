require 'bogo-ui'
require 'command_line_reporter'

module Bogo

  class Ui
    # Table output helper
    class Table

      include CommandLineReporter

      # @return [Bogo::Ui]
      attr_reader :ui
      # @return [Array<Proc>]
      attr_reader :table

      # Create a new instance
      #
      # @param ui [Bogo::Ui]
      # @yield table content
      # @return [self]
      def initialize(ui, &block)
        @ui = ui
        @base = block
        @content = []
        @printed_lines = 0
      end

      # Update the table content
      #
      # @yield table content
      # @return [self]
      def update(&block)
        @content << block
        self
      end

      # Override to provide buffered support
      #
      # @param options [Hash]
      # @return [self]
      def table(options={})
        @table = BufferedTable.new(options)
        yield
        self
      end

      # Override to provide buffered support
      #
      # @param options [Hash]
      # @return [self]
      def row(options={})
        options[:encoding] ||= @table.encoding
        @row = BufferedRow.new(options.merge(:buffer => @table.buffer))
        yield
        @table.add(@row)
        self
      end

      # Output table to defined UI
      #
      # @return [self]
      # @note can be called multiple times to print table updates
      def display
        # init the table
        instance_exec(&@base)
        # load the table
        @content.each do |tblock|
          instance_exec(&tblock)
        end
        @table.output
        @table.buffer.rewind
        output = @table.buffer.read.split("\n")
        output.slice!(0, @printed_lines)
        @printed_lines = output.size
        ui.puts output.join("\n")
        self
      end

      # Wrapper class to get desired buffering
      class BufferedTable < CommandLineReporter::Table

        # @return [StringIO]
        attr_reader :buffer

        # Create new instance and init buffer
        #
        # @return [self]
        def initialize(*args)
          @buffer = StringIO.new
          super
        end

        # buffered puts
        def puts(string)
          buffer.puts(string)
        end

        # buffered print
        def print(string)
          buffer.print(string)
        end

      end

      # Wrapper class to get desired buffering
      class BufferedRow < CommandLineReporter::Row

        # @return [StringIO]
        attr_reader :buffer

        # Create new instance and init buffer
        #
        # @return [self]
        def initialize(options={})
          @buffer = options.delete(:buffer)
          super
        end

        # buffered puts
        def puts(string)
          buffer.puts(string)
        end

        # buffered print
        def print(string)
          buffer.print(string)
        end

      end

    end
  end

end
