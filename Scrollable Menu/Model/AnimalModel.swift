//
//  AnimalModel.swift
//  Scrollable Menu
//
//  Created by Jacob Ko on 2022/03/05.
//

import Foundation
import SwiftUI

// Sample Tabs with sample animals


struct AnimalType: Codable{
	var type : String
	var body: [Animal]
}


struct Animal: Codable, Identifiable {
	var id : String
	let name: String
	let headline: String
	let description: String
	let link: String
	let image: String
	let gallery: [String]
	let fact: [String]
	let copyright: String
}



// Tab Model ..
struct Tab: Identifiable {
	var id = UUID().uuidString
	var tab: String
	var animals: [Animal]
}


