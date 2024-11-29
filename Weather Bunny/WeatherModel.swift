//
//  WeatherModel.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 11/29/24.
//

import Foundation
import SwiftUI

// Expanded enum to handle more specific weather conditions with day/night consideration
enum WeatherCondition {
    case freezingNight, freezingDay, veryColdNight, veryColdDay, coldNight, coldDay, coolNight, coolDay, mildNight, mildDay, warmNight, warmDay, hotNight, hotDay, veryHotNight, veryHotDay

    init(temperature: Double, isDaytime: Bool) {
        switch (temperature, isDaytime) {
             case (..<0, true):
                 self = .freezingDay
             case (..<0, false):
                 self = .freezingNight
             case (0..<5, true):
                 self = .veryColdDay
             case (0..<5, false):
                 self = .veryColdNight
             case (5..<10, true):
                 self = .coldDay
             case (5..<10, false):
                 self = .coldNight
             case (10..<15, true):
                 self = .coolDay
             case (10..<15, false):
                 self = .coolNight
             case (15..<25, true):
                 self = .mildDay
             case (15..<25, false):
                 self = .mildNight
             case (25..<30, true):
                 self = .warmDay
             case (25..<30, false):
                 self = .warmNight
             case (30..<35, true):
                 self = .hotDay
             case (30..<35, false):
                 self = .hotNight
             case (35..., true):
                 self = .veryHotDay
             case (35..., false):
                 self = .veryHotNight
        case (_, _):
            self = .mildDay
        }
         }

    func iconName() -> String {
        switch self {
        case .freezingNight, .freezingDay:
            return "snow.fill"
        case .veryColdNight, .veryColdDay:
            return "cloud.snow.fill"
        case .coldNight, .coldDay:
            return "cloud.drizzle.fill"
        case .coolNight, .coolDay:
            return "cloud.fill"
        case .mildNight, .mildDay:
            return "cloud.sun"
        case .warmNight, .warmDay:
            return "sun.max.fill"
        case .hotNight, .hotDay:
            return "sun.dust"
        case .veryHotNight, .veryHotDay:
            return "sun.haze"
        }
    }

    func backgroundImageName() -> String {
        switch self {
        case .freezingNight:
            return "File 5"
        case .freezingDay:
            return "File 6"
        case .veryColdNight:
            return "File 22"
        case .veryColdDay:
            return "File 3"
        case .coldNight:
            return "File 13"
        case .coldDay:
            return "File 7"
        case .coolNight:
            return "File 8"
        case .coolDay:
            return "File 12"
        case .mildNight:
            return "File 10"
        case .mildDay:
            return "File 11"
        case .warmNight:
            return "File 5"
        case .warmDay:
            return "File 1"
        case .hotNight:
            return "File 9"
        case .hotDay:
            return "File 4"
        case .veryHotNight:
            return "3CBF7E91-347B-4939-8F80-D5C579B51225"
        case .veryHotDay:
            return "8260D15F-DDE8-4E75-866E-6F180453176E"
        }
    }

    func gradientColors() -> [Color] {
        switch self {
        case .freezingNight, .freezingDay:
            return [.black, .white] // Adjusted colors
        case .veryColdNight, .veryColdDay:
            return [.gray, .white]
        case .coldNight, .coldDay:
            return [.teal, .white]
        case .coolNight, .coolDay:
            return [.green, .white] // Adjusted colors
        case .mildNight, .mildDay:
            return [.gray, .white]
        case .warmNight, .warmDay:
            return [.orange, .yellow]
        case .hotNight, .hotDay:
            return [.red, .orange]
        case .veryHotNight, .veryHotDay:
            return [.purple, .red]
        }
    }
}

// Ensure that any logic determining day or night is integrated and functioning properly as intended.
