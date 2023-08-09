import Foundation
class ModelData: ObservableObject {
    @Published var forecast: Forecast?
    @Published  var userLocation: String = ""
    @Published  var airPollution: AirModelData?
    init() {
        self.forecast = load("london.json")
    }
    var apiCallCount = 0
    
    //Load weather forecast data from OpenWeatherMap API using latitude and longitude coordinates.
    func loadData(lat: Double, lon: Double) async throws -> Forecast {
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=3c6f10cd82e029bec5d5c53e43987080")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            DispatchQueue.main.async {
                self.forecast = forecastData
            }
            
            return forecastData
        } catch {
            throw error
        }
    }
    
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
    
    //loads air pollution data from the OpenWeatherMap API using latitude and longitude coordinates
    func loadAirData() async throws -> AirModelData{
        
        guard let lat = forecast?.lat, let lon = forecast?.lon else {
            fatalError("Couldn't find lat and long in forecast data")
        }
        
        let url = URL(string:
                        "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&units=metric&appid=3c6f10cd82e029bec5d5c53e43987080")
        
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            let pollutionData = try JSONDecoder().decode(AirModelData.self, from: data)
            DispatchQueue.main.async {
                self.airPollution = pollutionData
            }
            
            return pollutionData
        } catch {
            throw error
        }
    }
}
