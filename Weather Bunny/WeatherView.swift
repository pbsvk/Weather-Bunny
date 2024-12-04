//
//  WeatherView.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 11/24/24.
//

import SwiftUI

// Your imports remain the same

struct WeatherView: View {
    @State private var animate = false
    @State var activeView: currentView
    var weather: ResponseBody
    
    var body: some View {
        // Example: Determine if it's daytime based on sunrise and sunset
        let isDaytime = determineDaytime(currentTime: weather.dt, sunrise: weather.sys.sunrise, sunset: weather.sys.sunset)
        let condition = WeatherCondition(temperature: weather.main.temp, isDaytime: isDaytime)

        GeometryReader { geometry in
            ZStack {
                // Added background dynamic gradient
                LinearGradient(gradient: Gradient(colors: condition.gradientColors()), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                ScrollView { // ScrollView remains the same
                    VStack(spacing: 10) {
                        Spacer()
                        Spacer()
                        Spacer()

                        // Display city name
                        HStack (spacing: 8){
                            Image(systemName: "paperplane.fill")
                            Text(weather.name)
                                    .font(.system(size: geometry.size.width * 0.07))
                                    .fontWeight(.bold)
                                    

                        }.foregroundColor(.white)

                        Image(systemName: WeatherIcons.fromWeatherResponse(weather: weather.weather).iconName())
                                .resizable()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.15)
                                .foregroundStyle(.white)
                        
                       
                        Text(weather.weather.first?.main ?? "N/A")
                            .font(.system(size: geometry.size.width * 0.05))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                       
                        // Display temperature
                        Text(weather.main.temp.roundDouble() + "°")
                            .font(.system(size: geometry.size.width * 0.1))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        HStack {
                            
                            Text("Feels like :")
                                .font(.system(size: geometry.size.width * 0.05))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Text(weather.main.feelsLike.roundDouble() + "°")
                                .font(.system(size: geometry.size.width * 0.05))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        
                        ZStack {
                            // Background image using enum
                            Image(condition.backgroundImageName())
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(condition.gradientColors().last!.opacity(0.5), lineWidth: 10)
                                        .blur(radius: 15)
                                )
                                .shadow(color: condition.gradientColors().last!.opacity(0.3), radius: 20, x: 0, y: 0)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                                        self.animate.toggle()
                                    }
                                }

                            // Animating Circle
                            Circle()
                                .stroke(condition.gradientColors().first!.opacity(0.99), lineWidth: 10)
                                .scaleEffect(animate ? 1.0 : 0.5)
                                .opacity(animate ? 0 : 1)
                                .animation(Animation.easeOut(duration: 1.5).repeatForever(autoreverses: false), value: animate)
                        }
                      
                        Text("Bunny says the weather report is ")
                            .font(.system(size: geometry.size.width * 0.05))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        HStack {
                            Image(systemName: "newspaper")
                                .foregroundColor(.black)
                            Text(weather.weather.first?.description.capitalized ?? "N/A")
                                .font(.system(size: geometry.size.width * 0.05))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        HStack {
                            Image(systemName: "sunrise.fill")
                                .foregroundStyle(.yellow)
                                .frame(width: 20, height: 20)
                                .padding()
                                .background(Color(.black))
                                .cornerRadius(50)
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Sunrise")
                                    .font(.caption)
                                
                                Text(formatSunTime(weather.sys.sunrise))
                                    .bold()
                                    .font(.title3)
                            }
                            
                            Spacer()
                            Image(systemName: "sunset.fill")
                                .foregroundStyle(.yellow)
                                .frame(width: 20, height: 20)
                                .padding()
                                .background(Color(.black))
                                .cornerRadius(50)
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Sunset")
                                    .font(.caption)
                                
                                Text(formatSunTime(weather.sys.sunset))
                                    .bold()
                                    .font(.title3)
                            }
                            
                        }
                        .foregroundColor(.black)
                        .padding()

                        
                        // Display additional weather details
                        VStack(alignment: .leading, spacing: 20) { // Weekly forecast blocks
                            Text("Today's Weather")
                                .bold()
                                .padding(.bottom)
                                .foregroundColor(.black)

                            HStack {
                                Image(systemName: "thermometer")
                                    .foregroundStyle(.blue)
                                    .frame(width: 20, height: 20)
                                    .padding()
                                    .background(Color(.black))
                                    .cornerRadius(50)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Min-Temp")
                                        .font(.caption)
                                    
                                    Text("\(weather.main.tempMin.roundDouble())°")
                                        .bold()
                                        .font(.title3)
                                }
                                
                                Spacer()
                                Image(systemName: "thermometer")
                                    .foregroundStyle(.red)
                                    .frame(width: 20, height: 20)
                                    .padding()
                                    .background(Color(.black))
                                    .cornerRadius(50)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Max-Temp")
                                        .font(.caption)
                                    
                                    Text("\(weather.main.tempMax.roundDouble())°")
                                        .bold()
                                        .font(.title3)
                                }
                                
                            }

                            HStack {
                                WeatherRow(logo: "cloud", name: "Cloudiness", value: "\(weather.clouds.all)%")
                               
                                Spacer()
                                WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                            }

                            HStack {
                                WeatherRow(logo: "barometer", name: "Pressure", value: "\(weather.main.pressure) hPa")
                                Spacer()
                            }
                            WeatherRow(logo: "newspaper", name: "Weather Description", value: weather.weather.first?.description.capitalized ?? "N/A")
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 20)
                        .foregroundColor(.black)
                        .cornerRadius(30)
                    }
                }.scrollIndicators(.hidden)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
    }

    // Helper function to determine daytime
    private func determineDaytime(currentTime: Int, sunrise: Int, sunset: Int) -> Bool {
        return (currentTime >= sunrise && currentTime < sunset)
    }

    // Helper function for time formatting
    private func formatSunTime(_ time: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
#Preview {
    WeatherView(activeView: currentView.center, weather: previewWeather)
}
