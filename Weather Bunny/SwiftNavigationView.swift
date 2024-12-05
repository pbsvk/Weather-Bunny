//
//  SwiftNavigationView.swift
//  Weather Bunny
//
//  Created by Bhaskara Padala on 12/4/24.
//

import Foundation
import SwiftUI

enum currentView {
    case center
    case left
    case right
}

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height


struct SwiftNavigationView: View {
    @State var activeView = currentView.center
    @State var viewState = CGSize.zero
    @State var weather: ResponseBody
    var body: some View{
        ZStack {
            WeatherView(activeView: self.activeView, weather: weather)
                .animation(.easeInOut, value: self.viewState)
            SunnyDayView(activeView: self.activeView)
                .offset (x: self.activeView == currentView.left ? 0 : -screenWidth)
                .offset(x: activeView != .right ? viewState.width : 0)
                .animation(. easeInOut, value: self.viewState)
            RightView(activeView: self.activeView)
                .offset(x: self.activeView == currentView.right ? 0 : screenWidth)
                .offset(x: activeView != .left ? viewState.width : 0)
                .animation(.easeInOut, value:self.viewState)
        }
        .gesture(
                    
                    (self.activeView == currentView.center) ?
                        
                        DragGesture().onChanged { value in
                            
                            self.viewState = value.translation
                            
                        }
                        .onEnded { value in
                            if value.predictedEndTranslation.width > screenWidth / 2 {
                                self.activeView = currentView.left
                                self.viewState = .zero
                                
                            }
                            else if value.predictedEndTranslation.width < -screenWidth / 2 {
                                self.activeView = currentView.right
                                self.viewState = .zero
                            }
                            
                            else {
                                self.viewState = .zero
                            }
                            
                        }
                        : DragGesture().onChanged { value in
                            switch self.activeView {
                            case .left:
                                guard value.translation.width < 1 else { return }
                                self.viewState = value.translation
                            case .right:
                                guard value.translation.width > 1 else { return }
                                self.viewState = value.translation
                            case.center:
                                self.viewState = value.translation
                                
                            }
                            
                        }
                        
                        .onEnded { value in
                            switch self.activeView {
                            case .left:
                                if value.predictedEndTranslation.width < -screenWidth / 2 {
                                    self.activeView = .center
                                    self.viewState = .zero
                                }
                                else {
                                    self.viewState = .zero
                                }
                            case .right:
                                if value.predictedEndTranslation.width > screenWidth / 2 {
                                    self.activeView = .center
                                    self.viewState = .zero
                                }
                                else {
                                    self.viewState = .zero
                                }
                            case .center:
                                self.viewState = .zero
                                
                            }
                        }
                )
            }
        }

struct SwiftNavigationViewPreview: PreviewProvider {
    static var previews: some View {
        SwiftNavigationView(weather: previewWeather) // Use the existing previewWeather
    }
}
