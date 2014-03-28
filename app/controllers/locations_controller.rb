class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def new_js
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
      query = "#{address}, #{city}, #{state}"
      result = Geokit::Geocoders::GoogleGeocoder.geocode(query)
      result_zipcode = result.zip
      # Check if we got any search results.
      if result_zipcode.nil?
        flash.alert = "No zip code found for that address."
        render 'new'
      # CHeck if our result matches the input.
      elsif @location.zipcode == result_zipcode
        @location.save
        redirect_to success_path(:location => @location.id, :result => query)
      # Check if we got more than one search result.
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

  def search_request
    location_errors =[]
    zip_errors =[]
    location_id = []
    address = params[:address]
    city = params[:city]
    state = params[:state]
    zipcode = params[:zipcode]
    location = Location.new(:address => address, :city => city, :state => state, :zipcode => zipcode)
    if location.valid?
      query = "#{address}, #{city}, #{state}"
      result = Geokit::Geocoders::GoogleGeocoder.geocode(query)
      if result.zip.nil?
        zip_errors = "No zip code found for that address."
      elsif zipcode == result.zip
        location.save
        location_id = location.id
      elsif result.all.count > 1
        zip_errors = "Zip code does not match. Multiple addresses returned. Please be more specific."
      else
        zip_errors = "Zip code does not match."
      end
    else
      location.errors.full_messages.each do |msg|
        location_errors << msg
      end
    end
    render :json => { :success => (location_errors.empty? && zip_errors.empty?), :errors => location_errors, :zip_errors => zip_errors, :query => query, :location_id => location_id }
  end

  def success
    @location = Location.find(params[:location])
    @result = Geokit::Geocoders::GoogleGeocoder.geocode(params[:result])
  end
end