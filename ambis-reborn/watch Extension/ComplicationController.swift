//
//  ComplicationController.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 18/08/21.
//

import ClockKit
import SwiftUI

class ComplicationController: NSObject, CLKComplicationDataSource {
    @State var dataInventory : [FormatInventory] = [
        FormatInventory(title: "Paha Ayam", subtitle: "Fridge ・ 1Kg", expiryInt: 3, icon: "🥩"),
        FormatInventory(title: "Sayur", subtitle: "Freezer ・ 10Pcs", expiryInt: 5, icon: "🥦")
    ]
    
    let expiRemindComplication: [CLKComplicationFamily] = [.graphicCircular, .graphicExtraLarge, .modularLarge]
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
//            CLKComplicationDescriptor(identifier: "complication", displayName: "ambis-reborn", supportedFamilies: CLKComplicationFamily.allCases)
            CLKComplicationDescriptor(identifier: "complication", displayName: "ExpiRemind", supportedFamilies: expiRemindComplication)
            // Multiple complication support can be added here with more descriptors
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
//        handler(nil)
        
//        if let next = dataController.nextAppointment(from: Date()),
        if 1 == 1,
             let template = makeTemplate(for: dataInventory, complication: complication) {
             let entry = CLKComplicationTimelineEntry(
               date: Date(),
               complicationTemplate: template)
             handler(entry)
        } else {
          handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after the given date
        handler(nil)
    }

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
}

extension ComplicationController {
    func makeTemplate(for formatInventory: [FormatInventory], complication: CLKComplication) -> CLKComplicationTemplate? {
        switch complication.family {
        //[.graphicCircular, .graphicExtraLarge, .modularLarge]
        case .graphicCircular:
            return CLKComplicationTemplateGraphicCircularView(
                TemplateGraphicCircularView()
            )
        case .modularLarge:
            return CLKComplicationTemplateGraphicCircularView(
                TemplateGraphicRectangularFullView()
            )
        case .graphicExtraLarge:
            return CLKComplicationTemplateGraphicExtraLargeCircularView(
                TemplateGraphicExtraLargeCircularView()
            )
        default:
              return nil
        }
    }
}
