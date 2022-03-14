//
//  FinanceView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-08.
//

import SwiftUI

struct FinanceView: View {
    let tabs = ["Movements", "Statistics"]
    @State var account = AccountBalance(balance: 800)
    @State var selectedTab = 0
    
    @State var didScreenLoad: Bool = false
    @State var searchTapped: Bool = false
    @State var plusButtonTapped: Bool = false
    
    @StateObject var dataManager = AmountDataManager()
    
    private let calendar: Calendar
    private let dateFormatter: DateFormatter
    private let monthFormatter: DateFormatter
    
    @State var selectedDate = Self.now
    private static var now = Date() // Cache now
    
    init(calendar: Calendar) {
        self.calendar = calendar
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "dd.MM.yyyy"
        self.dateFormatter.calendar = calendar
        
        self.monthFormatter = DateFormatter()
        self.monthFormatter.dateFormat = "MMMM yyyy"
        self.monthFormatter.calendar = calendar
    }
    
    var body: some View {
        ZStack{
            Color("bgColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Text("Money Tracker").font(.largeTitle.bold())
                        .opacity(didScreenLoad ? 1 : 0)
                    Spacer()
                }
                .padding(.vertical)
                
                Tabs(tabs: .constant(tabs), selection: $selectedTab) {title, isSelected in
                    Text(title)
                        .frame(maxWidth: sf.w * 0.5)
                }
                .opacity(didScreenLoad ? 1 : 0)
                
                Spacer()
                
                VStack{
                    ZStack {
                        if (tabs[selectedTab] == "Movements"){
                            VStack{
                                FinanceMonthView(account: account, currentMonth: monthFormatter.string(from: selectedDate))
                                HStack{
                                    Text(monthFormatter.string(from: selectedDate)).font(.title2.bold()).frame(maxWidth: .infinity, alignment: .leading)
                                        .opacity(didScreenLoad ? 1 : 0)
                                        .transition(.slide)
                                    Spacer()
                                    Button {
                                        withAnimation {
                                            guard let newDate = calendar.date(
                                                byAdding: .month,
                                                value: -1,
                                                to: selectedDate
                                            ) else {
                                                return
                                            }
                                            selectedDate = newDate
                                        }
                                    } label: {
                                        Label(
                                            title: { Text("Previous") },
                                            icon: { Image(systemName: "chevron.left") }
                                        )
                                            .labelStyle(IconOnlyLabelStyle())
                                            .padding(.horizontal)
                                            .frame(maxHeight: .infinity)
                                    }
                                    Spacer()
                                    Button {
                                        withAnimation {
                                            guard let newDate = calendar.date(
                                                byAdding: .month,
                                                value: 1,
                                                to: selectedDate
                                            ) else {
                                                return
                                            }
                                            
                                            selectedDate = newDate
                                        }
                                    } label: {
                                        Label(
                                            title: { Text("Next") },
                                            icon: { Image(systemName: "chevron.right") }
                                        )
                                            .labelStyle(IconOnlyLabelStyle())
                                            .padding(.horizontal)
                                            .frame(maxHeight: .infinity)
                                    }
                                }
                                .frame(maxHeight: sf.h * 0.1)
                                Spacer()
                                ScrollView{
                                    ForEach(dataManager.jsonArray.indices, id: \.self) { i in
                                        let formatDate = ISO8601DateFormatter().date(from:dataManager.jsonArray[i].date)!
                                        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: formatDate)
                                        let finalDate = calendar.date(from:components)
                                        if(finalDate!.hasSame(.month, as: selectedDate)){
                                            AmountRow(amount: dataManager.jsonArray[i], displayDate: dateFormatter.string(from: finalDate!))
                                                .offset(x: didScreenLoad ? 0 : -sf.w)
                                                .animation(.ripple(index: i).delay(0.4), value: didScreenLoad)
                                                .transition(.moveAndFade)
                                                .onAppear {
                                                    if(dataManager.jsonArray[i].isIncoming){
                                                        account.balance += dataManager.jsonArray[i].amount
                                                    } else {
                                                        account.balance -= dataManager.jsonArray[i].amount
                                                    }
                                                }
                                            
                                        }
                                    }
                                }
                                Spacer()
                            }
                            Button {
                                plusButtonTapped.toggle()
                            } label: {
                                Circle()
                                    .fill(Color("AccentColor"))
                                    .frame(width: sf.w * 0.15, height: sf.w * 0.15)
                                    .overlay {
                                        Image(systemName: "plus").font(.largeTitle)
                                    }
                                    .padding()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        } else {
                            VStack{
                                Image("graphs")
                                    .resizable().scaledToFit()
                                    .animation(.ripple(index: 1).delay(0.4), value: didScreenLoad)
                                Text("Headline")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Image("outgoingGraph")
                                    .resizable().scaledToFit()
                                    .animation(.ripple(index: 2).delay(0.4), value: didScreenLoad)
                                Image("incomingGraph")
                                    .resizable().scaledToFit()
                                    .animation(.ripple(index: 3).delay(0.4), value: didScreenLoad)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                didScreenLoad = true
            }
        }
        .fullScreenCover(isPresented: $plusButtonTapped) {
            AddAmountView()
        }
        .foregroundColor(.white)
        .navigationBarHidden(true)
    }
}

struct FinanceView_Previews: PreviewProvider {
    static var previews: some View {
        FinanceView(calendar: Calendar(identifier: .gregorian))
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .opacity,
            removal: .slide.combined(with: .opacity)
        )
    }
}
