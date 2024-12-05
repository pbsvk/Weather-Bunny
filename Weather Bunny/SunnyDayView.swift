import SwiftUI
import CoreLocation

struct SunnyDayView: View {
    @State var activeView: currentView
    @State private var selectedCity = "Select a City"
    @State private var searchText = ""
    @State private var isExpanded = false
    @State private var location: CLLocationCoordinate2D?
    @State private var errorMessage: String?
    @FocusState private var isTextFieldFocused: Bool
    @State private var showWeatherSheet = false // Add this line
    @StateObject private var weatherManager = WeatherManager() // Add this line
    @State private var weather: ResponseBody? // Add this line
    @State private var isLoading = false
    var body: some View {
                    ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack(spacing: 5) {
                    ScrollView{
                        Spacer()
                    Text("Hello, Sunshine! ☀\u{fe0f}")
                        .bold()
                        .font(.title)
                        .foregroundColor(Color.black)
                    
                    
                    Image("710E8EC2-2633-479C-A90D-3B75A410059C 2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 300)
                        .clipShape(Circle()) // Optional: Make it a circle
                        .overlay(
                            Circle()
                                .stroke(Color.pink.opacity(0.5), lineWidth: 20) // Adds fading edges
                                .blur(radius: 15)
                        )
                        .shadow(color: Color.pink.opacity(0.3), radius: 20, x: 0, y: 0)
                    
                    
                    VStack(spacing: 5) {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                isExpanded.toggle()
                            }
                        }) {
                            HStack {
                                Text(selectedCity)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            }
                            .padding()
                            .background(gradientBackground())
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                        
                        if isExpanded {
                            VStack(spacing: 10) {
                                TextField("Enter city name...", text: $searchText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .background(Color.white.opacity(0.8).cornerRadius(10))
                                    .focused($isTextFieldFocused)
                                
                                Button(action: {
                                    isTextFieldFocused = false
                                    geocodeCity(city: searchText)
                                    withAnimation(.easeInOut) {
                                        isExpanded = false
                                    }
                                }) {
                                    Text("Find Location")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.blue, .teal]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .cornerRadius(12)
                                        .shadow(color: .blue.opacity(0.4), radius: 5, x: 0, y: 2)
                                }
                                
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 2)
                            .transition(.scale(scale: 0.95).combined(with: .opacity))
                        }
                    }
                    .padding()
                    
                    // Display Results
                    if let location = location {
                        VStack {
                            Text("Latitude: \(location.latitude)")
                            Text("Longitude: \(location.longitude)")
                            // Add this button
                            Button(action: {
                                isLoading = true // Set loading to true
                                Task {
                                    await fetchWeather(lat: location.latitude, lon: location.longitude)
                                    isLoading = false // Set loading to false when done
                                }
                            }) {
                                Text("Show Weather")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.blue, .teal]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(12)
                                    .shadow(color: .blue.opacity(0.4), radius: 5, x: 0, y: 2)
                            }.disabled(isLoading) // Disable button while loading
                        }
                        
                        .padding()
                        .background(Color.white.opacity(0.9).cornerRadius(12))
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                    
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    }
                    Spacer()
                }
                .padding()
                .padding(.top)
            }
            .onTapGesture {
                isTextFieldFocused = false
            }
            .sheet(isPresented: $showWeatherSheet) { // Add this sheet
                if let weather = weather {
                    WeatherView(activeView: .center, weather: weather)
                }
            }
        }
}

    private func geocodeCity(city: String) {
        let trimmedCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedCity.isEmpty else {
            errorMessage = "Please enter a valid city name."
            return
        }

        let geocoder = CLGeocoder()
        DispatchQueue.global().async {
            geocoder.geocodeAddressString(trimmedCity) { placemarks, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.errorMessage = "Failed to find location: \(error.localizedDescription)"
                        self.location = nil
                    } else if let placemark = placemarks?.first,
                              let location = placemark.location {
                        self.location = location.coordinate
                        self.selectedCity = trimmedCity
                        self.errorMessage = nil
                    } else {
                        self.errorMessage = "Location not found for city: \(trimmedCity)"
                        self.location = nil
                    }
                }
            }
        }
    }

    private func gradientBackground() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.blue, .cyan]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
// Add this new function
    private func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) async {
        do {
            let fetchedWeather = try await weatherManager.getCurrentWeather(latitude: lat, longitude: lon)
            weather = fetchedWeather
            showWeatherSheet = true
        } catch {
            errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
        }
    }
}

struct SunnyDayView_Previews: PreviewProvider {
    static var previews: some View {
        SunnyDayView(activeView: currentView.center)
    }
}
