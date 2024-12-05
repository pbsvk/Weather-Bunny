//
//  RightView.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 12/4/24.
//

import SwiftUI

// Your imports remain the same

// Your imports remain the same

struct RightView: View {
    @State var activeView: currentView
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                Color.pink.opacity(0.6) // Light pink background
                    .ignoresSafeArea() // Extend to cover the safe area
                    .edgesIgnoringSafeArea(.all)
            ScrollView {
                
                VStack(spacing: 20) {
                    Spacer(minLength: 20)
                    
                    Image(systemName: "cloud.sun.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.yellow)
                    
                    Text("Weather Bunny")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Version 1.0")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Text("Your cute and reliable weather companion. Get accurate forecasts with a touch of whimsy!")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        FeatureRow(icon: "cloud.sun.fill", text: "Accurate Forecasts")
                        FeatureRow(icon: "map.fill", text: "Location-based Weather")
                        FeatureRow(icon: "bell.fill", text: "Weather Alerts")
                        
                    }
                    .padding(.horizontal)
                    
                    Image("710E8EC2-2633-479C-A90D-3B75A410059C 2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 150)
                        .clipShape(Circle()) // Optional: Make it a circle
                        .overlay(
                            Circle()
                                .stroke(Color.pink.opacity(0.5), lineWidth: 20) // Adds fading edges
                                .blur(radius: 15)
                        )
                        .shadow(color: Color.pink.opacity(0.3), radius: 20, x: 0, y: 0)
                    
                    Text("Created with ❤️ by pbs")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .frame(minHeight: bounds.size.height)
            }
            .frame(width: bounds.size.width)
        }
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}
}
// FeatureRow struct remains the same

// Your preview remains the same

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            Text(text)
                .font(.body)
        }
    }
}

// Your preview remains the same

#Preview {
    RightView(activeView: currentView.right)
}
