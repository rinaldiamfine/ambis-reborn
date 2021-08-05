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


struct widgetListDataFormat {
    var icon: String
    var title: String
    var formatQty: String
    var store: String
}

struct mediumListContentView: View {
    @State var data : widgetListDataFormat
    @State private var iconBackground1 = Color("IconBackground1")
    @State private var iconBackground2 = Color("IconBackground2")
    
    var body: some View {
        HStack {
            ZStack {
                Ellipse()
                    .fill(LinearGradient(
                        gradient: .init(colors: [iconBackground1, iconBackground2]),
                        startPoint: .init(x: 0, y: 0.5),
                        endPoint: .init(x: 0.8, y: 0.5)
                    ))
                    .frame(width: 40, height: 40)
                Text(data.icon).font(.system(size: 24))
            }
            .padding(.leading, 10)
            VStack(alignment: .leading) {
                Text(data.title).font(.system(size: 13, design: .rounded))
                HStack {
                    Text(data.store).font(.system(size: 10, design: .rounded))
                    Text(data.formatQty).font(.system(size: 10, design: .rounded))
                }
            }
        }
    }
}

struct largeListContentView: View {
    @State var data : widgetListDataFormat
    @State private var iconBackground1 = Color("IconBackground1")
    @State private var iconBackground2 = Color("IconBackground2")
    
    @State private var cellColor = Color("IconBackground1")
    
    var body: some View {
        HStack {
            ZStack {
                Ellipse()
                    .fill(LinearGradient(
                        gradient: .init(colors: [iconBackground1, iconBackground2]),
                        startPoint: .init(x: 0, y: 0.5),
                        endPoint: .init(x: 0.8, y: 0.5)
                    ))
                    .frame(width: 40, height: 40)
                Text(data.icon).font(.system(size: 24))
            }
            .padding(.leading, 10)
            VStack(alignment: .leading) {
                Text(data.title).font(.system(size: 13, design: .rounded))
                HStack {
                    Text(data.store).font(.system(size: 10, design: .rounded))
                    Text(data.formatQty).font(.system(size: 10, design: .rounded))
                }
            }
            Spacer()
            HStack {
                Text("EXPIRED")
                    .font(.system(size: 13, design: .rounded))
                    .padding(.horizontal, 10)
            }
        }
        .padding(.vertical, 7)
        .background(RoundedRectangle(cornerRadius: 15).fill(cellColor))
        .padding(.horizontal, 15)
    }
}

struct widgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
//    @StateObject var inventoryModel = WidgetInventoryViewModel()
//    @State var totalExpiry: Int = 5
//    @State var totalInventory: Int = 25
    @State var progressValue: Float = 0.0
    @State private var backgroundColor = Color("BackgroundColor")
    
    var defaultData : [widgetListDataFormat] = [
        widgetListDataFormat(icon: "🥩", title: "Ayam", formatQty: "1 Kg", store: "Freezer"),
        widgetListDataFormat(icon: "🥦", title: "Sayur", formatQty: "5 Pcs", store: "Fridge"),
        widgetListDataFormat(icon: "🍒", title: "Apel", formatQty: "10 Pcs", store: "Fridge"),
        widgetListDataFormat(icon: "🧀", title: "Susu", formatQty: "1 Pcs", store: "Fridge")
    ]

    var body: some View {
        switch family {
        case .systemSmall:
            smallWidget
        case .systemMedium:
            mediumWidget
        case .systemLarge:
            largeWidget
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
                            
                            VStack(alignment: .leading) {
                                //ONLY 3
                                ForEach (0..<3) { data in
                                    mediumListContentView(data: defaultData[data])
                                        .frame(width: geometry.size.width*90/100/2, height: geometry.size.height/4)
//                                        .background(Color(.red))
                                }
                            }
                            .frame(width: geometry.size.width/2, height: geometry.size.height)
                        }
                    }
                    .frame(width: geometry.size.width*90/100, height: geometry.size.height)
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
                    Image("WidgetImage")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .topTrailing)
                        .padding(.horizontal, 15)
                }
                .frame(width: geometry.size.width, height: geometry.size.height/8)
                .background(Color("BrandColor"))
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        ForEach (0..<defaultData.count) { data in
                            largeListContentView(data: defaultData[data])
                                .frame(width: geometry.size.width)
                        }
                        
                    }.frame(width: geometry.size.width)
                }
                .frame(width: geometry.size.width, height: geometry.size.height-(2*geometry.size.height/8))
                .background(backgroundColor)
                
                HStack{
                    Text("2 More items")
                        .font(.system(size: 13, design: .rounded))
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
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
        widgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), inventory: WidgetInventoryModel(totalExpiry: 0, totalInventory: 0, progressBar: 0.0)))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
