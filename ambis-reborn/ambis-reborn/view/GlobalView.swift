//
//  GlobalView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 02/08/21.
//

import SwiftUI

struct GlobalView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GlobalView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalView()
    }
}

struct SpaceView: View {
    var body: some View {
        HStack {
            HStack {
                Text(" ")
                Spacer()
            }
        }
        HStack {
            HStack {
                Text(" ")
                Spacer()
            }
        }
        HStack {
            HStack {
                Text(" ")
                Spacer()
            }
        }
        HStack {
            HStack {
                Text(" ")
                Spacer()
            }
        }
    }
}
