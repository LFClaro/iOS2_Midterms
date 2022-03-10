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
    @State var eventColor: MainGradient = MainGradient()
    
    var body: some View {
        ZStack{
            Color("bgColor").edgesIgnoringSafeArea(.all)
            
            VStack(){
                Group {
                    Text("Event Name")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $eventName).background(gradientTextField).cornerRadius(10)
                    
                    Spacer()
                    
                    Text("Details")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        HStack {
                            Image(systemName: "calendar.circle").font(.body)
                            TextField("Select Date", text: $eventDay)
                        }.background(gradientTextField).cornerRadius(10)
                        Spacer()
                        HStack {
                            Image(systemName: "clock").font(.body)
                            TextField("Select Time", text: $eventTime)
                        }.background(gradientTextField).cornerRadius(10)
                    }
                }
                
                Group{
                    Spacer()
                    
                    Text("Notification")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        if(isNotificationActive){
                            Text("Active")
                        } else {
                            Text("Deactivated")
                        }
                        Spacer()
                        Toggle("", isOn: $isNotificationActive)
                    }.background(gradientTextField).cornerRadius(10)
                    
                    Spacer()
                    
                    Text("Notes")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $eventNote)
                        .background(gradientTextField).cornerRadius(10)
                    
                    Spacer()
                }
                
                
                Text("Select Color")
                    .font(.body).foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    ZStack{
                        Circle().fill(Color("darkBlue")).frame(width: sf.w * 0.1)
                        Circle()
                            .fill(LinearGradient(
                                colors: [Color("purpleBlue"), Color("bloodOrange")],
                                startPoint: .top,
                                endPoint: .bottom
                            )).frame(width: sf.w * 0.05)
                    }
                    ZStack{
                        Circle().fill(Color("darkBlue")).frame(width: sf.w * 0.1)
                        Circle()
                            .fill(LinearGradient(
                                colors: [Color("yellow"), Color("bloodOrange")],
                                startPoint: .top,
                                endPoint: .bottom
                            )).frame(width: sf.w * 0.05)
                    }
                }
                
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
            .padding(.horizontal)
            .frame(width: sf.w)
        }
        .frame(width: sf.w)
        .foregroundColor(.white)
        .navigationTitle("New Event")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Image(systemName: "chevron.backward")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .font(.title2.bold())
                        .opacity(didScreenLoad ? 1 : 0)
                        .rotationEffect(.degrees(didScreenLoad ? 0 : 90))
                        .animation(.spring().delay(0.2), value: didScreenLoad)
                }
            }
        }
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
