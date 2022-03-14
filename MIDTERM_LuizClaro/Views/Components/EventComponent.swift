//
//  EventComponent.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-10.
//

import SwiftUI
import LoremSwiftum

struct EventComponent: View {
    var gradient: LinearGradient
    var sentences = 1
    var cardHeight = sf.h * 0.2
    var y = sf.h * 0.2
    
    var body: some View {
        Rectangle()
            .fill(Color("darkBlue"))
            .overlay(
                HStack{
                    VStack(alignment: .leading){
                        Text(Lorem.words(2)).font(.headline)
                        ForEach((0...sentences), id: \.self) {_ in
                            Text("•\(Lorem.words(4))").font(.caption)
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                    gradient.frame(width: 8)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .frame(width: sf.w * 0.7, height: cardHeight)
            .position(x: sf.w * 0.55, y: y)
            .foregroundColor(.white)
    }
}

struct EventComponent_Previews: PreviewProvider {
    static var previews: some View {
        EventComponent(gradient: gradientOne)
    }
}
