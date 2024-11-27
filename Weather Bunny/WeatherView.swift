//
//  WeatherView.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 11/24/24.
//

import SwiftUI

struct WeatherView: View {
    @State private var animate = false
    var weather: ResponseBody
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    // City name
                    Text(weather.name)
                        .font(.system(size: geometry.size.width * 0.07)) // Dynamic font size
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Weather icon
                    Image(systemName: "moon.stars")
                        .resizable()
                        .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                        .foregroundColor(.yellow)
                    
                    // Temperature
                    Text(weather.main.feelsLike.roundDouble() + "°")
                        .font(.system(size: geometry.size.width * 0.1)) // Dynamic font size
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    ZStack {
                        // Background image
                        Image("E4E23AFC-12E3-45FA-80CB-53EE50B58844 2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.blue.opacity(0.5), lineWidth: 10)
                                    .blur(radius: 15)
                            )
                            .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 0)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                                    self.animate.toggle()
                                }
                            }
                        
                        // Animating Circle
                        Circle()
                            .stroke(Color.blue.opacity(0.9), lineWidth: 2)
                            .scaleEffect(animate ? 1.5 : 1)
                            .opacity(animate ? 0 : 1)
                            .animation(Animation.easeOut(duration: 1.5).repeatForever(autoreverses: false), value: animate)
                    }
                    
                    // Weekly forecast
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Weather now")
                            .bold()
                            .padding(.bottom)
                        
                        HStack {
                            WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + "°"))
                            Spacer()
                            WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                        }
                        
                        HStack {
                            WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                            Spacer()
                            WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.245))
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                }
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            }
        }
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}
