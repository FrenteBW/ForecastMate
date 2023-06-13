//
//  DailyWeatherView.swift
//  Weather Assistant
//
//  Created by 안병욱의 mac on 2023/01/03.
//

import SwiftUI

struct DailyWeatherView: View {
    
    @ObservedObject var weatherKitManager = WeatherKitManager()
    @StateObject var locationDataManager = LocationDataManager()
    
    var body: some View {
        if locationDataManager.authorizationStatus == .authorizedWhenInUse {
            
            ZStack(alignment: .leading) {
                if weatherKitManager.todaydescription == "Clear" || weatherKitManager.todaydescription == "Mostly Clear" {
                    LinearGradient(gradient: Gradient(colors: [Color("topcolor"), Color("bottomcolor")]),
                                   startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                }
                else
                {
                    LinearGradient(gradient: Gradient(colors: [Color("graytopcolor"), Color("graybottomcolor")]),
                                   startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                }
                VStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("ForecastMate")
                            .bold()
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    //hourly weather data 자리
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Hourly Weather")
                            .bold()
                            .foregroundColor(.white)
                        
                        ScrollView(.horizontal, showsIndicators: true) {
                            
                            HStack {
                                ForEach(0..<12) { index in
                                    HStack {
                                        HourlyRow(hourlytime: weatherKitManager.hourlyForecasts[index].hour,
                                                  logo: weatherKitManager.hourlyForecasts[index].symbol,
                                                  hourlytemp: weatherKitManager.hourlyForecasts[index].temperature.roundDouble())
                                        Spacer()
                                    }
                                }.lineLimit(1)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)

                    .foregroundColor(.white)
                    .background(Color(hue: 0.6, saturation: 0.7, brightness: 0.3, opacity: 0.2))
                    .cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Daily Weather")
                            .bold()
                            .padding(.bottom)
                            .foregroundColor(.white)
                        
                        ScrollView(.vertical, showsIndicators: true) {
                            ForEach(0..<7) { index in
                                HStack {
                                    DailyRow(dailydate: weatherKitManager.dailyForecasts[index].date,
                                             logo: weatherKitManager.dailyForecasts[index].symbol,
                                             name: weatherKitManager.dailyForecasts[index].description,
                                             value: weatherKitManager.dailyForecasts[index].lowTemperature.roundDouble(),
                                             secondvalue: weatherKitManager.dailyForecasts[index].highTemperature.roundDouble())
                                    Spacer()
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(.white)
                    .background(Color(hue: 0.6, saturation: 0.7, brightness: 0.3, opacity: 0.2))
                    .cornerRadius(20, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .task {
                await weatherKitManager.getWeather(latitude: locationDataManager.latitude, longitude: locationDataManager.longitude)
            }
        }
    }
}
