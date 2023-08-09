//
//  Forecast.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var modelData: ModelData
    @State var locationString: String = "No location"
    var body: some View {
        
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
            
            
            VStack{
                
                Text("\(modelData.userLocation)")
                    .font(.largeTitle)

                List{
                    ForEach(modelData.forecast!.daily) { day in
                        DailyView(day: day)
                    }
                }
            }.opacity(0.8)
        }
       
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
