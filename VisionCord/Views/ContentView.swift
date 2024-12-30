//
//  ContentView.swift
//  VisionCord
//
//  Created by Sneh Nilesh on 30/12/24.
//

import SwiftUI
@preconcurrency import WebKit

struct ContentView: View {
	var body: some View {
		CustomWebView(
			url: WebViewConstants.discordURL
		)
	}
}
