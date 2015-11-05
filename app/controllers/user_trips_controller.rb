class UserTripsController < ApplicationController

  def new
    render 'welcome'
  end

  def create
    #create Trip
    @trip = UserTrip.new
    #set trips' user id if user is logged in
    @trip.user_id = session[:user_id] if logged_in?
    @trip.build_origin(address: params[:address1])
    @trip.build_destination(address: params[:address2])
    @trip.save


    #connect to apis to get data
    taxi_trip = Adapters::CabClient.new
    yellow_cabs = taxi_trip.find_yellow_cabs(@trip)
    green_cabs = taxi_trip.find_green_cabs(@trip)
    total_results = yellow_cabs.concat(green_cabs)

    #get avg cost and time for user trip
    data = TaxiData.new
    @cost = data.calculate_fare(total_results)
    @time = data.calculate_time(total_results)


    # uber search results
    uber_trip = Adapters::UberClient.new   
    uber_results = uber_trip.build_uber_url(@trip)
    @uber_ride = uber_trip.format_uber_results(uber_results)


    lyft = Lyft.new.build_lyft(@trip)
    
    @lyft_cost = lyft.cost
    @lyft_time = lyft.time
    

    render 'show'
    
  end

end


