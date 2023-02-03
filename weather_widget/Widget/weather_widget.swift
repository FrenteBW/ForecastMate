//
//  weather_widget.swift
//  weather_widget
//
//  Created by 안병욱의 mac on 2023/01/20.
//

import WidgetKit
import SwiftUI
import WeatherKit
import CoreLocation

struct Provider: TimelineProvider {
        
    @StateObject var widgetlocationDataManager = widgetLocationDataManager()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), dailycontidion: " ", todaysymbol: " ", hightemp: 0.0, lowtemp: 0.0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), dailycontidion: " ", todaysymbol: " ", hightemp: 0.0, lowtemp: 0.0)
        completion(entry)
    }
        
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let nextUpdate = Date().addingTimeInterval(28800)

            let sampleLocation = CLLocation(latitude: widgetlocationDataManager
                .latitude, longitude: widgetlocationDataManager.longitude)
                
            let weather = try await WeatherService.shared.weather(for: sampleLocation)
            let entry = SimpleEntry(date: .now, dailycontidion: weather.dailyForecast[0].condition.description, todaysymbol: weather.dailyForecast[0].symbolName.description, hightemp: weather.dailyForecast[0].highTemperature.value, lowtemp: weather.dailyForecast[0].lowTemperature.value)
            
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
            }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let dailycontidion: String
    let todaysymbol: String
    let hightemp: Double
    let lowtemp: Double
}

struct weather_widgetEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    
    var entry: Provider.Entry

    var body: some View {

        switch widgetFamily {
            
        case .systemSmall:
            ZStack {
                if entry.todaysymbol == "sun.max" {
                    LinearGradient(gradient: Gradient(colors: [Color("topcolor"), Color("bottomcolor")]),
                                   startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                }
                else
                {
                    LinearGradient(gradient: Gradient(colors: [Color("graytopcolor"), Color("graybottomcolor")]),
                                   startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                }//작은 상자 뷰 내용
                VStack{
                    Spacer()
                    Image(systemName: entry.todaysymbol)
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                    Spacer()
                    Text("\(entry.dailycontidion)")
                        .bold()
                        .font(.title3)
                        .foregroundColor(.white)
                    Text("\(entry.lowtemp.roundDouble())° ~ \(entry.hightemp.roundDouble())°")
                        .foregroundColor(.white)
                    Spacer()
                    //add
                    VStack(alignment: .trailing){
                        Text("\(Image(systemName: "applelogo"))Weather")
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                }
            }
        case .accessoryInline: //Lock screen 뷰 내용

            if entry.todaysymbol == "cloud.drizzle" || entry.todaysymbol == "cloud.rain" || entry.todaysymbol == "cloud.heavyrain" || entry.todaysymbol == "cloud.hail" || entry.todaysymbol == "cloud.snow" || entry.todaysymbol == "cloud.sleet" || entry.todaysymbol == "cloud.sun.rain" || entry.todaysymbol == "snowflake"
            {
                Text("Bring your umbrella☔️")
            }

            else if entry.lowtemp <= -10 {
                Text("It's cold outside🥶")
            }
            else if entry.hightemp >= 35 {
                Text("It's hot outside🥵")
            }
            else
            {
                Text("")
            }

            
        default:
            Text("unknown")
        }
    }
}

//위젯 사용 시 설명 + 위젯 종류 설정
struct weather_widget: Widget {
    let kind: String = "weather_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            weather_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("Daily weather cast")
        .description("You can see the Daily weather cast")
        .supportedFamilies([.systemSmall, .accessoryInline])
    }
}

//프리뷰
struct weather_widget_Previews: PreviewProvider {
    static var previews: some View {
        weather_widgetEntryView(entry: SimpleEntry(date: Date(), dailycontidion: " ", todaysymbol: " ", hightemp: 0.0, lowtemp: 0.0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
