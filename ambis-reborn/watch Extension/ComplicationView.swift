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
            Image("BrandIcon")
                .resizable()
        }
    }
}

struct sampleInventory {
    var name: String
    var dayUntilExpiry: Int
}
struct TemplateGraphicRectangularFullView: View {
    @State var sample: [sampleInventory] = [sampleInventory(name: "Paha", dayUntilExpiry: 7)]
    
    @Environment(\.complicationRenderingMode) var renderingMode
    
    @State var firstText: String = "Expiring in 3 days or less"
    @State var secondText: String = "Paha Ayam"
    @State var thirdText: String = "and 4 other items"
    @State var bgColor: Color = Color("DangerColorTransparent")
    
    func adjustTextView(sample: [sampleInventory]) {
        if sample.isEmpty || sample[0].dayUntilExpiry > 3 {
            firstText = "You're good!"
            secondText = "No worries!"
            thirdText = "Nothing's expiring"
            bgColor = Color("SuccessColorTransparent")
        } else if !sample.isEmpty {
            secondText = sample[0].name
            if sample.count == 1 {
                thirdText = "use it soon!"
            } else {
                thirdText = "and \(sample.count - 1) other items"
            }
            if sample[0].dayUntilExpiry < 0 {
                firstText = "Expired"
                thirdText = "Don't do it again :("
            } else if sample[0].dayUntilExpiry == 0 {
                firstText = "Expiring today"
            } else if sample[0].dayUntilExpiry == 1 {
                firstText = "Expiring tomorrow"
            } else {
                firstText = "Expiring in 3 days or less"
                bgColor = Color("WarningColorTransparent")
            }
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(bgColor)
                    .complicationForeground()
                HStack {
                    Text(firstText)
                        .font(.system(size: 14))
                        .padding()
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    Spacer()
                }
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(secondText)
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                    Text(thirdText)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }.padding(.horizontal)
                Spacer()
            }
        }.onAppear{
            adjustTextView(sample: sample)
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
            CLKComplicationTemplateGraphicCircularView(
                TemplateGraphicCircularView()
            ).previewContext()
            
            CLKComplicationTemplateGraphicRectangularFullView(
                TemplateGraphicRectangularFullView(sample: [sampleInventory(name: "Paha", dayUntilExpiry: 7)])
            ).previewContext(faceColor: .blue)
            //1
            CLKComplicationTemplateGraphicRectangularFullView(
                TemplateGraphicRectangularFullView(sample: [sampleInventory(name: "Paha", dayUntilExpiry: 7)])
            ).previewContext()
            //2
            CLKComplicationTemplateGraphicRectangularFullView(
                TemplateGraphicRectangularFullView(sample: [sampleInventory(name: "Paha Ayam", dayUntilExpiry: 3)])
            ).previewContext()
            //3
            CLKComplicationTemplateGraphicRectangularFullView(
                TemplateGraphicRectangularFullView(sample: [sampleInventory(name: "Paha Ayam", dayUntilExpiry: 2), sampleInventory(name: "Paha Sapi", dayUntilExpiry: 3)])
            ).previewContext()
            //4
            CLKComplicationTemplateGraphicRectangularFullView(
                TemplateGraphicRectangularFullView(sample: [sampleInventory(name: "Paha Ayam", dayUntilExpiry: 1)])
            ).previewContext()
            //5
            CLKComplicationTemplateGraphicRectangularFullView(
                TemplateGraphicRectangularFullView(sample: [sampleInventory(name: "Paha Ayam", dayUntilExpiry: 0)])
            ).previewContext()
            //6
            CLKComplicationTemplateGraphicRectangularFullView(
                TemplateGraphicRectangularFullView(sample: [sampleInventory(name: "Paha Kerbau", dayUntilExpiry: -2)])
            ).previewContext()
            
            CLKComplicationTemplateGraphicExtraLargeCircularView(
                TemplateGraphicExtraLargeCircularView()
            ).previewContext()
            
        }
    }
}
