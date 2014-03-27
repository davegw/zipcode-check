class LocationsController < ApplicationController

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(:address => params[:location][:address].downcase, :city => params[:location][:city].downcase, :state => params[:location][:state].downcase, :zipcode => params[:location][:zipcode])
    @location.errors.clear
    flash.alert = nil
    # if @location.save
    #   render 'success'
    # else
    #   render 'new'
    # end
    if @location.valid?
      address = @location.address
      city = @location.city
      state = @location.state
      # api_key = "AIzaSyBHB-4XsqFcIYYhid36PjMj5YJwkiFYy7Y"
      # uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{CGI.escape(address)},+#{CGI.escape(city)},+#{CGI.escape(state)}&sensor=true&key=#{api_key}")
      # res = Net::HTTP.get_response(uri)
      # zip = "12345"
      result = Geokit::Geocoders::GoogleGeocoder.geocode("#{address}, #{city}, #{state}")
      result_zipcode = result.zip
      if result_zipcode.nil?
        flash.alert = "No zip code found for that address."
        render 'new'
      elsif @location.zipcode == result_zipcode
        @location.save
        render 'success'
      elsif result.all.count > 1
        flash.alert = "Zip code does not match. Multiple addresses returned. Please be more specific."
        render 'new'
      else
        flash.alert = "Zip code does not match."
        render 'new'
      end
    else
      render 'new'
    end
  end
end