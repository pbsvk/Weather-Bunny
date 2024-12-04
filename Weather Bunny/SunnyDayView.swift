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
        @State var activeView: currentView

        var body: some View {
            ZStack {
                // Background
                LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
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
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)

        }
    }

struct SunnyDayView_Previews: PreviewProvider {
    static var previews: some View {
        SunnyDayView(activeView: currentView.center)
    }
}

