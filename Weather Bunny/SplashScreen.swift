//
//  SplashScreen.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 11/28/24.
//

import SwiftUI
// Your imports remain the same

struct SplashScreen: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            // Dynamic gradient state change to simulate day to night
            LinearGradient(gradient: Gradient(colors: animate ? [Color.black, Color.blue] : [Color.blue, Color.yellow]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 2), value: animate)  // Adjusted duration

            VStack(spacing: 40) {
                
                ZStack {
                    // Sun moving down
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.yellow)
                        .offset(y: animate ? UIScreen.main.bounds.height / 3 : 0)
                        .opacity(animate ? 0 : 1)
                        .animation(.easeInOut(duration: 2), value: animate)  // Extended duration
                    
                    // Moon rising up with controlled end point
                    Image(systemName: "moon.stars.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .offset(y: animate ? -UIScreen.main.bounds.height / 6 : UIScreen.main.bounds.height / 2)
                        .opacity(animate ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 2).delay(0.4), value: animate)  // Extended duration
                        .shadow(radius: 10)
                }
                
                /*
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
                 
                 */
                
                // Custom photo at the bottom
                Image("E8997FAF-537B-4ED7-B7CA-74F9CDDB2F11 2 2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding(20)
                    .overlay(
                        Circle()
                            .stroke(Color.pink.opacity(0.5), lineWidth: 20) // Adds fading edges
                            .blur(radius: 20)
                    )
                    .shadow(color: Color.pink.opacity(0.6), radius: 20, x: 0, y: 0)
                
                
                Text("Let bunny fetch the weather data for you... ✨")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                animate = true
            }
        }
    }
}

#Preview {
    SplashScreen()
}

// End of file. No additional code.
