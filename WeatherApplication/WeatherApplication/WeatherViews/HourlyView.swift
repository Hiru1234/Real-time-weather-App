//
//  Hourly.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourlyView: View {
    
   @EnvironmentObject var modelData: ModelData

    var body: some View {
        
        ZStack{
            
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                Text("\(modelData.userLocation)")
                    .font(.largeTitle)
                
                List {
                    ForEach(modelData.forecast!.hourly) { hour in
                        HourCondition(current: hour)
                        
                    }
                }
            }.opacity(0.8)

        }
        
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
