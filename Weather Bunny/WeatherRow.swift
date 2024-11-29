//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Stephanie Diep on 2021-11-30.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                .cornerRadius(50)

            
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title3)
            }
        }
            
            .fontWeight(.semibold)
            .foregroundColor(.black)

    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}
