module Habrahabr
  module Entities
    class ListResult
      class NextLink < Base
      end

      attr_reader :pages_count, :next_link, :data
      def initialize(attrs, data_coercion_class = nil)
        attrs = HashWithIndifferentAccess.new(attrs)
        @pages_count = attrs.fetch(:pages) { 1 }
        @next_link = NextLink.new(attrs[:next_link] || attrs[:next_page] || {})
        @data = attrs.fetch(:data)
        @data = @data.map {|item| data_coercion_class.new(item) } if data_coercion_class
      end

      def method_missing(m, *args, &block)
        if data.respond_to?(m)
          data.__send__(m, *args, &block)
        else
          super
        end
      end

      def respond_to_missing?(m, *args, &block)
        data.respond_to?(m) || super
      end
    end
  end
end
