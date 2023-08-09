//
//  HourCondition.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourCondition: View {
    var current : Current
  
    
    var body: some View {
        
        HStack {
            
            Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current.dt))))
                .formatted(.dateTime.hour().minute()))
            
            //loads image from OpenWeatherMap API
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(current.weather[0].icon)@2x.png"))
            
            Text("\((Int)(current.temp))ºC")
            
            Text("\(current.weather[0].weatherDescription.rawValue)")

        }.padding()
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = ModelData().forecast!.hourly
    
    static var previews: some View {
        HourCondition(current: hourly[0])
    }
}
