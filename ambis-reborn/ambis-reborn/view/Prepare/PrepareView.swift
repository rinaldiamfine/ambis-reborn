//
//  PrepareView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 28/07/21.
//

import SwiftUI

struct PrepareView: View {
    
    func getIconName() -> Image {
        return Image(systemName: "list.dash")
    }
    func gettabName() -> Text {
        return Text("Prepare")
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PrepareView_Previews: PreviewProvider {
    static var previews: some View {
        PrepareView()
    }
}
