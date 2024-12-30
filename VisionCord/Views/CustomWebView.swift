//
//  CustomWebView.swift
//  VisionCord
//
//  Created by Sneh Nilesh on 30/12/24.
//

import SwiftUI
import WebKit

struct CustomWebView: UIViewRepresentable {
	let url: URL

	func makeCoordinator() -> WebViewCoordinator {
		WebViewCoordinator(self)
	}

	func makeUIView(context: Context) -> WKWebView {
		let configuration = WebViewConfiguration.create()
		let webView = WKWebView(frame: .zero, configuration: configuration)

		configureWebView(webView, with: context.coordinator)
		loadInitialRequest(in: webView)

		return webView
	}

	func updateUIView(_ webView: WKWebView, context: Context) {}

	private func configureWebView(_ webView: WKWebView, with coordinator: WebViewCoordinator) {
		webView.navigationDelegate = coordinator
		webView.uiDelegate = coordinator
		webView.isOpaque = false
		webView.backgroundColor = .clear
		webView.scrollView.backgroundColor = .clear
		webView.allowsBackForwardNavigationGestures = true
	}

	private func loadInitialRequest(in webView: WKWebView) {
		var request = URLRequest(url: url)
		request.allHTTPHeaderFields = WebViewConstants.defaultHeaders
		webView.load(request)
	}
}

