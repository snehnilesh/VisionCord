//
//  WebViewCoordinator.swift
//  VisionCord
//
//  Created by Sneh Nilesh on 30/12/24.
//

import WebKit

class WebViewCoordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
	private let parent: CustomWebView

	init(_ parent: CustomWebView) {
		self.parent = parent
	}

	func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
		if let url = navigationAction.request.url {
			UIApplication.shared.open(url)
		}
		return nil
	}
}
