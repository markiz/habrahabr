module Habrahabr
  module Entities
    class Base < ::Hashie::Hash
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::MergeInitializer
      include Hashie::Extensions::MethodAccess

      class <<self
        def translated_keys
          @translated_keys ||= {}
        end

        def translate(key, klass)
          translated_keys[key.to_s] = klass
        end
      end


      def []=(key, value)
        key = convert_key(key)
        if self.class.translated_keys.has_key?(key)
          super(key, self.class.translated_keys[key].new(value))
        else
          super
        end
      end
    end
  end
end
