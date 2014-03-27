class Location < ActiveRecord::Base
  validates :address, :presence => true
  validates :city, :presence => true, :format => /\A[a-z ]+\z/i
  validates :state, :presence => true, :length => {is: 2}, :format => /\A[a-z]+\z/i
  validates :zipcode, :presence => true, :format => /\A[0-9]+\z/, :length => {is: 5}
end
