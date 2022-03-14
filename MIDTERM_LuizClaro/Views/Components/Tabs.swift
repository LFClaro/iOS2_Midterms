//
//  Tabs.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-13.
//

import SwiftUI

struct Tabs<Label: View>: View {
    @Binding var tabs: [String] // The tab titles
    @Binding var selection: Int // Currently selected tab
    
    //Colors
    let backgroundSelectedColor: Color = Color("bgColorAccent")
    let backgroundUnselectedColor: Color = Color("darkBlue")
    let foregroundSelectedColor: Color = Color(.white)
    let foregroundUnselectedColor: Color = Color(.gray)
    
    //Shape for clipping
    let shape = RoundedRectangle(cornerRadius: 10)
    
    // Tab label rendering closure - provides the current title and if it's the currently selected tab
    let label: (String, Bool) -> Label
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(tabs, id: \.self) {
                self.tab(title: $0)
            }
        }
    }
    
    public func tab(title: String) -> some View {
        let index = self.tabs.firstIndex(of: title)!
        let isSelected = index == selection
        return Button(action: {
            withAnimation {
                self.selection = index
            }
        }) {
            label(title, isSelected)
                .padding(.vertical)
                .background(isSelected ? backgroundSelectedColor : backgroundUnselectedColor)
                .foregroundColor(isSelected ? foregroundSelectedColor : foregroundUnselectedColor)
                .clipShape(shape)
                .transition(.move(edge: .leading))
        }
    }
}


struct Tabs_Previews: PreviewProvider {
    @State static var tabs = ["Movements", "Statistics"]
    @State static var selectedTab = 0
    
    static var previews: some View {
        Tabs(tabs: .constant(tabs), selection: $selectedTab) {title, isSelected in
            Text(title)
                .frame(width: sf.w * 0.5)
        }
    }
}
