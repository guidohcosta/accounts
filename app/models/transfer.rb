class Transfer < ApplicationRecord
  belongs_to :from, polymorphic: true
  belongs_to :to, class_name: 'Branch', foreign_key: :to
end
