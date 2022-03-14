//
//  ToDoCategoryView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-10.
//

import SwiftUI

struct FinanceMonthView: View {
    var account: AccountBalance
    
    var cardWidth = sf.w
    var cardHeight = sf.h * 0.25
    @State var gradientColor = gradientOneDiagonal
    @State var acctBalance = ""
    @State var currentMonth = "January"
    
    var body: some View {
        Rectangle()
            .fill(gradientColor)
            .overlay(
                VStack{
                    HStack{
                        Text("Remaining for \(currentMonth)")
                            .font(.body)
                        Spacer()
                        Image(systemName: "ellipsis")
                            .font(.title)
                    }
                    Text(acctBalance)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    ProgressView("", value: 800, total: 3000)
                        .progressViewStyle(LinearProgressViewStyle(tint: .white))
                    HStack{
                        Text("Montly Limit: ")
                            .font(.body)
                        Text("1000,00€")
                            .fontWeight(.bold)
                        Spacer()
                    }
                }.padding()
                
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .frame(maxWidth: cardWidth, maxHeight: cardHeight)
            .foregroundColor(.white)
            .onAppear {
                if (account.balance > 0) {
                    acctBalance = "+\(account.balance.formatted(.currency(code: "EUR")))"
                } else {
                    acctBalance = "\(account.balance.formatted(.currency(code: "EUR")))"
                    gradientColor = gradientThreeDiagonal
                }
            }
    }
}

// MARK: - Previews

#if DEBUG
struct FinanceMonthView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FinanceMonthView(account: AccountBalance(balance: 800))
            FinanceMonthView(account: AccountBalance(balance: -1500))
        }
    }
}
#endif
