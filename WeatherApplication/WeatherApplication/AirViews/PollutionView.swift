//
//  PollutionView.swift
//  Coursework2
//
//  Created by GirishALukka on 30/12/2022.
//

import SwiftUI

struct PollutionView: View {
    
    // @EnvironmentObject and @State varaibles here
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        ZStack {
            
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            // Use ZStack for background images
            
            VStack(spacing: 40) {
                Text("\(modelData.userLocation)")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
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
                
                Text("Air quality Data")
                    .bold()
                    .font(.largeTitle)
                
                // images
                HStack{
                    VStack{
                        Image("so2")
                        if let so2Value = modelData.airPollution?.list[0].components.so2 {
                            Text("\(String(so2Value))")
                        } else {
                            // Handle the case where the optional value is nil
                            Text("N/A")
                        }
                    }
                    
                    VStack{
                        Image("no")
                        if let so2Value = modelData.airPollution?.list[0].components.no2 {
                            Text("\(String(so2Value))")
                        } else {
                            // Handle the case where the optional value is nil
                            Text("N/A")
                        }
                    }
                    
                    VStack{
                        Image("voc")
                        if let so2Value = modelData.airPollution?.list[0].components.co {
                            Text("\(String(so2Value))")
                        } else {
                            // Handle the case where the optional value is nil
                            Text("N/A")
                        }
                    }
                    
                    VStack{
                        Image("pm")
                        if let so2Value = modelData.airPollution?.list[0].components.pm10 {
                            Text("\(String(so2Value))")
                        } else {
                            // Handle the case where the optional value is nil
                            Text("N/A")
                        }
                    }
                }
                
            }
            
            
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
            
        }
        .onAppear{
            Task{
               try await modelData.loadAirData()
            }
        }
        
    }
//    func checkWhetherNil(value: Double) -> String{
//        String
//        if let so2Value = modelData.airPollution?.list[0].components.so2 {
//            Label("\(String(so2Value))", image: "so2")
//        } else {
//            // Handle the case where the optional value is nil
//            Label("N/A", image: "so2")
//        }
//    }
}



