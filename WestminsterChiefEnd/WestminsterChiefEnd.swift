//
//  WestminsterChiefEnd.swift
//  WestminsterChiefEnd
//
//  Created by Matt Robertson on 6/14/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct WestminsterChiefEndEntryView : View {
    var body: some View {
        VStack {
            Text("Glorify God")
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("enjoy Him forever")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

@main
struct WestminsterChiefEnd: Widget {
    let kind: String = "WestminsterChiefEnd"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WestminsterChiefEndEntryView()
        }
        .configurationDisplayName("Chief End")
        .description("What is the chief end of man?")
    }
}

struct WestminsterChiefEnd_Previews: PreviewProvider {
    static var previews: some View {
        WestminsterChiefEndEntryView()
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
