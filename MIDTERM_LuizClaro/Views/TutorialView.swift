//
//  TutorialView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-08.
//

import SwiftUI
import LoremSwiftum

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .delay(0.1 * Double(index))
    }
}

struct TutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color("bgColor").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center){
                
                TabView{
                    TabOne()
                    TabTwo()
                    TabThree()
                    TabTwo()
                    TabThree()
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page)
                .padding(5)
                
                Spacer()
                
                Button("Continue") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .frame(width: sf.w * 0.8)
                .background(Color("AccentColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

struct TabOne: View {
    var body: some View{
        ZStack {
            Color("bgColor").edgesIgnoringSafeArea(.all)
            VStack{
                PhoneView().frame(height: sf.h * 0.5)
                
                Text("Lorem Ipsum Dolor").font(.title.bold())
                Text("Lorem ipsum dolor sit amet, consetetur \nsadipscing elitr, sed diam nonumy eirmod.").font(.caption)
            }
        }
    }
}

struct TabTwo: View {
    var body: some View{
        ZStack {
            Color("bgColor").edgesIgnoringSafeArea(.all)
            VStack{
                PhoneViewNotification().frame(height: sf.h * 0.5)
                
                Image("notIcon")
                    .resizable().scaledToFit().frame(maxHeight: sf.h * 0.07)
                Text("Enable Notifications").font(.title.bold())
                Text(Lorem.sentence).font(.caption)
            }
        }
    }
}

struct TabThree: View {
    var body: some View{
        ZStack {
            Color("bgColor").edgesIgnoringSafeArea(.all)
            VStack{
                PhoneView().frame(height: sf.h * 0.5)
                
                Text(Lorem.words(3)).font(.title.bold())
                Text(Lorem.sentence).font(.caption)
            }
        }
    }
}


struct PhoneView: View{
    let rectangles: [String] = ["rectangleYellow", "rectangleBlue", "rectangleRed"]
    @State private var screenLoad: Bool = false
    @State private var imageLoad: Bool = false
    
    var body: some View{
        GeometryReader { geo in
            let geoSF = ScaleFactor(w: geo.size.width, h: geo.size.height)
            ZStack(alignment: .center){
                Image("phone").resizable().scaledToFit().frame(width: geoSF.w * 0.5)
                    .scaleEffect(screenLoad ? 1 : 0)
                Image("phoneText").resizable().scaledToFit().frame(width: geoSF.w * 0.3).offset(y: geoSF.h * 0.1)
                    .scaleEffect(screenLoad ? 1 : 0)
                HStack(spacing: 4){
                    ForEach(rectangles.indices, id: \.self) { i in
                        Image(rectangles[i]).resizable().scaledToFit().frame(height: geoSF.h * 0.08)
                            .scaleEffect(imageLoad ? 1 : 0)
                            .animation(.ripple(index: i).delay(0.5), value: imageLoad)
                    }
                }
                .position(x: geoSF.w * 0.55, y: geoSF.h * 0.28)
            }
        }
        .onAppear {
            withAnimation(.spring(dampingFraction: 0.5)) {
                screenLoad = true
            }
            imageLoad = true
        }
    }
}

struct PhoneViewNotification: View{
    @State private var screenLoad: Bool = false
    @State private var imageLoad: Bool = false
    
    var body: some View{
        GeometryReader { geo in
            let geoSF = ScaleFactor(w: geo.size.width, h: geo.size.height)
            ZStack(alignment: .center){
                Image("phone").resizable().scaledToFit().frame(width: geoSF.w * 0.5)
                    .opacity(screenLoad ? 1 : 0)
                Image("notifications").resizable().scaledToFit().frame(width: geoSF.w * 0.6).offset(y: geoSF.h * -0.1)
                    .scaleEffect(screenLoad ? 1 : 0)
            }
            .position(x: sf.w * 0.5, y: sf.h * 0.25)
        }
        .onAppear {
            withAnimation(.spring(dampingFraction: 0.5)) {
                screenLoad = true
            }
            imageLoad = true
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
