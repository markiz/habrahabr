module Habrahabr
  module Entities
    class Post < Base
      translate :author, User
    end
  end
end
