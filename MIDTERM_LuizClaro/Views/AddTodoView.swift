//
//  AddTodoView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-13.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var didScreenLoad: Bool = false
    @State var isTapped: Bool = false
    
    @State var todoName: String = ""
    @State var todoDay: String = ""
    @State var todoTime: String = ""
    @State var todoNote: String = ""
    @State var todoSmiley: String = ""
        
    @State var chosenCategory = Category.work
    
    enum Category {
        case work, family, urgent, others
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
                    
                    Text("New Reminder").font(.largeTitle.bold())
                        .opacity(didScreenLoad ? 1 : 0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                
                Spacer()
                
                Group {
                    Text("Reminder Name")
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
                            if chosenCategory != .family {
                                FamilyCase()
                            } else {
                                WorkCase()
                            }
                            Spacer()
                        }
                        .opacity(isTapped ? 1 : 0)
                        .padding(.top)
                        .onTapGesture {
                            if chosenCategory != .family {
                                chosenCategory = .family
                            } else {
                                chosenCategory = .work
                            }
                            isTapped.toggle()
                        }

                        HStack{
                            if chosenCategory != .urgent {
                                UrgentCase()
                            } else {
                                WorkCase()
                            }
                            Spacer()
                        }
                        .opacity(isTapped ? 1 : 0)
                        .padding(.top)
                        .onTapGesture {
                            if chosenCategory != .urgent {
                                chosenCategory = .urgent
                            } else {
                                chosenCategory = .work
                            }
                            isTapped.toggle()
                        }

                        HStack{
                            if chosenCategory != .others {
                                OtherCase()
                            } else {
                                WorkCase()
                            }
                            Spacer()
                        }
                        .opacity(isTapped ? 1 : 0)
                        .padding(.top)
                        .onTapGesture {
                            if chosenCategory != .others {
                                chosenCategory = .others
                            } else {
                                chosenCategory = .work
                            }
                            isTapped.toggle()
                        }
                    } label: {
                        HStack{
                            if chosenCategory == .work {
                                WorkCase()
                            } else if chosenCategory == .family {
                                FamilyCase()
                            } else if chosenCategory == .urgent {
                                UrgentCase()
                            } else if chosenCategory == .others {
                                OtherCase()
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
                
                Group{
                    Spacer()
                    
                    Text("Notes")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    TextEditor(text: $todoNote)
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
                
                Text("Select Smiley")
                    .font(.body).foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                HStack{
                    ZStack{
                        Circle().fill(Color("darkBlue")).frame(width: sf.w * 0.1)
                        Text("????").font(.title)
                    }
                    ZStack{
                        Circle().fill(Color("darkBlue")).frame(width: sf.w * 0.1)
                        Text("????").font(.title)
                    }
                    ZStack{
                        Circle().fill(Color("darkBlue")).frame(width: sf.w * 0.1)
                        Text("????").font(.title)
                    }
                    ZStack{
                        Circle().fill(Color("darkBlue")).frame(width: sf.w * 0.1)
                        Text("??????").font(.title)
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
                
                Button("Create Reminder") {
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

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}

struct WorkCase : View {
    var body: some View{
        Circle()
            .fill(gradientTwoDiagonal)
            .frame(width:sf.w * 0.03)
        Text("Work")
    }
}

struct FamilyCase : View {
    var body: some View{
        Circle()
            .fill(gradientThreeDiagonal)
            .frame(width:sf.w * 0.03)
        Text("Family")
    }
}

struct UrgentCase : View {
    var body: some View{
        Circle()
            .fill(gradientOneDiagonal)
            .frame(width:sf.w * 0.03)
        Text("Urgent")
    }
}

struct OtherCase : View {
    var body: some View{
        Circle()
            .fill(gradientTextField)
            .frame(width:sf.w * 0.03)
        Text("Others")
    }
}
