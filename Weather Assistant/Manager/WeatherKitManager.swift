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
    
    //추가(6/13)
    struct HourlyForecast {
        let hour: String
        let symbol: String
        let temperature: Double
    }
    
    var hourlyForecasts: [HourlyForecast] {
        var forecasts: [HourlyForecast] = []
        
        for i in 2...13 {
            let index = hour(i: i)
            let hour = weather?.hourlyForecast[index].date.formatted(.dateTime.hour()) ?? "0"
            let symbol = weather?.hourlyForecast[index].symbolName ?? "0"
            let temperature = weather?.hourlyForecast[index].temperature.converted(to: .celsius).value ?? 0.0
            
            let forecast = HourlyForecast(hour: hour, symbol: symbol, temperature: temperature)
            forecasts.append(forecast)
        }
        
        return forecasts
    }
    
// MARK:  DailyWeatherView에서 DailyWeather components
    
    struct DailyForecast {
        let highTemperature: Double
        let lowTemperature: Double
        let symbol: String
        let date: String
        let description: String
    }

    var dailyForecasts: [DailyForecast] {
        var forecasts: [DailyForecast] = []
        
        for i in 1...7 {
            let highTemperature = weather?.dailyForecast[i].highTemperature.value ?? 0.0
            let lowTemperature = weather?.dailyForecast[i].lowTemperature.value ?? 0.0
            let symbol = weather?.dailyForecast[i].symbolName ?? "cloud"
            let date = weather?.dailyForecast[i].date.formatted(.dateTime.month().day()) ?? "today"
            let description = weather?.dailyForecast[i].condition.description ?? "none"
            
            let forecast = DailyForecast(highTemperature: highTemperature, lowTemperature: lowTemperature, symbol: symbol, date: date, description: description)
            forecasts.append(forecast)
        }
        
        return forecasts
    }

}
