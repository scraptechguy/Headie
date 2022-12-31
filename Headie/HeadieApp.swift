//
//  HeadieApp.swift
//  Headie
//
//  Created by Rostislav Brož on 12/29/22.
//

import SwiftUI

@main
struct HeadieApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
