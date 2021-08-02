//
//  widget.swift
//  widget
//
//  Created by Rinaldi LNU on 23/07/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    @AppStorage("expiry", store: UserDefaults(suiteName: "group.inventoryUD")) var inventoryData : Data = Data()
//    guard let widgetGetExpiry = try? JSONDecoder().decode(WidgetInventoryModel.self, from: inventoryData) else { return }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), inventory: WidgetInventoryModel(totalExpiry: 0, totalInventory: 0, progressBar: 0.0))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, inventory: setupExpireData())
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        
        let entry = SimpleEntry(date: Date(), configuration: configuration, inventory: setupExpireData())
        entries.append(entry)
        
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func setupExpireData() -> WidgetInventoryModel {
        guard let expire = try? JSONDecoder().decode(WidgetInventoryModel.self, from: inventoryData) else{
            return WidgetInventoryModel(totalExpiry: 0, totalInventory: 0, progressBar: 0.0)
        }
        return expire
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let inventory: WidgetInventoryModel
}

struct widgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
//    @StateObject var inventoryModel = WidgetInventoryViewModel()
//    @State var totalExpiry: Int = 5
//    @State var totalInventory: Int = 25
    @State var progressValue: Float = 0.0

    var body: some View {
        switch family {
        case .systemSmall:
            smallWidget
        case .systemMedium:
            smallWidget
        case .systemLarge:
            smallWidget
        default:
            smallWidget
        }
    }
    
    var smallWidget: some View {
        GeometryReader(content: { geometry in
            HStack(spacing:10) {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 10.0)
                        .opacity(0.3)
                        .foregroundColor(Color("BrandColor"))
                        .frame(width: geometry.size.width/2, height: geometry.size.width/2)
                    Circle()
                        .trim(from: 0.0, to: CGFloat(entry.inventory.progressBar))
                        .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color("BrandColor"))
                        .frame(width: geometry.size.width/2, height: geometry.size.width/2)
                    VStack {
                        Text("\(entry.inventory.totalExpiry)/\(entry.inventory.totalInventory)").font(.system(size: 12, design: .rounded))
                        Text("Items").font(.system(size: 8, design: .rounded))
                    }
                }
                .frame(width: geometry.size.width)
            }
            .frame(height: geometry.size.height)
        })
    }
}

@main
struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
        }
        .configurationDisplayName("ExpiRemind Widget")
        .description("This is an ExpiRemind widget.")
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
        widgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), inventory: WidgetInventoryModel(totalExpiry: 0, totalInventory: 0, progressBar: 0.0)))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
