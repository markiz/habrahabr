require 'hashie/extensions/indifferent_access'
require 'hashie/extensions/merge_initializer'

module Habrahabr
  class HashWithIndifferentAccess < ::Hashie::Hash
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::MergeInitializer

    def fetch(key, *args, &block)
      super(convert_key(key), *args, &block)
    end
  end
end
