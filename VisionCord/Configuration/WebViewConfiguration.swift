//
//  WebViewConfiguration.swift
//  VisionCord
//
//  Created by Sneh Nilesh on 30/12/24.
//

import WebKit

struct WebViewConfiguration {
	static func create() -> WKWebViewConfiguration {
		let configuration = WKWebViewConfiguration()

		configureMediaPlayback(configuration)
		configureWebsiteData(configuration)
		configureJavaScript(configuration)
		configureUserAgent(configuration)
		addBackgroundRemovalScript(configuration)

		return configuration
	}

	private static func configureMediaPlayback(_ configuration: WKWebViewConfiguration) {
		configuration.allowsInlineMediaPlayback = true
		configuration.mediaTypesRequiringUserActionForPlayback = .all
		configuration.allowsPictureInPictureMediaPlayback = true
		configuration.allowsAirPlayForMediaPlayback = true
	}

	private static func configureWebsiteData(_ configuration: WKWebViewConfiguration) {
		configuration.websiteDataStore = .default()
		configuration.processPool = WKProcessPool()
		configuration.preferences.isFraudulentWebsiteWarningEnabled = true
	}

	private static func configureJavaScript(_ configuration: WKWebViewConfiguration) {
		configuration.defaultWebpagePreferences.allowsContentJavaScript = true
		configuration.preferences.javaScriptCanOpenWindowsAutomatically = true

		if #available(iOS 16.4, *) {
			configuration.preferences.isElementFullscreenEnabled = true
			configuration.preferences.isSiteSpecificQuirksModeEnabled = true
		}
	}

	private static func configureUserAgent(_ configuration: WKWebViewConfiguration) {
		configuration.applicationNameForUserAgent = WebViewConstants.userAgent
	}

	private static func addBackgroundRemovalScript(_ configuration: WKWebViewConfiguration) {
		configuration.userContentController.addUserScript(
			BackgroundRemovalScript.create()
		)
	}
}
