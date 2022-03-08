//
//  Tab.swift
//  Scrollable Menu
//
//  Created by Jacob Ko on 2022/03/05.
//

import SwiftUI

// Sample Tabs with sampe animals

struct Animal: Codable, Identifiable {
	let id: String
	let name: String
	let headline: String
	let description: String
	let link: String
	let image: String
	let gallery: [String]
	let fact: [String]
	let copyright: String
}
