//
//  AddEventView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-09.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var didScreenLoad: Bool = false
    
    @State var eventName: String = ""
    @State var eventDay: String = ""
    @State var eventTime: String = ""
    @State var isNotificationActive: Bool = true
    @State var eventNote: String = ""
    
    var body: some View {
        ZStack{
            Color("bgColor").edgesIgnoringSafeArea(.all)
            
            VStack(){
                Group{
                    Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                        Image(systemName: "chevron.backward")
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .font(.title2.bold())
                            .opacity(didScreenLoad ? 1 : 0)
                            .rotationEffect(.degrees(didScreenLoad ? 0 : 90))
                            .animation(.spring().delay(0.2), value: didScreenLoad)
                    }
                    
                    Text("New Event").font(.largeTitle.bold())
                        .opacity(didScreenLoad ? 1 : 0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                
                Spacer()
                
                Group {
                    Text("Event Name")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    TextField("", text: $eventName)
                        .frame(height: sf.h * 0.07)
                        .padding(.horizontal)
                        .background(gradientTextField)
                        .cornerRadius(10)
                        .offset(x: didScreenLoad ? 0 : -sf.w)
                        .animation(.ripple(index: 1).delay(0.4), value: didScreenLoad)
                    
                    Spacer()
                    
                    Text("Details")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    HStack{
                        HStack {
                            Image(systemName: "calendar.circle").font(.body)
                            TextField("Select Date", text: $eventDay)
                        }
                        .frame(height: sf.h * 0.07)
                        .padding(.horizontal)
                        .background(gradientTextField)
                        .cornerRadius(10)
                        Spacer()
                        HStack {
                            Image(systemName: "clock").font(.body)
                            TextField("Select Time", text: $eventTime)
                        }
                        .frame(height: sf.h * 0.07)
                        .padding(.horizontal)
                        .background(gradientTextField)
                        .cornerRadius(10)
                    }
                    .offset(x: didScreenLoad ? 0 : -sf.w)
                    .animation(.ripple(index: 2).delay(0.4), value: didScreenLoad)
                }
                
                Group{
                    Spacer()
                    
                    Text("Notification")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    HStack {
                        if(isNotificationActive){
                            Text("Active")
                        } else {
                            Text("Deactivated")
                        }
                        Spacer()
                        
                        Toggle("", isOn: $isNotificationActive)
                    }
                    .frame(height: sf.h * 0.07)
                    .padding(.horizontal)
                    .background(gradientTextField)
                    .cornerRadius(10)
                    .offset(x: didScreenLoad ? 0 : -sf.w)
                    .animation(.ripple(index: 3).delay(0.4), value: didScreenLoad)
                    
                    Spacer()
                    
                    Text("Notes")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    TextEditor(text: $eventNote)
                        .onAppear(perform: {
                            UITextView.appearance().backgroundColor = .clear
                        })
                        .frame(height: sf.h * 0.2)
                        .padding(.horizontal)
                        .background(gradientTextField)
                        .cornerRadius(10)
                        .offset(x: didScreenLoad ? 0 : -sf.w)
                        .animation(.ripple(index: 4).delay(0.4), value: didScreenLoad)
                    
                    Spacer()
                }
                Spacer()
                
                Text("Select Color")
                    .font(.body).foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: didScreenLoad ? 0 : -sf.w)
                .animation(.ripple(index: 5).delay(0.4), value: didScreenLoad)
                
                Spacer()
                
                Button("Create Event") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .frame(width: sf.w * 0.8)
                .background(Color("AccentColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                
            }
            .padding(.horizontal)
            .frame(width: sf.w)
        }
        .frame(width: sf.w)
        .foregroundColor(.white)
        .navigationBarHidden(true)
        .onAppear {
            didScreenLoad.toggle()
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
    }
}
