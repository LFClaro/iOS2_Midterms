//
//  TodoRow.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-10.
//

import SwiftUI

struct AmountRow: View {
    var amount : Amount
    var displayDate : String = ""
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color("darkBlue"))
            .frame(height: sf.h * 0.08)
            .overlay {
                AmountInfo(amount: amount, displayDate: displayDate)
            }
    }
}

struct AmountInfo : View {
    var amount : Amount
    
    @State var categorycolor : LinearGradient = gradientTextField
    @State var paymentType : String = ""
    @State var transactionValue : String = ""
    @State var displayDate : String = ""
    
    @StateObject var dataManager = AmountDataManager()
    
    var body: some View {
        HStack {
            Circle()
                .fill(categorycolor)
                .frame(width: sf.w * 0.05, height: sf.w * 0.05)
                .overlay {
                    Image(systemName: "arrow.down")
                        .font(.subheadline.bold())
                }
            VStack(alignment: .leading){
                Text(amount.name).font(.subheadline)
                Text("\(paymentType) payment | \(displayDate)")
                    .font(.caption).foregroundColor(.gray)
            }
            Spacer()
            Text("\(transactionValue)")
        }
        .padding()
        .onAppear {
            if(amount.isIncoming){
                categorycolor = gradientThree
                paymentType = "Incoming"
                transactionValue = (amount.amount).formatted(.currency(code: "EUR"))
            } else {
                categorycolor = gradientTwo
                paymentType = "Outgoing"
                transactionValue = (-amount.amount).formatted(.currency(code: "EUR"))
            }
        }
        .foregroundColor(.white)
    }
}

// MARK: - Previews

#if DEBUG
struct AmountRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            AmountRow(amount: amounts[0], displayDate: amounts[0].date)
            AmountRow(amount: amounts[1], displayDate: amounts[1].date)
        }
    }
}
#endif
