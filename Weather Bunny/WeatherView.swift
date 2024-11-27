//
//  WeatherView.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 11/24/24.
//

import SwiftUI

// Your imports remain the same

struct WeatherView: View {
    @State private var animate = false // Add this state variable

    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()
                // City name
                Text("New York City")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                // Weather icon
                Image(systemName: "moon.stars")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.yellow)
                    

                // Temperature
                Text("26°C")
                    .font(.system(size: 40))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                ZStack {
                                    Image("E4E23AFC-12E3-45FA-80CB-53EE50B58844 2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300, height: 400)
                                        .clipShape(Circle()) // Optional: Make it a circle
                                        .overlay(
                                            Circle()
                                                .stroke(Color.blue.opacity(0.5), lineWidth: 20) // Adds fading edges
                                                .blur(radius: 15)
                                        )
                                        .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 0)
                                        .onAppear { // Trigger the animation when the view appears
                                            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                                                self.animate.toggle()
                                            }
                                        }

                                    Circle() // Animate this circle
                                        .stroke(Color.blue.opacity(0.9), lineWidth: 2)
                                        .scaleEffect(animate ? 1.5 : 1)
                                        .opacity(animate ? 0 : 1)
                                        .animation(Animation.easeOut(duration: 1.5).repeatForever(autoreverses: false), value: animate)
              
                                }

                Spacer()


                // Weekly forecast
                HStack(spacing: 20) {
                    ForEach(0..<5) { _ in
                        VStack {
                            Text("Mon")
                                .foregroundColor(.white)
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(.yellow)
                            Text("26°C")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    WeatherView()
}
