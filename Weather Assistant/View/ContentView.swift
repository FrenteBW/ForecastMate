//
//  ContentView.swift
//  Weather Assistant
//
//  Created by 안병욱의 mac on 2022/11/29.
//

import SwiftUI

 struct ContentView: View {
     var body: some View {
         TabView {
             HomeView()
                 .tabItem {
                     Label("Current Weather", systemImage: "cloud.sun")
                 }
             
             DailyWeatherView()
                 .tabItem {
                     Label("Future Weather", systemImage: "calendar")
                 }
         }
         .accentColor(.white)
     }
 }
