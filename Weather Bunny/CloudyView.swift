//
//  CloudyView.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 11/26/24.
//

import SwiftUI

struct CloudyView: View {
    
    @State private var scale1: CGFloat = 0.8 // State variable for first cloud scaling
    @State private var scale2: CGFloat = 1.0 // State variable for second cloud scaling

    var body: some View {
        ZStack {
            Color.gray.opacity(0.6) // Light gray background
                .ignoresSafeArea() // Extend to cover the safe area
                .edgesIgnoringSafeArea(.all)

            HStack(spacing: -20) { // Use HStack to place clouds side by side

                Image(systemName: "cloud.fill")
                    .foregroundStyle(.gray)
                    .opacity(0.9)
                    .font(.largeTitle)
                    .scaleEffect(scale1)
                    .onAppear {
                        withAnimation(
                            Animation.easeInOut(duration: 3.0)
                                .repeatForever(autoreverses: true)
                        ) {
                            scale1 = 1.8 // Adjusted scaling factor
                        }
                    }

                Image(systemName: "cloud.fill")
                    .foregroundStyle(.gray)
                    .opacity(0.9)
                    .font(.largeTitle)
                    .scaleEffect(scale2)
                    .onAppear {
                        withAnimation(
                            Animation.easeInOut(duration: 3.0)
                                .repeatForever(autoreverses: true)
                        ) {
                            scale2 = 2.2 // Adjusted scaling factor
                        }
                    }
            }
            .padding(.horizontal) // Add padding to space the clouds
        }
    }
}

#Preview {
    CloudyView()
}
