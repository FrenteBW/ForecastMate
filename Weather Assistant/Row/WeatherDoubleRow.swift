//
//  WeatherDoubleRow.swift
//  Weather Assistant
//
//  Created by 안병욱의 mac on 2022/12/19.
//

import SwiftUI

struct WeatherDoubleRow: View {
    var logo: String
    var name: String
    var value: String
    var secondvalue: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.8, opacity: 0.1))
                .cornerRadius(50)

            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                
                HStack(spacing: 5) {
                    Text(value)
                        .bold()
                        .font(.title2)
                    Text("~")
                        .bold()
                        .font(.title2)
                    Text(secondvalue)
                        .bold()
                        .font(.title2)
                }
            }
        }
    }
}

/*
struct WeatherDoubleRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDoubleRow(logo: "thermometer", name: "Feels like", value: "8°", secondvalue: "10")
    }
}
*/
