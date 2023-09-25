//
//  ChiefEndWidget.swift
//  Westminster Standards WatchKit Extension
//
//  Created by Matt Robertson on 6/14/23.
//

import SwiftUI
import WidgetKit

struct ChiefEndWidgetView: View {
    var body: some View {
        Text("Glorify God").bold() + Text("\nand enjoy Him forever.")
    }
}

@main
struct ChiefEndWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "com.mattrobertson.Westminster-Standards.watchkitapp.watchkitextension",
            provider: Provider()
        ) { entry in
            ChiefEndWidgetView()
        }
        .configurationDisplayName("Westminster Chief End")
        .description("WSC Q1")
        
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ChiefEndEntry {
        ChiefEndEntry(date: Date(), text: "Glorify God and enjoy Him forever")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ChiefEndEntry) -> Void) {
        let entry = ChiefEndEntry(date: Date(), text: "Glorify God and enjoy Him forever")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ChiefEndEntry>) -> Void) {
        let entry = ChiefEndEntry(date: Date(), text: "Glorify God and enjoy Him forever")
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct ChiefEndEntry: TimelineEntry {
    let date: Date
    let text: String
}
