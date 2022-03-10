//
//  MainGradient.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-09.
//

import SwiftUI

struct MainGradient: View {
    var startColor : Color = Color(.white)
    var endColor : Color = Color(.black)
    var startPoint : UnitPoint = .top
    var endPoint : UnitPoint  = .bottom
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: startPoint, endPoint: endPoint)
    }
}

struct MainGradient_Previews: PreviewProvider {
    static var previews: some View {
        MainGradient(startColor: .green, endColor: .yellow, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
