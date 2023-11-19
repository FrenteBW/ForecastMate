# ForecastMate

# - Introduction

*주요 기능*
- Apple WeatherKit 을 이용해 보다 정밀하고 정확한 날씨 정보를 제공합니다. (Powered by apple weather)

- 홈 화면 위젯을 통해 비, 눈 예보가 있을 때, 기온이 매우 높거나 추울 때 날씨 정보를 자동으로 업데이트하여 제공합니다.

- 직관적이고 한눈에 잘 들어오는 UI 구성으로 누구나 쉽게 앱을 활용할 수 있습니다.

*필수 권한*
- 사용자의 위치를 기반으로 한 날씨 정보 제공을 위해 위치 정보 접근을 허용해야 합니다.

- 위젯을 통해 날씨 정보를 제공받으려면 위젯이 사용자의 위치를 사용하도록 허용해야 합니다.

*데이터 출처*
- Apple의 Apple weather kit 을 기반으로 제작되었습니다. 앱 첫 번째 화면 하단에서 데이터 소스에 관한 정보를 확인할 수 있습니다.

# - Video & Images

<img width="1134" alt="%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202023-03-28%20%EC%98%A4%ED%9B%84%205 14 56" src="https://user-images.githubusercontent.com/88021794/229045403-04bcbd5b-00c9-481f-a0ee-b567d724ffb6.png">

# - 핵심코드
    //우산을 챙겨야 하거나, 기온이 많이 높거나 낮을 때만 위젯엣서 이를 표시
    struct weather_widgetEntryView : View {
    
    var entry: Provider.Entry

    var body: some View {
            //우산을 챙겨야 할 떄
            if entry.todaysymbol == "cloud.drizzle" || entry.todaysymbol == "cloud.rain" || entry.todaysymbol == "cloud.heavyrain" || entry.todaysymbol == "cloud.hail" || entry.todaysymbol == "cloud.snow" || entry.todaysymbol == "snowflake" 
            {
                Text("Bring your umbrella☔️")
            }
            //기온이 매우 낮을 때
            else if entry.lowtemp <= -10 {
                Text("It's cold outside🥶")
            }
            //기온이 매우 높을 때
            else if entry.hightemp >= 35 {
                Text("It's hot outside🥵")
            }
            else
            {
                Text("")
            }
    }
}


# - Appstore link

https://apps.apple.com/kr/app/forecastmate/id1669165264

# - Update

2023.06.13 : 디자인 수정 및 코드 리팩토링

# - Contact 

📧 : abw2619@naver.com
