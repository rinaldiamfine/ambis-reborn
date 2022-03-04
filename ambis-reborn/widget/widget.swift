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
    @AppStorage("expiry", store: UserDefaults(suiteName: "group.widget.inventory")) var groupWidgetInventory : Data = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), inventory: WidgetInventoryModel(inventory: []))
    }
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, inventory: setupExpireData())
        completion(entry)
    }
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let entry = SimpleEntry(date: Date(), configuration: configuration, inventory: setupExpireData())
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    func setupExpireData() -> WidgetInventoryModel {
        guard let expire = try? JSONDecoder().decode(WidgetInventoryModel.self, from: groupWidgetInventory) else{
            return WidgetInventoryModel(inventory: [])
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
    @State private var backgroundColor = Color("BackgroundColor")

    var body: some View {
        switch family {
        case .systemSmall:
            smallWidget
        case .systemMedium:
            mediumWidget
//        case .systemLarge:
//            largeWidget
        default:
            smallWidget
        }
    }
    
    var smallWidget: some View {
        GeometryReader(content: { geometry in
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                HStack{
                    Text("")
                }
                .frame(width: geometry.size.width, height: geometry.size.height*15/100)
                .background(Color("BrandColor"))
                HStack{
                    VStack {
                        if entry.inventory.inventory.isEmpty {
                            ZStack {
                                Ellipse()
                                    .fill(Color.init(UIColor.systemGray5))
                                    .frame(width: 60, height: 60)
                                Image(systemName: "bag").font(.system(size: 20))
                                    .foregroundColor(Color(.systemGray))
                            }
                            HStack(alignment: .center) {
                                Text("Great. None of your\nitems are expiring soon.")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.init(UIColor.systemGray))
                                    .padding(10)
                                    .font(.system(size: 12, design: .rounded))
                            }
                        } else {
                            Spacer()
                            ZStack {
                                Circle()
                                    .stroke(lineWidth: 10.0)
                                    .opacity(0.3)
                                    .foregroundColor(Color("BrandColor"))
                                    .frame(width: 70, height: 70)
                                Circle()
                                    .trim(from: 0.0, to: CGFloat(entry.inventory.progressBar))
                                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                    .foregroundColor(Color("BrandColor"))
                                    .frame(width: 70, height: 70)
                                VStack {
                                    Text("\(entry.inventory.totalExpiry)/\(entry.inventory.totalInventory)").font(.system(size: 12, design: .rounded))
                                    Text("items").font(.system(size: 8, design: .rounded))
                                }
                            }
                            .frame(width: geometry.size.width)
                            Spacer()
                            Text("Expires in 3 days or less")
                                .fontWeight(.semibold)
                                .font(.system(size: 10, design: .rounded))
                            Spacer()
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height*85/100)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        })
    }
    
    var mediumWidget: some View {
        GeometryReader(content: { geometry in
            VStack {
                HStack{
                    VStack {
                        Text(" ")
                    }
                    .frame(width: geometry.size.width*10/100, height: geometry.size.height)
                    .background(Color("BrandColor"))
                    
                    if entry.inventory.inventory.isEmpty {
                        VStack {
                            ZStack {
                                Ellipse()
                                    .fill(Color.init(UIColor.systemGray5))
                                    .frame(width: 80, height: 80)
                                Image(systemName: "bag").font(.system(size: 30))
                                    .foregroundColor(Color(.systemGray))
                            }
                            HStack(alignment: .center) {
                                Text("Great. None of your\nitems are expiring soon.")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.init(UIColor.systemGray))
                                    .padding(10)
                                    .font(.system(size: 14, design: .rounded))
                            }
                        }
                        .frame(width: geometry.size.width*80/100, height: geometry.size.height)
                        
                        VStack {
                            Text(" ")
                        }
                        .frame(width: geometry.size.width*10/100, height: geometry.size.height)
                    } else {
                        VStack {
                            HStack {
                                VStack {
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 10.0)
                                            .opacity(0.3)
                                            .foregroundColor(Color("BrandColor"))
                                            .frame(width: 70, height: 70)
                                        Circle()
                                            .trim(from: 0.0, to: CGFloat(entry.inventory.progressBar))
                                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                                            .foregroundColor(Color("BrandColor"))
                                            .frame(width: 70, height: 70)
                                        VStack {
                                            Text("\(entry.inventory.totalExpiry)/\(entry.inventory.totalInventory)").font(.system(size: 12, design: .rounded))
                                            Text("items").font(.system(size: 8, design: .rounded))
                                        }
                                    }
                                    .frame(width: geometry.size.width/2)
                                    Spacer()
                                    Text("Expires in 3 days or less")
                                        .fontWeight(.semibold)
                                        .font(.system(size: 10, design: .rounded))
                                    Spacer()
                                }
                                .frame(width: geometry.size.width/2-geometry.size.width*10/100)
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach (0..<entry.inventory.inventory.count) { data in
                                        if data < 3 {
                                            MediumListContentView(
                                                widgetInventoryModel: entry.inventory.inventory[data])
                                                .frame(height: geometry.size.height/3)
                                        }
                                    }
                                }
                                .frame(width: geometry.size.width/2, height: geometry.size.height, alignment: .topLeading)
                            }
                        }
                        .frame(width: geometry.size.width*90/100, height: geometry.size.height)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        })
    }
    
    var largeWidget: some View {
        GeometryReader(content: { geometry in
            VStack(spacing: 0) {
                HStack{
                    Text("Expire Soon")
                        .fontWeight(.bold)
                        .padding(.horizontal, 15)
                        .font(.system(size: 25, design: .rounded))
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .background(Color("BrandColor"))
                
                HStack(alignment: .top) {
                    if entry.inventory.inventory.isEmpty {
                        VStack {
                            ZStack {
                                Ellipse()
                                    .fill(Color.init(UIColor.systemGray5))
                                    .frame(width: 100, height: 100)
                                Image(systemName: "bag").font(.system(size: 40))
                                    .foregroundColor(Color(.systemGray))
                            }
                            HStack(alignment: .center) {
                                Text("Great. None of your\nitems are expiring soon.")
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.init(UIColor.systemGray))
                                    .padding(10)
                                    .font(.system(size: 14, design: .rounded))
                            }
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach (0..<entry.inventory.inventory.count) { data in
                                if data < 4 {
                                    LargeListContentView(content: entry.inventory.inventory[data])
                                        .frame(width: geometry.size.width, height: (geometry.size.height-(2*geometry.size.height/8))/4)
                                }
                            }
                        }.frame(width: geometry.size.width, height: (geometry.size.height-(2*geometry.size.height/8)), alignment: .topLeading)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height-(2*geometry.size.height/8))
                .background(backgroundColor)
                
                HStack{
                    if entry.inventory.inventory.count > 4 {
                        Text("\(entry.inventory.inventory.count-4) More items")
                            .font(.system(size: 13, design: .rounded))
                    } else {
                        Text(" ")
                            .font(.system(size: 13, design: .rounded))
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .background(backgroundColor)
            }
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
//        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
        widgetEntryView(
            entry: SimpleEntry(
                date: Date(),
                configuration: ConfigurationIntent(),
                inventory: WidgetInventoryModel(
                    inventory: [])))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
