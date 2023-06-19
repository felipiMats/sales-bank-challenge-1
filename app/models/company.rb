class Company < ApplicationRecord
    has_many :sale, dependent: :destroy
end
