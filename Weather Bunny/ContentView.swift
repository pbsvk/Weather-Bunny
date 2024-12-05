import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @AppStorage("welcomeShown") private var welcomeShown: Bool = false // Persist welcome state
    @State private var showSplash = true // Control splash visibility

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreen()
            } else {
                VStack {
                    if !welcomeShown {
                        WelcomeView() // Ensure `currentView.center` is valid
                            .environmentObject(locationManager)
                            .onAppear {
                                if locationManager.location != nil {
                                    welcomeShown = true
                                }
                            }
                    } else if let location = locationManager.location {
                        if let weatherData = weather { // Safe unwrapping of `weather`
                            SwiftNavigationView(activeView: currentView.center, weather: weatherData)
                        } else {
                            LoadingView()
                                .task {
                                    do {
                                        weather = try await weatherManager.getCurrentWeather(
                                            latitude: location.latitude,
                                            longitude: location.longitude
                                        )
                                    } catch {
                                        print("Error fetching weather: \(error)")
                                    }
                                }
                        }
                    } else {
                        // Handle fallback in case location is unavailable
                        WelcomeView()
                            .environmentObject(locationManager)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            // Splash screen transition
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
