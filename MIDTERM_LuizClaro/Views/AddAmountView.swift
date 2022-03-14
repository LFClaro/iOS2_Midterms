//
//  AddAmountView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-13.
//

import SwiftUI

struct AddAmountView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var didScreenLoad: Bool = false
    @State var isTapped: Bool = false
    
    @State var amountSelected = 50.0
    @State var isEditing = false
    
    @State var todoName: String = ""
    @State var todoDay: String = ""
    @State var todoTime: String = ""
    @State var todoNote: String = ""
    @State var todoSmiley: String = ""
        
    @State var chosenCategory = Category.outgoing
    
    enum Category {
        case outgoing, incoming
    }
    
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
                    
                    Text("New Amount").font(.largeTitle.bold())
                        .opacity(didScreenLoad ? 1 : 0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                
                Spacer()
                
                Group {
                    Text("Amount Name")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    TextField("", text: $todoName)
                        .frame(height: sf.h * 0.07)
                        .padding(.horizontal)
                        .background(gradientTextField)
                        .cornerRadius(10)
                        .offset(x: didScreenLoad ? 0 : -sf.w)
                        .animation(.ripple(index: 1).delay(0.4), value: didScreenLoad)
                    
                    Spacer()
                    
                    Text("Category")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    DisclosureGroup(isExpanded: $isTapped) {
                        HStack{
                            if chosenCategory != .incoming {
                                IncomingCase()
                            } else {
                                OutgoingCase()
                            }
                            Spacer()
                        }
                        .opacity(isTapped ? 1 : 0)
                        .padding(.top)
                        .onTapGesture {
                            if chosenCategory != .incoming {
                                chosenCategory = .incoming
                            } else {
                                chosenCategory = .outgoing
                            }
                            isTapped.toggle()
                        }
                    } label: {
                        HStack{
                            if chosenCategory == .outgoing {
                                OutgoingCase()
                            } else if chosenCategory == .incoming {
                                IncomingCase()
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .rotationEffect(.degrees(isTapped ? 90 : 0))
                        }
                        .frame(height: sf.h * 0.03)
                    }
                    .padding()
                    .background(gradientTextField)
                    .cornerRadius(10)
                    .offset(x: didScreenLoad ? 0 : -sf.w)
                    .animation(.ripple(index: 2).delay(0.4), value: didScreenLoad)
                    
                    Spacer()
                }
                Group{
                    Text("Amount")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    HStack {
                        Slider(
                            value: $amountSelected,
                            in: 0...1000,
                            onEditingChanged: { editing in
                                isEditing = editing
                            }
                        )
                            .accentColor((chosenCategory == .outgoing) ? Color("bloodOrange") : Color("skyBlue"))
                        Spacer()
                        Text("\(amountSelected.formatted(.currency(code: "EUR")))")
                            .frame(maxWidth: sf.w * 0.2, alignment: .trailing)
                            .padding(.horizontal)
                    }
                    .frame(height: sf.h * 0.07)
                    .padding(.horizontal)
                    .background(gradientTextField)
                    .cornerRadius(10)
                    .offset(x: didScreenLoad ? 0 : -sf.w)
                    .animation(.ripple(index: 3).delay(0.4), value: didScreenLoad)
                    Spacer()
                    
                    Text("Details")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    HStack{
                        HStack {
                            Image(systemName: "calendar.circle").font(.body)
                            TextField("Select Date", text: $todoDay)
                        }
                        .frame(height: sf.h * 0.07)
                        .padding(.horizontal)
                        .background(gradientTextField)
                        .cornerRadius(10)
                        Spacer()
                        HStack {
                            Image(systemName: "clock").font(.body)
                            TextField("Select Time", text: $todoTime)
                        }
                        .frame(height: sf.h * 0.07)
                        .padding(.horizontal)
                        .background(gradientTextField)
                        .cornerRadius(10)
                    }
                    .offset(x: didScreenLoad ? 0 : -sf.w)
                    .animation(.ripple(index: 3).delay(0.4), value: didScreenLoad)
                    
                }
                
                Spacer()
                Spacer()
                    .padding(.bottom)
                
                Button("Enter New Amount") {
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

struct AddAmountView_Previews: PreviewProvider {
    static var previews: some View {
        AddAmountView()
    }
}

struct OutgoingCase : View {
    var body: some View{
        Circle()
            .fill(gradientTwoDiagonal)
            .frame(width:sf.w * 0.03)
        Text("Outgoing payment")
    }
}

struct IncomingCase : View {
    var body: some View{
        Circle()
            .fill(gradientThreeDiagonal)
            .frame(width:sf.w * 0.03)
        Text("Incoming payment")
    }
}
