//
//  WeatherManager.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 11/27/24.
//

import Foundation
import CoreLocation

class WeatherManager: ObservableObject {
    // HTTP request to get the current weather depending on the coordinates we got from LocationManager
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        // Replace YOUR_API_KEY in the link below with your own
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid= [REPLACE HERE]&units=metric") else { fatalError("Missing URL") }


        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

// Model of the response body we get from calling the OpenWeather API
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse // Coordinates
    var weather: [WeatherResponse] // Weather details
    var main: MainResponse // Temperature and related info
    var name: String // City name
    var wind: WindResponse // Wind info
    var clouds: CloudsResponse // Cloud data
    var dt: Int // Datetime
    var sys: SysResponse // Sunrise/Sunset
    var timezone: Int // Timezone offset in seconds
    var visibility: Int? // Visibility (optional)
    var uvi: Double? // UV Index (optional, for One Call API)
    var alerts: [WeatherAlert]? // Weather alerts (optional, for One Call API)
    var rain: PrecipitationResponse? // Rain data (optional)
    var snow: PrecipitationResponse? // Snow data (optional)
    // Coordinates
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    // Weather condition details
    struct WeatherResponse: Decodable {
        var id: Int
        var main: String
        var description: String
        var icon: String
    }
    
    // Temperature and pressure details
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    // Wind details
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
    
    // Cloud details
    struct CloudsResponse: Decodable {
        var all: Int
    }
    
    // Sunrise/Sunset details
    struct SysResponse: Decodable {
        var sunrise: Int
        var sunset: Int
    }
    
    // Optional weather alerts
    struct WeatherAlert: Decodable {
        var sender_name: String
        var event: String
        var start: Int
        var end: Int
        var description: String
        var tags: [String]
    }
}
struct PrecipitationResponse: Decodable {
    var oneHour: Double? // Precipitation in the last 1 hour (optional)
}
// Extensions for renamed keys in MainResponse
extension ResponseBody.MainResponse {
    var feelsLike: Double { feels_like }
    var tempMin: Double { temp_min }
    var tempMax: Double { temp_max }
}
