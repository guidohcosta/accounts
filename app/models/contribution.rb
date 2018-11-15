class Contribution < ApplicationRecord
  belongs_to :head
  has_secure_token :code
end
