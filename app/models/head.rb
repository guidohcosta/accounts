class Head < ApplicationRecord
  has_many :branches, as: :parent, dependent: :destroy
end
