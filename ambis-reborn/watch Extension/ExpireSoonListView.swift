//
//  ExpireSoonListView.swift
//  watch Extension
//
//  Created by Rio Sudarsono on 19/08/21.
//

import SwiftUI

struct ExpireSoonListView: View {
    @State var dataInventory : [FormatInventory] = [
        FormatInventory(title: "Paha Ayam", subtitle: "Fridge ・ 1Kg", expiryInt: 3, icon: "🥩"),
        FormatInventory(title: "Sayur", subtitle: "Freezer ・ 10Pcs", expiryInt: 5, icon: "🥦"),
        FormatInventory(title: "Paha Ayam", subtitle: "Fridge ・ 1Kg", expiryInt: 3, icon: "🥩"),
//        FormatInventory(title: "Paha Ayam", subtitle: "Fridge ・ 1Kg", expiryInt: 3, icon: "🥩"),
//        FormatInventory(title: "Paha Ayam", subtitle: "Fridge ・ 1Kg", expiryInt: 3, icon: "🥩"),
//        FormatInventory(title: "Paha Ayam", subtitle: "Fridge ・ 1Kg", expiryInt: 3, icon: "🥩"),
//        FormatInventory(title: "Paha Ayam", subtitle: "Fridge ・ 1Kg", expiryInt: 3, icon: "🥩"),
//        FormatInventory(title: "Sayur", subtitle: "Freezer ・ 10Pcs", expiryInt: 5, icon: "🥦")
    ]
    
    var body: some View {
        Section(header: viewHeader(title: "One Day")) {
            ForEach(dataInventory, id:\.id) { mData in
                listView(data: mData, color: Color("RedListColor"))
            }
        }
        
        Section(header: viewHeader(title: "Two Day")) {
            ForEach(dataInventory, id:\.id) { mData in
                listView(data: mData, color: Color("RedListColor"))
            }
        }
    }
    
    func listView(data: FormatInventory, color: Color) -> some View {
        return HStack {
            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                Text(data.icon).font(.system(.body))
            }
            VStack(alignment: .leading) {
                Text(data.title).font(.system(.body, design: .rounded))
                Text(data.subtitle).font(.system(.footnote, design: .rounded))
            }.padding(.all, 4)
            Spacer()
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
        .background(Color(.gray))
        .cornerRadius(15)
        .padding(.horizontal, 8)
    }
    
    func viewHeader(title: String) -> some View {
        return HStack {
            Text(title).font(.system(size: 14))
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.horizontal, 8)
        .padding(.top, 5)
    }
}


struct ExpireSoonListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpireSoonListView()
    }
}
