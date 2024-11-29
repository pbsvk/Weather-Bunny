//
//  SunnyDayView.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 11/25/24.
//

import SwiftUI

struct SunnyDayView: View {
        @State private var animate = false // Add this state variable
        @State private var scale: CGFloat = 1.0 // State variable for scaling
        @State private var rotation: Angle = .zero // State variable for rotation
        
        var body: some View {
            ZStack {
                // Background
                LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer()
                    // City name
                    Text("New York City")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    // Weather icon
                    Image(systemName: "sun.max.fill")
                        .foregroundStyle(.yellow)
                        .opacity(9.9)
                        .font(.largeTitle)
                        .scaleEffect(scale)
                        .rotationEffect(rotation) // Add rotation effect
                        .onAppear {
                            withAnimation( // Use withAnimation to animate scaling
                                Animation.easeInOut(duration: 3.0) // Define the scaling animation parameters
                                    .repeatForever(autoreverses: true) // Repeat the scaling animation forever with autoreverse
                            ) {
                                scale = 2.0 // Set the target scale
                            }

                            withAnimation( // Use withAnimation to animate rotation
                                Animation.linear(duration: 2.0) // Define the rotation animation parameters
                                    .repeatForever(autoreverses: false) // Repeat the rotation animation forever without autoreverse
                            ) {
                                rotation = .degrees(360) // Rotate 360 degrees continuously
                            }
                        }
                        

                    // Temperature
                    Text("26°C")
                        .font(.system(size: 40))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    ZStack {
                                        Image("CE657A9A-DBF3-44DD-B785-61BD3CA342C4 2")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 300, height: 400)
                                            .clipShape(Circle()) // Optional: Make it a circle
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.pink.opacity(0.5), lineWidth: 20) // Adds fading edges
                                                    .blur(radius: 15)
                                            )
                                            .shadow(color: Color.pink.opacity(0.3), radius: 20, x: 0, y: 0)
                                            .onAppear { // Trigger the animation when the view appears
                                                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                                                    self.animate.toggle()
                                                }
                                            }

                                        Circle() // Animate this circle
                            .stroke(Color.yellow.opacity(0.9), lineWidth: 2)
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
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
        }
    }

#Preview {
    SunnyDayView()
}
