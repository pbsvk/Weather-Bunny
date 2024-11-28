//
//  ContentView.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 11/23/24.
//

import SwiftUI

// Your imports remain the same

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @AppStorage("welcomeShown") private var welcomeShown: Bool = false  // Use AppStorage to persist state
    @State private var showSplash = true // Add splash state

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreen()
            } else {
                VStack {
                    if !welcomeShown {
                        // Display WelcomeView only if it hasn't been dismissed
                        WelcomeView()
                            .environmentObject(locationManager)
                            .onAppear {
                                if locationManager.location != nil {
                                    welcomeShown = true  // Set the flag when location is fetched
                                }
                            }
                    } else if let location = locationManager.location {
                        if let weather = weather {
                            WeatherView(weather: weather)
                        } else {
                            // Load and fetch weather data
                            LoadingView()
                                .task {
                                    do {
                                        weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                    } catch {
                                        print("Error getting weather: \(error)")
                                    }
                                }
                        }
                    } else {
                        // Fallback to WelcomeView in case location is not found again
                        WelcomeView()
                            .environmentObject(locationManager)
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut) {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

// End of file. No additional code.
