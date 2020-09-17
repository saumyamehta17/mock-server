class Endpoint < ApplicationRecord
    # attr_accessor :response

    validates :verb, :path, :response_code, presence: true

    validates :verb, inclusion: { in: %w(GET HEAD POST PUT DELETE CONNECT OPTIONS TRACE),
    message: "%{value} is not a valid verb" }

    validates :response_code, numericality: { only_integer: true }

    before_validation :ensure_upcase_verb
    validate :valid_path?

    # save headers in hash

    private
        def ensure_upcase_verb
          self.verb = verb.upcase if verb
        end

        def valid_path?
            is_valid = true
            begin
                uri = URI.parse(self.path)
                is_valid = uri.relative?
            rescue URI::InvalidURIError
                is_valid = false
            end
            errors.add(:path, "invalid path") unless is_valid
        end

end
