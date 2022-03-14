//
//  LaunchView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-08.
//

import SwiftUI

struct LaunchView: View {
    
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @State private var isCounting: Bool = false
    @Binding var showLaunch: Bool
    
    var body: some View {
        ZStack{
            Color("bgColor").edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0){
                Image("check")
                    .rotationEffect(.degrees(isCounting ? 1440 : 0))
                    .animation(.spring(dampingFraction: 0.7).speed(0.5), value: isCounting)
                Image("organize")
                    .opacity(isCounting ? 1.0 : 0)
                    .animation(.easeInOut(duration: 2), value: isCounting)
                    .offset(y: sf.h * -0.03)
            }
            .scaleEffect(1.5)
            .position(x: sf.w * 0.5, y: sf.h * 0.4)
            .onAppear {
                isCounting.toggle()
            }
        }.onReceive(timer , perform: { _ in
            withAnimation(.easeInOut){
                let lastIndex = 10
                if counter == lastIndex{
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunch = false
                    }
                }else{
                    counter += 1
                }
            }
        })
            .statusBar(hidden: true)
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunch: .constant(true))
    }
}
