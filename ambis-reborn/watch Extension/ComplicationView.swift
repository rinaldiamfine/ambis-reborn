//
//  ComplicationView.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 19/08/21.
//

import SwiftUI
import ClockKit

struct ComplicationViewCircular: View {
//  @State var appointment: Appointment
  var body: some View {
    ZStack {
        ProgressView(value: (1.0 - 0.9), total: 1.0)
            .progressViewStyle(CircularProgressViewStyle(tint: .red))
        Image("BrandIcon")
            .resizable()
            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
  }
}

struct ComplicationView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ComplicationView_Previews: PreviewProvider {
    static var previews: some View {
//        ComplicationView()
//        ComplicationViewCircular()
        Group {
          CLKComplicationTemplateGraphicCircularView(
            ComplicationViewCircular()
          ).previewContext()
        }
    }
}
