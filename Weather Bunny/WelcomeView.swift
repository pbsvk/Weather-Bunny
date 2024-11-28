//
//  WelcomeView.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 11/24/24.
//

import SwiftUI
import CoreLocationUI

// Your imports remain the same

// Your imports remain the same

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager

    // Use @AppStorage to track welcome screen dismissal
    @AppStorage("welcomeShown") private var welcomeShown: Bool = false

    var body: some View {
        ZStack {
            Color.pink.opacity(0.6) // Light pink background
                .ignoresSafeArea() // Extend to cover the safe area
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Hello, Sunshine! ☀\u{fe0f}")
                    .bold()
                    .font(.title)

                Text("Let bunny know where you are so that he can show your local weather 🌸✨")
                    .padding()

                Image("710E8EC2-2633-479C-A90D-3B75A410059C 2")
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

                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                    // Update welcomeShown when location is set, to ensure View transition
                    if locationManager.location != nil {
                        welcomeShown = true
                    }
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)

            }
            .multilineTextAlignment(.center)
            .padding()
        }

    }
}

#Preview {
    WelcomeView()
}
// End of file. No additional code.

// End of file. No additional code.
