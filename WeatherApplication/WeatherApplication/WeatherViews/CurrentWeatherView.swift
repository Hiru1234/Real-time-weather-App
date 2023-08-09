//
//  Conditions.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var modelData: ModelData
    @State  var userLocation: String = ""
    
    @State var locationString: String = "No location"
    
    var body: some View {
        ZStack {
            // Background Image rendering code here
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text(userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                    .formatted(.dateTime.year().hour().month().day()))
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 1)
                
                VStack{
                    
                    //          Temperature Info
                    VStack {
                        Text("\((Int)(modelData.forecast!.current.temp))ºC")
                            .padding()
                            .font(.largeTitle)
                        HStack {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png"))
                            Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                                
                        }
                        
                        HStack{
                            Text("H: \((Int)(modelData.forecast!.daily[0].temp.max))ºC")
                                .foregroundColor(.black)
                            Spacer()
                            Text("L: \((Int)(modelData.forecast!.daily[0].temp.min))ºC")
                            
                        }
                        .padding(20)
                        
                        Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                            
                        
                        // wind speed  & direction
                        HStack{
                            Text("Wind Speed: \((Int)(modelData.forecast!.current.windSpeed))m/s")
                                
                            Spacer()
                            
                            Text("Direction:\( convertDegToCardinal(deg: modelData.forecast!.current.windDeg))")
                            
                        }
                        .padding()
                        
                        
                        // Humidity and Presure
                        HStack{
                            Text("Humidity: \((Int)(modelData.forecast!.current.humidity))%")
                                .foregroundColor(.black)
                            Spacer()
                            Text("Presure: \((Int)(modelData.forecast!.current.pressure))hpg")
                                
                        }
                        .padding()
                        
                        
                        HStack(spacing: 30) {
                            HStack{
                                Image(systemName: "sunrise.fill")
                                    .resizable()
                                    .frame(width: 25,height: 25)
                                    .foregroundColor(.yellow)
                                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunrise ?? 0))))
                                    .formatted(.dateTime.hour().minute()))
                               
                            }
                            HStack{
                                Image(systemName: "sunset.fill")
                                    .resizable()
                                    .frame(width: 25,height: 25)
                                    .foregroundColor(.yellow)
                                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunset ?? 0))))
                                    .formatted(.dateTime.hour().minute()))
                                    
                            }
                           
                          
                        }
                    }.padding()
                    
                    
                    
                }
                
            }
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
            
        }
        .onAppear {
            Task.init {
                self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                
            }
            
        }
        
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(ModelData())
    }
}
