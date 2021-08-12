class Apartment < ActiveRecord::Base
    belongs_to :tenement
    has_many :occupants
end