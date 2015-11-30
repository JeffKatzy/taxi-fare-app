module Adapters
  class UberClient

    def connection
      @connection = Adapters::DataConnection.new
    end

   # rename this url
    def build_uber_url(trip)
      params = {pickup_latitude: trip.origin.latitude, pickup_longitude: trip.origin.longitude, dropoff_longitude: trip.destination.longitude, dropoff_latitude: trip.destination.latitude}
      url_string = "https://api.uber.com/v1/estimates/price?start_latitude=#{params[:pickup_latitude]}&start_longitude=#{params[:pickup_longitude]}&end_latitude=#{params[:dropoff_latitude]}&end_longitude=#{params[:dropoff_longitude]}&server_token=1awe7eeZJLJ0MtUKWAuztdjprfE0siXFI8Bq2XO9"
      connection.query(url_string)
    end
    # perhaps have this go into an object instead of building out a hash
    def format_uber_results(results)
      uber_hash = results["prices"].map do |hash|
        {"localized_display_name" => hash["localized_display_name"],
        "duration" => (hash["duration"] / 60),
        "estimate" => hash["estimate"]}
      end  
      uber_hash[0]
    end
    
  end
end