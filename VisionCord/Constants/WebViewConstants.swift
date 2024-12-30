//
//  WebViewConstants.swift
//  VisionCord
//
//  Created by Sneh Nilesh on 30/12/24.
//

import Foundation

enum WebViewConstants {
	static let discordURL = URL(string: "https://discord.com/channels/@me")!

	static let userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1"

	static let defaultHeaders: [String: String] = [
		"Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
		"Accept-Language": "en-US,en;q=0.5",
		"Connection": "keep-alive",
		"Upgrade-Insecure-Requests": "1"
	]
}
