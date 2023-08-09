//
//  NavBar.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct NavBar: View {
    
    var body: some View {
        TabView{
            Home()
                .tabItem{
                    
                    Label("City", systemImage: "magnifyingglass")
                }
            CurrentWeatherView()
                .tabItem {
                    
                    Label("WeatherNow", systemImage: "sun.max.fill")
                }
            
            HourlyView()
                .tabItem{
                    
                    Label("Houly Summary", systemImage: "clock.fill")
                }
            ForecastView()
                .tabItem {
                    
                    Label("Forcast", systemImage: "calendar")
                }
            PollutionView()
                .tabItem {
                    
                    Label("Pollution", systemImage: "aqi.high")
                }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
    
}

