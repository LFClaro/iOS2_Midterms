//
//  LoginView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-13.
//

import SwiftUI

struct LoginView: View {
    let persistenceController = PersistenceController.shared
    @State var didScreenLoadStepOne: Bool = false
    @State var didScreenLoadStepTwo: Bool = false
    
    @State var isSuccess: Bool = false
    @State var isTapped: Bool = false
    @State var forgotAlert: Bool = false
    @State var wrongAlert: Bool = false
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack{
            Color("bgColor").edgesIgnoringSafeArea(.all)
            
            VStack(){
                Group {
                    Spacer()
                    Text("Login").font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                        .opacity(didScreenLoadStepOne ? 1 : 0)
                    Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.").font(.body).foregroundColor(.gray)
                        .opacity(didScreenLoadStepOne ? 1 : 0)
                }
                Spacer()
                Spacer()
                
                Group{
                    Text("Name")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .opacity(didScreenLoadStepOne ? 1 : 0)
                    TextField("", text: $username)
                        .frame(height: sf.h * 0.07)
                        .autocapitalization(.none)
                        .padding(.horizontal)
                        .background(gradientTextField)
                        .cornerRadius(10)
                        .padding(.bottom)
                        .offset(x: didScreenLoadStepTwo ? 0 : sf.w * -3)
                    
                    Text("Password")
                        .font(.body).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .opacity(didScreenLoadStepOne ? 1 : 0)
                    SecureField("", text: $password)
                        .frame(height: sf.h * 0.07)
                        .autocapitalization(.none)
                        .padding(.horizontal)
                        .background(gradientTextField)
                        .cornerRadius(10)
                        .offset(x: didScreenLoadStepTwo ? 0 : sf.w * 3)
                    Button {
                        forgotAlert = true
                    } label: {
                        Text("Forgot Password?")
                            .font(.subheadline).foregroundColor(.gray)
                            .underline()
                            .opacity(didScreenLoadStepOne ? 1 : 0)
                    }
                    .alert(isPresented: $forgotAlert) {
                        Alert(title: Text("Don't worry!"), message: Text("We've sent you and e-mail with a reset link."), dismissButton: .default(Text("Got it!")))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Spacer()
                Spacer()
                
                Group{
                    Text("Or login with...")
                        .font(.subheadline)
                        .opacity(didScreenLoadStepOne ? 1 : 0)
                    HStack{
                        Button{
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .frame(width: sf.w * 0.35, height: sf.h * 0.06)
                                .overlay {
                                    HStack{
                                        Image("google")
                                        Text("Google")
                                    }
                                }
                            
                        }
                        .padding()
                        
                        Button{
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .frame(width: sf.w * 0.35, height: sf.h * 0.06)
                                .overlay {
                                    HStack{
                                        Image("facebook")
                                        Text("Facebook")
                                    }
                                }
                            
                        }
                        .padding()
                    }
                    .scaleEffect(didScreenLoadStepTwo ? 1 : 0)
                    
                }
                .padding(.bottom)
                
                Button {
                    if(username == "" || password == ""){
                        wrongAlert = true
                    } else {
                        isSuccess = true
                    }
                } label: {
                    Text("Login")
                        .padding()
                        .frame(width: sf.w * 0.8)
                        .background(Color("AccentColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .scaleEffect(didScreenLoadStepTwo ? 1 : 0)
                }
                .alert(isPresented: $wrongAlert) {
                    Alert(title: Text("Error!"), message: Text("Please enter Name and Password."), dismissButton: .default(Text("OK")))
                }
            }
            .padding(.horizontal)
            .frame(width: sf.w)
            .foregroundColor(.white)
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            withAnimation(.easeInOut.delay(0.3)){
                didScreenLoadStepOne.toggle()
            }
            withAnimation(.spring(dampingFraction: 0.5).delay(0.5).speed(0.8)) {
                didScreenLoadStepTwo.toggle()
            }
        }
        .fullScreenCover(isPresented: $isSuccess) {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
