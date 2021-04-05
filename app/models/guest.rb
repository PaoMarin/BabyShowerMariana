class Guest < ApplicationRecord
    has_many :scort_guests
    accepts_nested_attributes_for :scort_guests

    scope :active, -> { where(confirmation: 1) }

    def self.search(search)
        if search
            where(["unaccent(fullname) LIKE unaccent(?)","%#{search}%"])
        else
            @guest = ""
        end
    end


end
