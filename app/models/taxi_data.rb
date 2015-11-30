require 'json'
require 'rest-client'
require 'time'
require 'date'
require 'time_diff'
require 'pry'

class TaxiData
  # Can move into two different objects - fare calculator, and time calculator
  def calculate_fare(user_trips)
   
    num = user_trips.map do |trip|
      trip.total_amount
    end  
    average = num.inject{ |sum, el| sum + el }.to_f / num.size
    average.round(2)
  end
  
  def calculate_time(user_trips)
    time_differences = user_trips.map do |trip|
      pickup = trip.tpep_pickup_datetime
      dropoff = trip.tpep_dropoff_datetime
      diff = Time.diff(dropoff, pickup, '%y, %M, %w, %d and %H %N %S') 
    end

    result = time_differences.map { |time| time[:minute] }
    average = result.inject{ |sum, el| sum + el }.to_f / result.size
    average.round(2)
  end
  
end



