class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def create
    @location = Location.new(:address => params[:location][:address].downcase, :city => params[:location][:city].downcase, :state => params[:location][:state].downcase, :zipcode => params[:location][:zipcode])
    @location.errors.clear
    flash.alert = nil
    if @location.valid?
      address = @location.address
      city = @location.city
      state = @location.state
      result = Geokit::Geocoders::GoogleGeocoder.geocode("#{address}, #{city}, #{state}")
      result_zipcode = result.zip
      # Check if we got any search results.
      if result_zipcode.nil?
        flash.alert = "No zip code found for that address."
        render 'new'
      # CHeck if our result matches the input.
      elsif @location.zipcode == result_zipcode
        @location.save
        redirect_to success_path
      # Check if we got more than one search result.
      elsif result.all.count > 1
        flash.alert = "Zip code does not match. Multiple addresses returned. Please be more specific."
        render 'new'
      else
        flash.alert = "Zip code does not match."
        redirect_to new_location_path
      end
    else
      render 'new'
    end
  end

  def success
  end
end