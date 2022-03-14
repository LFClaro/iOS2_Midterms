//
//  TodoRow.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-10.
//

import SwiftUI

struct TodoRow: View {
    var todo : Todo
    
    var body: some View {
       RoundedRectangle(cornerRadius: 12)
            .fill(Color("darkBlue"))
            .frame(height: sf.h * 0.08)
            .overlay {
                TodoInfo(todo: todo)
            }
    }
}

struct TodoInfo : View {
    var todo : Todo
    @State var categorycolor : LinearGradient = gradientTextField
    
    @State private var isTapped : Bool = false
    
    @StateObject var dataManager = TodoDataManager()
    
    var body: some View {
        HStack {
            if(todo.completed){
                Circle()
                    .fill(categorycolor)
                    .frame(width: sf.w * 0.08)
                    .overlay {
                        ZStack{
                            Image(systemName: "checkmark")
                                .font(.title3.bold())
                                .opacity(isTapped ? 0 : 1)
                            Circle()
                                .fill(Color("darkBlue"))
                                .frame(width: sf.w * 0.07)
                                .opacity(isTapped ? 1 : 0)
                        }
                    }
                    .opacity(isTapped ? 1 : 0.5)
                Text(todo.name).font(.body)
                    .strikethrough(isTapped ? false : true)
                    .padding()
                    .transition(.move(edge: isTapped ? .trailing : .leading))
                
            } else {
                Circle()
                    .fill(categorycolor)
                    .frame(width: sf.w * 0.08)
                    .overlay {
                        Circle()
                            .fill(Color("darkBlue"))
                            .frame(width: sf.w * 0.07)
                            .opacity(isTapped ? 0 : 1)
                        Image(systemName: "checkmark")
                            .font(.title3.bold())
                            .opacity(isTapped ? 1 : 0)
                    }
                    .opacity(isTapped ? 0.5 : 1)
                Text(todo.name).font(.body)
                    .strikethrough(isTapped ? true : false)
                    .padding()
            }
            Spacer()
        }
        .onTapGesture(perform: {
            withAnimation(.spring(dampingFraction: 0.5)){
                isTapped.toggle()
            }
            dataManager.jsonArray[self.todo.id].completed.toggle()
            dataManager.saveToFile()
        })
        .padding()
        .onAppear {
            if(todo.category == "Work"){
                categorycolor = gradientTwoDiagonal
            }else if(todo.category == "Family"){
                categorycolor = gradientThreeDiagonal
            }else if(todo.category == "Urgent"){
                categorycolor = gradientOneDiagonal
            }else{
                categorycolor = gradientTextField
            }
        }
        .foregroundColor(.white)
    }
}

struct Checked : View {
    var body: some View{
        Image(systemName: "checkmark")
            .font(.title3.bold())
    }
}

struct unchecked : View {
    var body: some View{
        Circle()
            .fill(Color("darkBlue"))
            .frame(width: sf.w * 0.07)
    }
}

// MARK: - Previews

#if DEBUG
struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            TodoRow(todo: todos[3])
            TodoRow(todo: todos[1])
        }
    }
}
#endif
