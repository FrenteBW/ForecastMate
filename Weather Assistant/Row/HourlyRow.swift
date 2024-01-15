//
//  HourlyRow.swift
//  Weather Assistant
//
//  Created by 안병욱의 mac on 2023/01/04.
//

import SwiftUI

struct HourlyRow: View {
    var hourlytime: String
    var logo: String
    var hourlytemp: String
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text(hourlytime)
                .bold()
            
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.8, opacity: 0.1))
                .cornerRadius(50)
            HStack{
                Text(hourlytemp)
                    .bold()
                    .font(.title2)
                Text("°")
            }
        }
    }
}

/*
struct HourlyRow_Previews: PreviewProvider {
    static var previews: some View {
        HourlyRow(hourlytime: " ", logo: " ", hourlytemp: " ")
    }
}
*/
