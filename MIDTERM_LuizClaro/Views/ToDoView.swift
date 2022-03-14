//
//  ToDoView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-08.
//

import SwiftUI
import LoremSwiftum

struct ToDoView: View {
    @State var didScreenLoad: Bool = false
    @State var searchTapped: Bool = false
    @State var plusButtonTapped: Bool = false
    
    @StateObject var dataManager = TodoDataManager()
    
    private let calendar: Calendar
    
    let todoCards:[(category: String, qty: Int)] = [("Work", 7), ("Family", 5), ("Urgent", 3), ("Others", 0)]
    
    init(calendar: Calendar) {
        self.calendar = calendar
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack{
            Color("bgColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("ToDos").font(.largeTitle.bold())
                            .opacity(didScreenLoad ? 1 : 0)
                        Text("Lorem Ipsum dolor sit amet.").font(.body).foregroundColor(.gray)
                            .opacity(didScreenLoad ? 1 : 0)
                    }
                    Spacer()
                    Image(systemName: "magnifyingglass").font(.largeTitle)
                        .scaleEffect(searchTapped ? 1.2 : 1).onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.2)) {
                                searchTapped.toggle()
                            }
                        }
                        .opacity(didScreenLoad ? 1 : 0)
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: sf.w * 0.04){
                        ForEach(todoCards.indices, id: \.self) { i in
                            ToDoCategoryView(category: self.todoCards[i].category, toDoQty: self.todoCards[i].qty)
                                .scaleEffect(didScreenLoad ? 1 : 0)
                                .animation(.ripple(index: i).delay(0.2), value: didScreenLoad)
                        }
                    }
                    .padding()
                }
                
                ZStack {
                    ScrollView{
                        Text("Today").font(.title2.bold()).frame(maxWidth: .infinity, alignment: .leading)
                            .opacity(didScreenLoad ? 1 : 0)
                        ForEach(dataManager.jsonArray.indices, id: \.self) { i in
                            let formatDate = ISO8601DateFormatter().date(from:dataManager.jsonArray[i].date)!
                            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: formatDate)
                            let finalDate = calendar.date(from:components)
                            if(finalDate!.hasSame(.day, as: Date())){
                                TodoRow(todo: dataManager.jsonArray[i])
                                    .offset(x: didScreenLoad ? 0 : -sf.w)
                                    .animation(.ripple(index: i).delay(0.4), value: didScreenLoad)
                            }
                        }
                        Spacer()
                            .padding(.bottom)
                        Text("Tomorrow").font(.title2.bold()).frame(maxWidth: .infinity, alignment: .leading)
                            .opacity(didScreenLoad ? 1 : 0)
                        ForEach(dataManager.jsonArray.indices, id: \.self) { i in
                            let formatDate = ISO8601DateFormatter().date(from:dataManager.jsonArray[i].date)!
                            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: formatDate)
                            let finalDate = calendar.date(from:components)
                            if((finalDate!.distance(from: Date(), only: .day)) == 1){
                                TodoRow(todo: dataManager.jsonArray[i])
                                    .offset(x: didScreenLoad ? 0 : -sf.w)
                                    .animation(.ripple(index: i).delay(0.4), value: didScreenLoad)
                            }
                        }
                        Spacer()
                            .padding(.bottom)
                        Text("Following Days").font(.title2.bold()).frame(maxWidth: .infinity, alignment: .leading)
                            .opacity(didScreenLoad ? 1 : 0)
                        ForEach(dataManager.jsonArray.indices, id: \.self) { i in
                            let formatDate = ISO8601DateFormatter().date(from:dataManager.jsonArray[i].date)!
                            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: formatDate)
                            let finalDate = calendar.date(from:components)
                            if((finalDate!.distance(from: Date(), only: .day)) > 1){
                                TodoRow(todo: dataManager.jsonArray[i])
                                    .offset(x: didScreenLoad ? 0 : -sf.w)
                                    .animation(.ripple(index: i).delay(0.4), value: didScreenLoad)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    
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
                }
            }
        }
        .foregroundColor(.white)
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                didScreenLoad = true
            }
        }
        .fullScreenCover(isPresented: $plusButtonTapped) {
            AddTodoView()
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView(calendar: Calendar(identifier: .gregorian))
    }
}
