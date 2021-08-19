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
                ZStack {
                    if nearExpiryItem == 0 || nearExpiryItem == totalInventory {
                        Circle()
                            .trim(from: 0.0, to: CGFloat(1 - (Double(nearExpiryItem) / Double(totalInventory))))
                            .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                            .opacity(0.3)
                            .foregroundColor(Color(.green))
                            .rotationEffect(Angle(degrees: calculateBackCircleRotationAngle(numerator: nearExpiryItem, denumerator: totalInventory)))
                            .frame(width: 135, height: 135)
                        Circle()
                            .trim(from: 0.0, to: CGFloat(Double(nearExpiryItem) / Double(totalInventory)))
                            .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color(.red))
                            .rotationEffect(Angle(degrees: 270))
                            .frame(width: 135, height: 135)
                    } else {
                        Circle()
                            .trim(from: 0.025, to: CGFloat(0.975 - (Double(nearExpiryItem) / Double(totalInventory))))
                            .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                            .opacity(0.3)
                            .foregroundColor(Color(.green))
                            .rotationEffect(Angle(degrees: calculateBackCircleRotationAngle(numerator: nearExpiryItem, denumerator: totalInventory)))
                            .frame(width: 135, height: 135)
                        Circle()
                            .trim(from: 0.025, to: CGFloat(Double(nearExpiryItem) / Double(totalInventory) - 0.025))
                            .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color(.red))
                            .rotationEffect(Angle(degrees: 270))
                            .frame(width: 135, height: 135)
                    }
                    
                    Text(String(nearExpiryItem) + "\nItems")
                        .multilineTextAlignment(.center)
                }.navigationTitle("Expiremind")
                .padding()
            Spacer()
            Text("Expires in 3 days or less")
                .multilineTextAlignment(.center)
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