//
//  widgetExtension.swift
//  weather_widgetExtension
//
//  Created by 안병욱의 mac on 2023/01/30.
//

import Foundation
import SwiftUI

// Extension for rounded Double to 0 decimals
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}


