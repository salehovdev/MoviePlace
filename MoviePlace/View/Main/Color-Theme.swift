//
//  Color-Theme.swift
//  MoviePlace
//
//  Created by Fuad Salehov on 18.05.25.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == RadialGradient {
    static var splashBackground: RadialGradient {
        RadialGradient(colors: [.yellow, .black], center: .topTrailing, startRadius: 5, endRadius: 600)
    }
    
    static var homeBackground: RadialGradient {
        RadialGradient(colors: [.yellow, .black], center: .topTrailing, startRadius: 5, endRadius: 400)
    }
    
    static var searchBackground: RadialGradient {
        RadialGradient(colors: [.black, .yellow.opacity(0.8)], center: .center, startRadius: 5, endRadius: 500)
    }
    
    static var topratedBackground: RadialGradient {
        RadialGradient(colors: [.yellow.opacity(0.8), .black], center: .top, startRadius: 5, endRadius: 300)
    }
    
    
}
