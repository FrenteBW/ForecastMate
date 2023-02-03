//
//  WeatherKitManager.swift
//  Weather Assistant
//
//  Created by 안병욱의 mac on 2022/11/29.
//

import Foundation
import WeatherKit
import SwiftUI

@MainActor class WeatherKitManager: ObservableObject {
    
    @Published var weather: Weather?
    
    func getWeather(latitude: Double, longitude: Double) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) {
                return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longitude))
            }.value
        } catch {
            fatalError("\(error)")
        }
    }
    
// MARK: HomeView Components
    //추가
    var rainforecast: Double {
        let rainforecast =
        weather?.minuteForecast?[1].precipitationChance ?? 1.0
        let convert: Double = (rainforecast * 100.0)
        
        return convert
    }
    
    var todaysymbol: String {
        let todaysymbol = weather?.currentWeather.symbolName.description
        
        return todaysymbol ?? "xmark"
    }
    
    var todaydescription: String {
        let todaydescription =
        weather?.dailyForecast[0].condition.description
        
        return todaydescription ?? "none"
    }
    
    var temp: Double {
        let temp =
        weather?.currentWeather.temperature
        
        let convert = temp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    var humid: Double {
        let humid =
        weather?.currentWeather.humidity ?? 0.0
        
        let convert: Double = (humid * 100.0)
        return convert
    }

    var windspeed: Double {
        let windspeed =
        weather?.currentWeather.wind.speed
        
        let convertwind = (windspeed?.converted(to: .metersPerSecond).value)
        return convertwind ?? 0.0
    }
    
    var uv: String {
        let uv =
        weather?.currentWeather.uvIndex.value.description
        
        return uv ?? "0"
    }
   
    var covercloud: Double {
        let covercloud =
        weather?.currentWeather.cloudCover
        
        return covercloud ?? 0.0
    }
    
    //체감 온도
    var realtemp: Double {
        let realtemp =
        weather?.currentWeather.apparentTemperature
        let convert = realtemp?.converted(to: .celsius).value
        
        return convert ?? 0.0
    }
    
    var hightemp: Double {
        let hightemp =
        weather?.dailyForecast[0].highTemperature.value //0은 오늘, 1은 내일, 2는 모레...
        
        return hightemp ?? 0.0
    }
    
    var lowtemp: Double {
        let lowtemp =
        weather?.dailyForecast[0].lowTemperature.value
        
        return lowtemp ?? 0.0
    }
    
    var risesun: String {
        let risesun =
        weather?.dailyForecast[0].sun.sunrise?.formatted(date: .omitted, time: .shortened)
        
        return risesun ?? "Loading weather Data"
    }
    
    var setsun: String {
        let setsun =
        weather?.dailyForecast[0].sun.sunset?.formatted(date: .omitted, time: .shortened)
        
        return setsun ?? "Loading weather Data"
    }

    var risemoon: String {
        let risemoon =
        weather?.dailyForecast[0].moon.moonrise?.formatted(date: .omitted, time: .shortened)
        
        return risemoon ?? "Loading weather Data"
    }
    
    var setmoon: String {
        let setmoon =
        weather?.dailyForecast[0].moon.moonset?.formatted(date: .omitted, time: .shortened)
        
        return setmoon ?? "Loading weather Data"
    }
    
    var loca: String {
        let loca =
        weather?.dailyForecast.metadata.location.description
        
        return loca ?? "Loading Weather Data"
    }

// MARK: DailyWeatherView에서 HourlyWeather compenents
    
    //실시간 시간 불러오는 함수
    func hour(i: Int) -> Int{
        let current = Date()
        
        let formatter = DateFormatter()
        //한국 시간으로 표시
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        //형태 변환
        formatter.dateFormat = "HH"
        
        return (Int(formatter.string(from: current)) ?? 0) + i
    }
    
    //현재시간
    var hourhour: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 2)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 2)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 2)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    //현재시간 + 1
    var hourhour1: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 3)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol1: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 3)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp1: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 3)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    //현재시간 + 2
    var hourhour2: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 4)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol2: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 4)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp2: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 4)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    //현재시간 + 3
    var hourhour3: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 5)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol3: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 5)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp3: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 5)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    //현재시간 + 4
    var hourhour4: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 6)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol4: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 6)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp4: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 6)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    //현재시간 + 5
    var hourhour5: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 7)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol5: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 7)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp5: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 7)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    //현재시간 + 6
    var hourhour6: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 8)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol6: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 8)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp6: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 8)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    //현재시간 + 7
    var hourhour7: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 9)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol7: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 9)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp7: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 9)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    //현재시간 + 8
    var hourhour8: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 10)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol8: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 10)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp8: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 10)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    //현재시간 + 9
    var hourhour9: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 11)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol9: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 11)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp9: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 11)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    //현재시간 + 10
    var hourhour10: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 12)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol10: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 12)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp10: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 12)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
    
    //현재시간 + 11
    var hourhour11: String {
        let hourhour =
        weather?.hourlyForecast[hour(i: 13)].date.formatted(.dateTime.hour())
        return hourhour ?? "0"
    }
    
    var hoursymbol11: String {
        let hoursymbol =
        weather?.hourlyForecast[hour(i: 13)].symbolName
        return hoursymbol ?? "0"
    }
    
    var hourtemp11: Double {
        let hourtemp =
        weather?.hourlyForecast[hour(i: 13)].temperature
        let convert = hourtemp?.converted(to: .celsius).value
        return convert ?? 0.0
    }
// MARK:  DailyWeatherView에서 DailyWeather components
// 1일차
    //1일차 최고 기온
    var dailyhightemp: Double {
        let dailyhightemp =
        weather?.dailyForecast[1].highTemperature.value
        
        return dailyhightemp ?? 0.0
    }
    
    //1일차 최저 기온
    var dailylowtemp: Double {
        let dailylowtemp =
        weather?.dailyForecast[1].lowTemperature.value
        
        return dailylowtemp ?? 0.0
    }
    
    //1일차 날씨 symbol
    var dailysymbol: String {
        let dailysymbol =
        weather?.dailyForecast[1].symbolName
        
        return dailysymbol ?? "cloud"
    }
    
    //1일차 날짜
    var dailydate: String {
        let dailydate =
        weather?.dailyForecast[1].date.formatted(.dateTime.month().day())
        
        return dailydate ?? "today"
    }
    
    //1일차 Description
    var dailydescription: String {
        let dailydescription =
        weather?.dailyForecast[1].condition.description
        
        return dailydescription ?? "none"
    }
    
//2일차
    //2일차 최고 기온
    var dailyhightemp2: Double {
        let dailyhightemp =
        weather?.dailyForecast[2].highTemperature.value
        
        return dailyhightemp ?? 0.0
    }
    
    //2일차 최저 기온
    var dailylowtemp2: Double {
        let dailylowtemp =
        weather?.dailyForecast[2].lowTemperature.value
        
        return dailylowtemp ?? 0.0
    }
    
    //2일차 날씨 symbol
    var dailysymbol2: String {
        let dailysymbol =
        weather?.dailyForecast[2].symbolName
        
        return dailysymbol ?? "cloud"
    }
    
    //2일차 날짜
    var dailydate2: String {
        let dailydate =
        weather?.dailyForecast[2].date.formatted(.dateTime.month().day())
        
        return dailydate ?? "today"
    }
    
    //2일차 Description
    var dailydescription2: String {
        let dailydescription =
        weather?.dailyForecast[2].condition.description
        
        return dailydescription ?? "none"
    }
    
//3일차
    //3일차 최고 기온
    var dailyhightemp3: Double {
        let dailyhightemp =
        weather?.dailyForecast[3].highTemperature.value
        
        return dailyhightemp ?? 0.0
    }
    
    //3일차 최저 기온
    var dailylowtemp3: Double {
        let dailylowtemp =
        weather?.dailyForecast[3].lowTemperature.value
        
        return dailylowtemp ?? 0.0
    }
    
    //3일차 날씨 symbol
    var dailysymbol3: String {
        let dailysymbol =
        weather?.dailyForecast[3].symbolName
        
        return dailysymbol ?? "cloud"
    }
    
    //3일차 날짜
    var dailydate3: String {
        let dailydate =
        weather?.dailyForecast[3].date.formatted(.dateTime.month().day())
        
        return dailydate ?? "today"
    }
    
    //3일차 Description
    var dailydescription3: String {
        let dailydescription =
        weather?.dailyForecast[3].condition.description
        
        return dailydescription ?? "none"
    }
    
//4일차
    //4일차 최고 기온
    var dailyhightemp4: Double {
        let dailyhightemp =
        weather?.dailyForecast[4].highTemperature.value
        
        return dailyhightemp ?? 0.0
    }
    
    //4일차 최저 기온
    var dailylowtemp4: Double {
        let dailylowtemp =
        weather?.dailyForecast[4].lowTemperature.value
        
        return dailylowtemp ?? 0.0
    }
    
    //4일차 날씨 symbol
    var dailysymbol4: String {
        let dailysymbol =
        weather?.dailyForecast[4].symbolName
        
        return dailysymbol ?? "cloud"
    }
    
    //4일차 날짜
    var dailydate4: String {
        let dailydate =
        weather?.dailyForecast[4].date.formatted(.dateTime.month().day())
        
        return dailydate ?? "today"
    }
    
    //4일차 Description
    var dailydescription4: String {
        let dailydescription =
        weather?.dailyForecast[4].condition.description
        
        return dailydescription ?? "none"
    }

//5일차
    //5일차 최고 기온
    var dailyhightemp5: Double {
        let dailyhightemp =
        weather?.dailyForecast[5].highTemperature.value
        
        return dailyhightemp ?? 0.0
    }
    
    //5일차 최저 기온
    var dailylowtemp5: Double {
        let dailylowtemp =
        weather?.dailyForecast[5].lowTemperature.value
        
        return dailylowtemp ?? 0.0
    }
    
    //5일차 날씨 symbol
    var dailysymbol5: String {
        let dailysymbol =
        weather?.dailyForecast[5].symbolName
        
        return dailysymbol ?? "cloud"
    }
    
    //5일차 날짜
    var dailydate5: String {
        let dailydate =
        weather?.dailyForecast[5].date.formatted(.dateTime.month().day())
        
        return dailydate ?? "today"
    }
    
    //5일차 Description
    var dailydescription5: String {
        let dailydescription =
        weather?.dailyForecast[5].condition.description
        
        return dailydescription ?? "none"
    }
    
//6일차
    //6일차 최고 기온
    var dailyhightemp6: Double {
        let dailyhightemp =
        weather?.dailyForecast[6].highTemperature.value
        
        return dailyhightemp ?? 0.0
    }
    
    //6일차 최저 기온
    var dailylowtemp6: Double {
        let dailylowtemp =
        weather?.dailyForecast[6].lowTemperature.value
        
        return dailylowtemp ?? 0.0
    }
    
    //6일차 날씨 symbol
    var dailysymbol6: String {
        let dailysymbol =
        weather?.dailyForecast[6].symbolName
        
        return dailysymbol ?? "cloud"
    }
    
    //6일차 날짜
    var dailydate6: String {
        let dailydate =
        weather?.dailyForecast[6].date.formatted(.dateTime.month().day())
        
        return dailydate ?? "today"
    }
    
    //6일차 Description
    var dailydescription6: String {
        let dailydescription =
        weather?.dailyForecast[6].condition.description
        
        return dailydescription ?? "none"
    }
    
//7일차
    //7일차 최고 기온
    var dailyhightemp7: Double {
        let dailyhightemp =
        weather?.dailyForecast[7].highTemperature.value
        
        return dailyhightemp ?? 0.0
    }
    
    //7일차 최저 기온
    var dailylowtemp7: Double {
        let dailylowtemp =
        weather?.dailyForecast[7].lowTemperature.value
        
        return dailylowtemp ?? 0.0
    }
    
    //7일차 날씨 symbol
    var dailysymbol7: String {
        let dailysymbol =
        weather?.dailyForecast[7].symbolName
        
        return dailysymbol ?? "cloud"
    }
    
    //7일차 날짜
    var dailydate7: String {
        let dailydate =
        weather?.dailyForecast[7].date.formatted(.dateTime.month().day())
        
        return dailydate ?? "today"
    }
    
    //7일차 Description
    var dailydescription7: String {
        let dailydescription =
        weather?.dailyForecast[7].condition.description
        
        return dailydescription ?? "none"
    }

}
 
