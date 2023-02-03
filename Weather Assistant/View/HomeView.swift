import SwiftUI
import WeatherKit
import SafariServices

struct HomeView: View {
    
    @ObservedObject var weatherKitManager = WeatherKitManager()
    @StateObject var locationDataManager = LocationDataManager()
    @State var showSafari = false
    @State var urlString = "https://weatherkit.apple.com/legal-attribution.html"
    
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
                        Text("Weather Assistant")
                            .bold()
                            .font(.title)
                            .foregroundColor(.white)
                        
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day()))")
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                Image(systemName: weatherKitManager.todaysymbol)
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                                Text(weatherKitManager.todaydescription)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            Spacer()
                            
                            Text(weatherKitManager.temp.roundDouble() + "°")
                                .font(.system(size: 70))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        Spacer()
                            .frame(height: 1)
                        
                        VStack {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Weather now")
                                    .bold()
                                    .padding(.bottom)
                                
                                ScrollView(.vertical, showsIndicators: true) {
                                    
                                    HStack {
                                            WeatherRow(logo: "thermometer", name: "Min temp", value: (weatherKitManager.lowtemp.roundDouble() + ("°")))//value에 일 최저온도
                                            Spacer()
                                            WeatherRow(logo: "thermometer", name: "Max temp", value: (weatherKitManager.hightemp.roundDouble() + "°"))
                                            Spacer()//value에 일 최고온도
                                        }.lineLimit(1)
                                    
                                    HStack {
                                            WeatherRow(logo: "sun.max.fill", name: "UV level", value: "\(weatherKitManager.uv)")//value에 자외선
                                            Spacer()
                                            WeatherRow(logo: "wind", name: "Wind", value: (weatherKitManager.windspeed .roundDouble() + "m/s"))//value에 풍속
                                            Spacer()
                                        }.lineLimit(1)
                                    
                                    HStack{
                                        WeatherRow(logo: "humidity", name: "Humidity", value: "\(weatherKitManager.humid.roundDouble())%")//value에 습도 변경하기
                                        Spacer()
                                        WeatherRow(logo: "thermometer.sun", name: "WindChill ", value: (weatherKitManager.realtemp.roundDouble() + ("°")))
                                        Spacer()
                                    }.lineLimit(1)

                                    HStack {
                                        WeatherDoubleRow(logo: "sunrise", name: "Sunrise & Sunset", value: (weatherKitManager.risesun), secondvalue: (weatherKitManager.setsun))
                                        Spacer()
                                    }.lineLimit(1)
                                    HStack {
                                        WeatherDoubleRow(logo: "moon", name: "Moonrise & moonset", value: (weatherKitManager.risemoon), secondvalue: (weatherKitManager.setmoon))
                                        Spacer()
                                    }.lineLimit(1)

                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .padding(.bottom, 20)
                            .foregroundColor(.white)
                            .background(Color(hue: 0.6, saturation: 0.7, brightness: 0.3, opacity: 0.2))
                            .cornerRadius(20, corners: [.allCorners])
                        }
                        //add
                        VStack(alignment: .center){
                            
                                Text("Powered by \(Image(systemName: "applelogo"))Weather")
                                    .foregroundColor(.white)
                                Button(action: {
                                
                                    self.urlString = "https://weatherkit.apple.com/legal-attribution.html"
                                
                                    self.showSafari = true
                                }) {
                                    Text("Other data sources")
                                        .foregroundColor(.gray)
                                }
                                .sheet(isPresented: $showSafari) {
                                    SafariView(url:URL(string: self.urlString)!)
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            //.preferredColorScheme(.light)
            .task {
                await weatherKitManager.getWeather(latitude: locationDataManager.latitude, longitude: locationDataManager.longitude)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
    }
}

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}

