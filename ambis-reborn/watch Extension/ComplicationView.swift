//
//  ComplicationView.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 19/08/21.
//

import SwiftUI
import ClockKit

func ComplicationCircularCalculate(numerator: Int, denumerator: Int) -> Double {
    let angle = Double(numerator) / Double(denumerator) * 360
    return angle - 90
}

struct TemplateGraphicCircularView: View {
    
    @State var nearExpiryItem: Int = 4
    @State var totalInventory: Int = 16
    
    var body: some View {
        ZStack {
            if nearExpiryItem == 0 || nearExpiryItem == totalInventory {
                Circle()
                    .trim(from: 0.0, to: CGFloat(1 - (Double(nearExpiryItem) / Double(totalInventory))))
                    .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                    .opacity(0.3)
                    .foregroundColor(Color("SuccessColor"))
                    .rotationEffect(Angle(degrees: ComplicationCircularCalculate(numerator: nearExpiryItem, denumerator: totalInventory)))
                    .frame(width: 48)
                Circle()
                    .trim(from: 0.0, to: CGFloat(Double(nearExpiryItem) / Double(totalInventory)))
                    .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color("DangerColor"))
                    .rotationEffect(Angle(degrees: 270))
                    .frame(width: 48)
            } else {
                Circle()
                    .trim(from: 0.05, to: CGFloat(0.95 - (Double(nearExpiryItem) / Double(totalInventory))))
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color("SuccessColorTransparent"))
                    .rotationEffect(Angle(degrees: ComplicationCircularCalculate(numerator: nearExpiryItem, denumerator: totalInventory)))
                    .frame(width: 48)
                Circle()
                    .trim(from: 0.05, to: CGFloat(Double(nearExpiryItem) / Double(totalInventory) - 0.05))
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color("DangerColor"))
                    .rotationEffect(Angle(degrees: 270))
                    .frame(width: 48)
            }
            
            ZStack {
                Image("BrandIcon")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
}

struct TemplateGraphicRectangularFullView: View {
    @State var nearExpiryItem: Int = 4
    @State var totalInventory: Int = 16
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading) {
                Text("\(nearExpiryItem)/\(totalInventory) ITEMS")
                    .font(.system(.body, design: .rounded))
                Text("Expires in 3 days or less")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)
                ProgressView(value: Float(nearExpiryItem), total: Float(totalInventory)).progressViewStyle(LinearProgressViewStyle(tint: Color("BrandColor")))
                HStack {
                    Text("\(nearExpiryItem)")
                        .font(.system(.subheadline, design: .rounded))
                    Spacer()
                    Text("\(totalInventory)")
                        .font(.system(.subheadline, design: .rounded))
                }
            }
        }
    }
    
}

struct TemplateGraphicExtraLargeCircularView: View {
    @State var nearExpiryItem: Int = 4
    @State var totalInventory: Int = 16
    
    var body: some View {
        ZStack {
            if nearExpiryItem == 0 || nearExpiryItem == totalInventory {
                Circle()
                    .trim(from: 0.0, to: CGFloat(1 - (Double(nearExpiryItem) / Double(totalInventory))))
                    .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                    .opacity(0.3)
                    .foregroundColor(Color("SuccessColor"))
                    .rotationEffect(Angle(degrees: ComplicationCircularCalculate(numerator: nearExpiryItem, denumerator: totalInventory)))
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
                    .opacity(0.3)
                    .foregroundColor(Color("SuccessColor"))
                    .rotationEffect(Angle(degrees: ComplicationCircularCalculate(numerator: nearExpiryItem, denumerator: totalInventory)))
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
                Text(String(nearExpiryItem) + "\nItems")
                    .multilineTextAlignment(.center)
                    .font(.system(.headline, design: .rounded))
            }
        }
    }
}

struct ComplicationView: View {
    var body: some View {
      ZStack {
          ProgressView(value: (1.0 - 0.9), total: 1.0)
              .progressViewStyle(CircularProgressViewStyle(tint: .red))
      }
    }
}

struct ComplicationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CLKComplicationTemplateGraphicExtraLargeCircularView(
                TemplateGraphicExtraLargeCircularView()
            )
            .previewContext()
            
            CLKComplicationTemplateGraphicRectangularFullView(
                TemplateGraphicRectangularFullView()
            ).previewContext()
            
            CLKComplicationTemplateGraphicCircularView(
                TemplateGraphicCircularView()
            )
            .previewContext()
        }
    }
}
