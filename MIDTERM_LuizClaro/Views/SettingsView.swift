//
//  SettingsView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-08.
//

import SwiftUI

struct SettingsView: View {
    @State var didScreenLoad: Bool = false
    
    @State var isNotificationActive1: Bool = true
    @State var isNotificationActive2: Bool = true
    @State var isNotificationActive3: Bool = true
    
    var body: some View {
        ZStack{
            Color("bgColor").edgesIgnoringSafeArea(.all)
            
            VStack(){
                Text("Settings").font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(didScreenLoad ? 1 : 0)
                Spacer()
                
                Group {
                    Text("Headline")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .opacity(didScreenLoad ? 1 : 0)
                    HStack{
                        Circle()
                            .fill(gradientTwo)
                            .frame(width:sf.w * 0.08)
                            .overlay{
                                Image("diamond")
                                    .scaleEffect(1.2)
                            }
                            .padding(.trailing)
                        Text("Upgrade to Pro")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .frame(height: sf.h * 0.07)
                    .padding(.horizontal)
                    .background(gradientTextField)
                    .cornerRadius(10)
                    .offset(x: didScreenLoad ? 0 : -sf.w)
                    .animation(.ripple(index: 1).delay(0.4), value: didScreenLoad)
                    HStack{
                        Circle()
                            .fill(gradientThree)
                            .frame(width:sf.w * 0.08)
                            .overlay{
                                Image(systemName: "star")
                                    .font(.title3)
                            }
                            .padding(.trailing)
                        Text("Rate the App")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .frame(height: sf.h * 0.07)
                    .padding(.horizontal)
                    .background(gradientTextField)
                    .cornerRadius(10)
                    .offset(x: didScreenLoad ? 0 : -sf.w)
                    .animation(.ripple(index: 2).delay(0.4), value: didScreenLoad)
                    HStack{
                        Circle()
                            .fill(gradientOne)
                            .frame(width:sf.w * 0.08)
                            .overlay{
                                Image(systemName: "gear")
                                    .font(.title3)
                            }
                            .padding(.trailing)
                        Text("General")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .frame(height: sf.h * 0.07)
                    .padding(.horizontal)
                    .background(gradientTextField)
                    .cornerRadius(10)
                    .offset(x: didScreenLoad ? 0 : -sf.w)
                    .animation(.ripple(index: 3).delay(0.4), value: didScreenLoad)
                }
                
                Spacer()
                
                Group{
                    Text("Headline")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .opacity(didScreenLoad ? 1 : 0)
                    HStack {
                        if(isNotificationActive1){
                            Text("Active")
                        } else {
                            Text("Deactivated")
                        }
                        Spacer()
                        Toggle("", isOn: $isNotificationActive1)
                    }
                    .frame(height: sf.h * 0.07)
                    .padding(.horizontal)
                    .background(gradientTextField)
                    .cornerRadius(10)
                    .offset(x: didScreenLoad ? 0 : -sf.w)
                    .animation(.ripple(index: 4).delay(0.4), value: didScreenLoad)
                    
                    Text("Headline")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .opacity(didScreenLoad ? 1 : 0)
                    HStack {
                        if(isNotificationActive2){
                            Text("Active")
                        } else {
                            Text("Deactivated")
                        }
                        Spacer()
                        Toggle("", isOn: $isNotificationActive2)
                    }
                    .frame(height: sf.h * 0.07)
                    .padding(.horizontal)
                    .background(gradientTextField)
                    .cornerRadius(10)
                    .offset(x: didScreenLoad ? 0 : -sf.w)
                    .animation(.ripple(index: 5).delay(0.4), value: didScreenLoad)
                    
                    Text("Headline")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .opacity(didScreenLoad ? 1 : 0)
                    HStack {
                        if(isNotificationActive3){
                            Text("Active")
                        } else {
                            Text("Deactivated")
                        }
                        Spacer()
                        Toggle("", isOn: $isNotificationActive3)
                    }
                    .frame(height: sf.h * 0.07)
                    .padding(.horizontal)
                    .background(gradientTextField)
                    .cornerRadius(10)
                    .offset(x: didScreenLoad ? 0 : -sf.w)
                    .animation(.ripple(index: 6).delay(0.4), value: didScreenLoad)
                }
                
                Spacer()
                
                Text("Colour Style")
                    .font(.body).foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .opacity(didScreenLoad ? 1 : 0)
                HStack{
                    ZStack{
                        Circle().fill(Color("darkBlue")).frame(width: sf.w * 0.1)
                        Circle()
                            .fill(gradientOne)
                            .frame(width: sf.w * 0.05)
                    }
                    ZStack{
                        Circle().fill(Color("darkBlue")).frame(width: sf.w * 0.1)
                        Circle()
                            .fill(gradientTwo)
                            .frame(width: sf.w * 0.05)
                    }
                    ZStack{
                        Circle().fill(Color("darkBlue")).frame(width: sf.w * 0.1)
                        Circle()
                            .fill(gradientThree)
                            .frame(width: sf.w * 0.05)
                    }
                    ZStack{
                        Circle().fill(Color("darkBlue")).frame(width: sf.w * 0.1)
                        Image(systemName: "plus").frame(width: sf.w * 0.05)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: sf.h * 0.05, alignment: .leading)
                .offset(x: didScreenLoad ? 0 : -sf.w)
                .animation(.ripple(index: 6).delay(0.4), value: didScreenLoad)
                
                Spacer()
                
            }
            .padding(.horizontal)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                didScreenLoad = true
            }
        }
        .frame(width: sf.w)
        .foregroundColor(.white)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
