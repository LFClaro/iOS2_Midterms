//
//  ToDoView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-08.
//

import SwiftUI

struct ToDoView: View {
    var body: some View {
        ZStack{
            Color("bgColor").edgesIgnoringSafeArea(.all)
            Text("TODO To Do!")
        }
        .foregroundColor(.white)
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
