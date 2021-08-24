//
//  ComplicationView.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 19/08/21.
//

import SwiftUI
import ClockKit
import CoreData

func ComplicationCircularCalculate(numerator: Int, denumerator: Int) -> Double {
    let angle = Double(numerator) / Double(denumerator) * 360
    return angle - 90
}

struct TemplateGraphicCircularView: View {
    
    var body: some View {
        ZStack {
            Image("BrandIcon")
                .resizable()
                .scaledToFill()
        }
    }
}

struct sampleInventory {
    var name: String
    var dayUntilExpiry: Int
}
struct TemplateGraphicRectangularFullView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Inventory.expiryDate, ascending: true)], animation: .default)
    private var myInvent: FetchedResults<Inventory>

    @State var sample: [sampleInventory] = [sampleInventory(name: "Paha", dayUntilExpiry: 7)]

    @State var firstText: String = "Expiring in 3 days or less"
    @State var secondText: String = "Paha Ayam"
    @State var thirdText: String = "and 4 other items"
    @State var bgColor: Color = Color("DangerColorTransparent")
    
    func setupData() {
        let dateNow = Date()
        let todayDate = Date().addingTimeInterval(24 * 60 * 60)
        let tomorrowDate = Date().addingTimeInterval(24 * 60 * 60 * 2)
        let dangerDate = Date().addingTimeInterval(24 * 60 * 60 * 4)
        
        if myInvent.isEmpty || myInvent[0].expiryDate! > dangerDate {
            firstText = "You're good!"
            secondText = "No worries!"
            thirdText = "Nothing's expiring"
            bgColor = Color("SuccessColorTransparent")
        } else if !myInvent.isEmpty {
            secondText = myInvent[0].name!
            if myInvent.count == 1 {
                thirdText = "use it soon!"
            } else {
                thirdText = "and \(myInvent.count - 1) other items"
            }
            if myInvent[0].expiryDate! < dateNow {
                firstText = "Expired"
                thirdText = "Don't do it again :("
            } else if myInvent[0].expiryDate! < todayDate {
                firstText = "Expiring today"
            } else if myInvent[0].expiryDate! < tomorrowDate {
                firstText = "Expiring tomorrow"
            } else {
                firstText = "Expiring in 3 days or less"
                bgColor = Color("WarningColorTransparent")
            }
        }
        
    }
    
//    func adjustTextView(sample: [sampleInventory]) {
//        if sample.isEmpty || sample[0].dayUntilExpiry > 3 {
//            firstText = "You're good!"
//            secondText = "No worries!"
//            thirdText = "Nothing's expiring"
//            bgColor = Color("SuccessColorTransparent")
//        } else if !sample.isEmpty {
//            secondText = sample[0].name
//            if sample.count == 1 {
//                thirdText = "use it soon!"
//            } else {
//                thirdText = "and \(sample.count - 1) other items"
//            }
//            if sample[0].dayUntilExpiry < 0 {
//                firstText = "Expired"
//                thirdText = "Don't do it again :("
//            } else if sample[0].dayUntilExpiry == 0 {
//                firstText = "Expiring today"
//            } else if sample[0].dayUntilExpiry == 1 {
//                firstText = "Expiring tomorrow"
//            } else {
//                firstText = "Expiring in 3 days or less"
//                bgColor = Color("WarningColorTransparent")
//            }
//        }
//    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(bgColor)
                    .complicationForeground()
                    .ignoresSafeArea(.all, edges: .horizontal)
                HStack() {
                    Text(firstText)
                        .font(.system(size: 14))
                        .padding(.vertical, 7)
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
            setupData()
        }
    }
    
}

struct TemplateGraphicExtraLargeCircularView: View {
    @State var sample: [sampleInventory] = [sampleInventory(name: "Paha", dayUntilExpiry: 7)]
    
    var body: some View {
//        if sample.isEmpty || sample[0].dayUntilExpiry > 3 {
//            VStack {
//                Text("CONGRATS!!")
//                Text("No item in your inventory is expiring soon")
//                Text("Maybe it's time to plan your next meal?")
//            }
//        } else {
//            Text("Your items:")
//
//        }
        ZStack {
            Image("BrandIcon")
                .resizable()
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
            
            CLKComplicationTemplateGraphicCircularView(
                TemplateGraphicCircularView()
            ).previewContext(faceColor: .yellow)
            
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
