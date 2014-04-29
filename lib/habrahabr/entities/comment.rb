module Habrahabr
  module Entities
    class Comment < Base
      translate :author, User
    end
  end
end
