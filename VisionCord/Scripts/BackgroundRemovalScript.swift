//
//  BackgroundRemovalScript.swift
//  VisionCord
//
//  Created by Sneh Nilesh on 30/12/24.
//

import WebKit

enum BackgroundRemovalScript {
	static func create() -> WKUserScript {
		WKUserScript(
			source: scriptContent,
			injectionTime: .atDocumentEnd,
			forMainFrameOnly: false
		)
	}

	private static let scriptContent = #"""
			function removeBackgrounds() {
				function getAlphaValue(backgroundColor) {
					let result = 1;
					if (backgroundColor.startsWith('rgba')) {
						let matches = backgroundColor.match(/rgba$$\d+,\s*\d+,\s*\d+,\s*(\d*\.?\d+)$$/);
						if (matches && matches.length === 2) {
							result = parseFloat(matches[1]);
						}
					} else if (backgroundColor === 'transparent') {
						result = 0;
					}
					return result;
				}

				function isModalOverlay(element) {
					const computedStyle = window.getComputedStyle(element);
					const position = computedStyle.position;
					const zIndex = parseInt(computedStyle.zIndex);
					const bgColor = computedStyle.backgroundColor;
					const alpha = getAlphaValue(bgColor);
					const isLargeElement = (
						element.offsetWidth >= window.innerWidth * 0.9 ||
						element.offsetHeight >= window.innerHeight * 0.9
					);

					return (position === 'fixed' || position === 'absolute') &&
						   zIndex > 0 &&
						   alpha > 0 && alpha < 1 &&
						   isLargeElement;
				}

				function shouldPreserveElement(element) {
					const preserveSelectors = [
						'[role="dialog"]',
						'[aria-modal="true"]',
						'.modal',
						'.popup',
						'.overlay',
						'[class*="modal"]',
						'[class*="popup"]',
						'[class*="overlay"]',
						'.tooltip_b6c360'
					];
					
					return preserveSelectors.some(selector => 
						element.matches(selector) || 
						element.closest(selector) !== null
					);
				}

				function processElement(element) {
					if (isModalOverlay(element)) {
						return;
					}

					if (element.classList.contains('wrapper_fea3ef', 'guilds_a4d4d9')) {
						element.style.setProperty('background-color', 'rgba(0, 0, 0, 0.5)', 'important');
						return;
					}
					
					if (element.classList.contains('sidebar_a4d4d9')) {
						element.style.setProperty('background-color', 'rgba(0, 0, 0, 0.25)', 'important');
						return;
					}

					if (element.classList.contains('children_fc4f04')) {
						let style = document.getElementById('remove-after-style');
						if (!style) {
							style = document.createElement('style');
							style.id = 'remove-after-style';
							document.head.appendChild(style);
						 }
						 
						 style.textContent += `
							 .children_fc4f04::after {
								 display: none !important;
								 content: none !important;
								 background: none !important;
							 }
						 `;
					 }

					if (shouldPreserveElement(element)) {
						return;
					}

					const computedStyle = window.getComputedStyle(element);
					const bgColor = computedStyle.backgroundColor;
					const alpha = getAlphaValue(bgColor);
					const position = computedStyle.position;
					const zIndex = parseInt(computedStyle.zIndex);

					if ((position === 'fixed' || position === 'absolute') && 
						zIndex > 100 && 
						alpha > 0 && 
						!isModalOverlay(element)) {
						return;
					}

					if (alpha > 0) {
						element.style.setProperty('background-color', 'transparent', 'important');
					}
					
					if (!element.closest('[data-preserve-colors="true"]')) {
						element.style.setProperty('color', 'white', 'important');
					}
				}

				function processAllElements() {
					const elements = document.getElementsByTagName('*');
					for (let element of elements) {
						processElement(element);
					}
				}

				const observer = new MutationObserver((mutations) => {
					let shouldProcess = false;
					
					for (let mutation of mutations) {
						if (mutation.type === 'childList' || 
							(mutation.type === 'attributes' && 
							(mutation.attributeName === 'style' || 
							 mutation.attributeName === 'class'))) {
							shouldProcess = true;
							break;
						}
					}
					
					if (shouldProcess) {
						processAllElements();
					}
				});

				document.documentElement.style.setProperty('background-color', 'transparent', 'important');
				document.body.style.setProperty('background-color', 'transparent', 'important');
				processAllElements();

				observer.observe(document.body, {
					childList: true,
					subtree: true,
					attributes: true,
					attributeFilter: ['style', 'class'],
					characterData: false
				});
			}

			removeBackgrounds();
			"""#
}
