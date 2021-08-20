//
//  ExpireSoonProgressBarView.swift
//  watch Extension
//
//  Created by Muhammad Rizki Miftha Alhamid on 8/19/21.
//

import SwiftUI

struct ExpireSoonProgressBarView: View {
    
    @State var nearExpiryItem: Int = 4
    @State var totalInventory: Int = 16
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                if nearExpiryItem == 0 || nearExpiryItem == totalInventory {
                    Circle()
                        .trim(from: 0.0, to: CGFloat(1 - (Double(nearExpiryItem) / Double(totalInventory))))
                        .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color("SuccessColorTransparent"))
                        .rotationEffect(Angle(degrees: calculateBackCircleRotationAngle(numerator: nearExpiryItem, denumerator: totalInventory)))
                        .frame(width: 115, height: 115)
                    Circle()
                        .trim(from: 0.0, to: CGFloat(Double(nearExpiryItem) / Double(totalInventory)))
                        .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color("DangerColor"))
                        .rotationEffect(Angle(degrees: 270))
                        .frame(width: 115, height: 115)
                } else {
                    Circle()
                        .trim(from: 0.025, to: CGFloat(0.975 - (Double(nearExpiryItem) / Double(totalInventory))))
                        .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color("SuccessColorTransparent"))
                        .rotationEffect(Angle(degrees: calculateBackCircleRotationAngle(numerator: nearExpiryItem, denumerator: totalInventory)))
                        .frame(width: 115, height: 115)
                    Circle()
                        .trim(from: 0.025, to: CGFloat(Double(nearExpiryItem) / Double(totalInventory) - 0.025))
                        .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color("DangerColor"))
                        .rotationEffect(Angle(degrees: 270))
                        .frame(width: 115, height: 115)
                }
                
                ZStack {
                    Circle()
                        .fill(Color("GrayColor"))
                        .frame(width: 80, height: 80)
                    Text(String(nearExpiryItem) + "\nitems")
                        .multilineTextAlignment(.center)
                        .font(.system(.headline, design: .rounded))
                }
            }
            Spacer()
            Text("Expires in 3 days\nor less")
                .multilineTextAlignment(.center)
                .font(.system(.body, design: .rounded))
            Spacer()
        }
    }
    
    func calculateBackCircleRotationAngle(numerator: Int, denumerator: Int) -> Double {
        let angle = Double(numerator) / Double(denumerator) * 360
        return angle - 90
    }
    
}

struct ExpireSoonProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ExpireSoonProgressBarView()
    }
}
