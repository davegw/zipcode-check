class Location < ActiveRecord::Base
  validates :address, :presence => true
  validates :city, :presence => true, :format => /\A[a-z ]+\z/i
  state_codes = "AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY"
  validates :state, :presence => true, :length => {is: 2}, format: {with: /#{state_codes}/i, message: "postal code invalid"}
  validates :zipcode, :presence => true, :format => /\A[0-9]+\z/, :length => {is: 5}
end
