//
//  ComplicationController.swift
//  WestminsterWatch Watch App
//
//  Created by Matt Robertson on 6/14/23.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    func complicationDescriptors() async -> [CLKComplicationDescriptor] {
        [CLKComplicationDescriptor(
            identifier: "com.mattrobertson.WestminsterStandards.widgetkit-extension",
            displayName: "Westminster Standards",
            supportedFamilies: CLKComplicationFamily.allCases)]
    }
    func currentTimelineEntry(for complication: CLKComplication) async -> CLKComplicationTimelineEntry? { nil }
}
