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
                                HStack {
                                    HourlyRow(hourlytime: weatherKitManager.hourhour, logo: weatherKitManager.hoursymbol, hourlytemp: weatherKitManager.hourtemp.roundDouble())
                                    Spacer()
                                }.lineLimit(1)
                                
                                HStack {
                                    HourlyRow(hourlytime: weatherKitManager.hourhour1, logo: weatherKitManager.hoursymbol1, hourlytemp: weatherKitManager.hourtemp1.roundDouble())
                                    Spacer()
                                }.lineLimit(1)
                                
                                HStack {
                                    HourlyRow(hourlytime: weatherKitManager.hourhour2, logo: weatherKitManager.hoursymbol2, hourlytemp: weatherKitManager.hourtemp2.roundDouble())
                                    Spacer()
                                }.lineLimit(1)
                                
                                HStack {
                                    HourlyRow(hourlytime: weatherKitManager.hourhour3, logo: weatherKitManager.hoursymbol3, hourlytemp: weatherKitManager.hourtemp3.roundDouble())
                                    Spacer()
                                }.lineLimit(1)
                                
                                HStack {
                                    HourlyRow(hourlytime: weatherKitManager.hourhour4, logo: weatherKitManager.hoursymbol4, hourlytemp: weatherKitManager.hourtemp4.roundDouble())
                                    Spacer()
                                }.lineLimit(1)
                                
                                HStack {
                                    HourlyRow(hourlytime: weatherKitManager.hourhour5, logo: weatherKitManager.hoursymbol5, hourlytemp: weatherKitManager.hourtemp5.roundDouble())
                                    Spacer()
                                }.lineLimit(1)
                                
                                HStack {
                                    HourlyRow(hourlytime: weatherKitManager.hourhour6, logo: weatherKitManager.hoursymbol6, hourlytemp: weatherKitManager.hourtemp6.roundDouble())
                                    Spacer()
                                }.lineLimit(1)
                                
                                HStack {
                                    HourlyRow(hourlytime: weatherKitManager.hourhour7, logo: weatherKitManager.hoursymbol7, hourlytemp: weatherKitManager.hourtemp7.roundDouble())
                                    Spacer()
                                }.lineLimit(1)
                                
                                HStack {
                                    HourlyRow(hourlytime: weatherKitManager.hourhour8, logo: weatherKitManager.hoursymbol8, hourlytemp: weatherKitManager.hourtemp8.roundDouble())
                                    Spacer()
                                }.lineLimit(1)
                                
                                HStack {
                                    HourlyRow(hourlytime: weatherKitManager.hourhour9, logo: weatherKitManager.hoursymbol9, hourlytemp: weatherKitManager.hourtemp9.roundDouble())
                                    Spacer()
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
                            HStack {
                                DailyRow(dailydate:weatherKitManager.dailydate, logo: weatherKitManager.dailysymbol, name: weatherKitManager.dailydescription, value: weatherKitManager.dailylowtemp.roundDouble(), secondvalue: weatherKitManager.dailyhightemp.roundDouble())
                                Spacer()
                            }.lineLimit(1)
                            
                            HStack {
                                DailyRow(dailydate:weatherKitManager.dailydate2, logo: weatherKitManager.dailysymbol2, name: weatherKitManager.dailydescription2, value: weatherKitManager.dailylowtemp2.roundDouble(), secondvalue: weatherKitManager.dailyhightemp2.roundDouble())
                                Spacer()
                            }
                            
                            HStack {
                                DailyRow(dailydate:weatherKitManager.dailydate3, logo: weatherKitManager.dailysymbol3, name: weatherKitManager.dailydescription3, value: weatherKitManager.dailylowtemp3.roundDouble(), secondvalue: weatherKitManager.dailyhightemp3.roundDouble())
                                Spacer()
                            }
                            
                            HStack {
                                DailyRow(dailydate:weatherKitManager.dailydate4, logo: weatherKitManager.dailysymbol4, name: weatherKitManager.dailydescription4, value: weatherKitManager.dailylowtemp4.roundDouble(), secondvalue: weatherKitManager.dailyhightemp4.roundDouble())
                                Spacer()
                            }
                            
                            HStack {
                                DailyRow(dailydate:weatherKitManager.dailydate5, logo: weatherKitManager.dailysymbol5, name: weatherKitManager.dailydescription5, value: weatherKitManager.dailylowtemp5.roundDouble(), secondvalue: weatherKitManager.dailyhightemp5.roundDouble())
                                Spacer()
                            }
                            
                            HStack {
                                DailyRow(dailydate:weatherKitManager.dailydate6, logo: weatherKitManager.dailysymbol6, name: weatherKitManager.dailydescription6, value: weatherKitManager.dailylowtemp6.roundDouble(), secondvalue: weatherKitManager.dailyhightemp6.roundDouble())
                                Spacer()
                            }
                            
                            HStack {
                                DailyRow(dailydate:weatherKitManager.dailydate7, logo: weatherKitManager.dailysymbol7, name: weatherKitManager.dailydescription7, value: weatherKitManager.dailylowtemp7.roundDouble(), secondvalue: weatherKitManager.dailyhightemp7.roundDouble())
                                Spacer()
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

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView()
    }
}

