
import Foundation

class WeatherStorage{
    static let shared = WeatherStorage()
    
    private let kActWeatherKey = "WeatherStorage.kActWeatherKey"
    private let kWeather5date = "WeatherStorage.kWeather5dateKey"
    private let kWeather5 = "WeatherStorage.kWeather5Key"
    
    var actWeather: String? {
        set { UserDefaults.standard.set(newValue, forKey: kActWeatherKey)}
        get { return UserDefaults.standard.string(forKey: kActWeatherKey) }
    }
    
    var weather5date: [String]? {
        set { UserDefaults.standard.set(newValue, forKey: kWeather5date)}
        get { return UserDefaults.standard.stringArray(forKey: kWeather5date) }
    }
    
    var weather5: [String]? {
        set { UserDefaults.standard.set(newValue, forKey: kWeather5)}
        get { return UserDefaults.standard.stringArray(forKey: kWeather5) }
    }

    
}



