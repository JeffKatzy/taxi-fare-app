require 'json'
require 'rest-client'
require 'pry'

class GoogleMap

  def connection
    @connection = Adapters::DataConnection.new
  end
   # This also looks like an adapter to me - but its not a bad object
  def query(url_string)
    data = RestClient::Request.execute(method: :get, url: url_string)
    test_data = JSON.load(data)
  end


  def build_google(trip)
    params = {pickup_latitude: trip.origin.latitude, pickup_longitude: trip.origin.longitude, dropoff_longitude: trip.destination.longitude, dropoff_latitude: trip.destination.latitude}
    url_string = "https://maps.googleapis.com/maps/api/directions/json?origin=#{params[:pickup_latitude]},#{params[:pickup_longitude]}&destination=#{params[:dropoff_latitude]},#{params[:dropoff_longitude]}&mode=transit&key=AIzaSyBxVcOzWLwm2ihNWF4B5obSq-n_7qjJPWQ"
    connection.query(url_string)
  end

  def format_google_results(results)
    # I would say this we want to insert into another object instead of a hash
    map_hash = test_data['routes'][0]['legs'].map do |hash|
      {hash['departure_time']['text']
      hash['arrival_time']['text']
      hash['distance']['text']
      hash['duration']['text']
      hash['steps'][0]['html_instructions']
      hash['steps'][0]['transit_details']['departure_stop']['name']
      hash['steps'][0]['transit_details']['arrival_stop']['name']
      hash['steps'][0]['transit_details']['arrival_stop']['name']
      hash['steps'][0]['transit_details']['line']['name']
      hash['steps'][0]['transit_details']['line']['short_name']}
    end  
    map_hash
  end

end


# What is this?
############## WORKING CODE ################
### DIRECTIONS: https://maps.googleapis.com/maps/api/directions/json?origin=40.705329,-74.0139696&destination=40.7599157,-73.9911492&mode=transit&key=AIzaSyBxVcOzWLwm2ihNWF4B5obSq-n_7qjJPWQ

#### MAP: https://www.google.com/maps/embed/v1/directions?key=AIzaSyD2myD37q57UK60glSJpq3o0QzUzEygbeQ&origin=40.705329,-74.0139696&destination=40.7599157,-73.9911492&mode=transit
  
############## WORKING CODE ################

  ##### DIRCTIONS API KEY: AIzaSyBxVcOzWLwm2ihNWF4B5obSq-n_7qjJPWQ
  ##### MAP: AIzaSyD2myD37q57UK60glSJpq3o0QzUzEygbeQ

# transit requests directions via public transit routes (where available). If you set the mode to transit, you can optionally specify either a departure_time or an arrival_time. If neither time is specified, the departure_time defaults to now (that is, the departure time defaults to the current time). You can also optionally include a transit_mode and/or a transit_routing_preference.

# Transit Details



# A transit_details object may contain the following fields:

# arrival_stop and departure_stop contains information about the stop/station for this part of the trip. Stop details can include:
# name the name of the transit station/stop. eg. "Union Square".
# location the location of the transit station/stop, represented as a lat and lng field.
# arrival_time and departure_time contain the arrival or departure times for this leg of the journey, specified as the following three properties:
# text the time specified as a string. The time is displayed in the time zone of the transit stop.
# value the time specified as Unix time, or seconds since midnight, January 1, 1970 UTC.
# time_zone contains the time zone of this station. The value is the name of the time zone as defined in the IANA Time Zone Database, e.g. "America/New_York".
# headsign specifies the direction in which to travel on this line, as it is marked on the vehicle or at the departure stop. This will often be the terminus station.
# headway specifies the expected number of seconds between departures from the same stop at this time. For example, with a headway value of 600, you would expect a ten minute wait if you should miss your bus.
# num_stops contains the number of stops in this step, counting the arrival stop, but not the departure stop. For example, if your directions involve leaving from Stop A, passing through stops B and C, and arriving at stop D, num_stops will return 3.
# line contains information about the transit line used in this step, and may include the the following properties:
# name contains the full name of this transit line. eg. "7 Avenue Express".
# short_name contains the short name of this transit line. This will normally be a line number, such as "M7" or "355".
# color contains the color commonly used in signage for this transit line. The color will be specified as a hex string such as: #FF0033.
# agencies contains an array of TransitAgency objects that each provide information about the operator of the line, including the following properties:
# name contains the name of the transit agency.
# url contains the URL for the transit agency.
# phone contains the phone number of the transit agency.
# You must display the names and URLs of the transit agencies servicing the trip results.
# url contains the URL for this transit line as provided by the transit agency.
# icon contains the URL for the icon associated with this line.
# text_color contains the color of text commonly used for signage of this line. The color will be specified as a hex string.
# vehicle contains the type of vehicle used on this line. This may include the following properties:
# name contains the name of the vehicle on this line. eg. "Subway."
# type contains the type of vehicle that runs on this line. See the Vehicle Type documentation for a complete list of supported values.
# icon contains the URL for an icon associated with this vehicle type.



