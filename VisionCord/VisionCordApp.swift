//
//  VisionCordApp.swift
//  VisionCord
//
//  Created by Sneh Nilesh on 30/12/24.
//

import SwiftUI

@main
struct VisionCordApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
				.glassBackgroundEffect(in: .rect(cornerRadius: 24))
        }
		.windowStyle(.plain)
    }
}
