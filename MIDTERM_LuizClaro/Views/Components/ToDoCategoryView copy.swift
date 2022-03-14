//
//  ToDoCategoryView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-10.
//

import SwiftUI

struct ToDoCategoryView: View {
    var category: String
    var toDoQty: Int
    var cardWidth = sf.w * 0.38
    var cardHeight = sf.h * 0.12
    
    var body: some View {
        if(category == "Work") {
            Rectangle()
                .fill(gradientTwoDiagonal)
                .overlay(
                    VStack{
                        HStack{
                            Text("🖥")
                                .font(.title)
                            Spacer()
                            Text("\(toDoQty)")
                                .font(.title)
                        }
                        Spacer()
                        Text(category)
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                        .padding()
                    
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: cardWidth, height: cardHeight)
                .foregroundColor(.white)
        } else if(category == "Family") {
            Rectangle()
                .fill(gradientThreeDiagonal)
                .overlay(
                    VStack{
                        HStack{
                            Text("👨‍👩‍👦")
                                .font(.title)
                            Spacer()
                            Text("\(toDoQty)")
                                .font(.title)
                        }
                        Spacer()
                        Text(category)
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                        .padding()
                    
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: cardWidth, height: cardHeight)
                .foregroundColor(.white)
        } else if(category == "Urgent") {
            Rectangle()
                .fill(gradientOneDiagonal)
                .overlay(
                    VStack{
                        HStack{
                            Text("⏱")
                                .font(.title)
                            Spacer()
                            Text("\(toDoQty)")
                                .font(.title)
                        }
                        Spacer()
                        Text(category)
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                        .padding()
                    
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: cardWidth, height: cardHeight)
                .foregroundColor(.white)
        } else {
            Rectangle()
                .fill(gradientTextField)
                .overlay(
                    VStack{
                        HStack{
                            Text("☑️")
                                .font(.title)
                            Spacer()
                            Text("\(toDoQty)")
                                .font(.title)
                        }
                        Spacer()
                        Text("Others")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                        .padding()
                    
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: cardWidth, height: cardHeight)
                .foregroundColor(.white)
        }
    }
}

// MARK: - Previews

#if DEBUG
struct ToDoCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToDoCategoryView(category: "Work", toDoQty: 7)
            ToDoCategoryView(category: "Family", toDoQty: 5)
            ToDoCategoryView(category: "Urgent", toDoQty: 3)
            ToDoCategoryView(category: "", toDoQty: 2)
        }
    }
}
#endif
