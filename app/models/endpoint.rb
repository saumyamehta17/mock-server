class Endpoint < ApplicationRecord
    # attr_accessor :response

    validates :verb, :path, :response_code, presence: true

    validates :verb, inclusion: { in: %w(GET HEAD POST PUT DELETE CONNECT OPTIONS TRACE),
    message: "%{value} is not a valid verb" }

    validates :response_code, numericality: { only_integer: true }

    before_validation :ensure_upcase_verb

    # uniqueness with path and code

    private
        def ensure_upcase_verb
          self.verb = verb.upcase if verb
        end

end
