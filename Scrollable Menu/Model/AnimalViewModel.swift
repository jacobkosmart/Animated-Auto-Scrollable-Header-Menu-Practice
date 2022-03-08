//
//  AnimalViewModel.swift
//  Scrollable Menu
//
//  Created by Jacob Ko on 2022/03/05.
//

import SwiftUI

class AnimalViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var animalTypes: [AnimalType]
	@Published var tabItems: [Tab]
	@Published var currentTab:String = ""

	
	init() {
		let fetchData: [AnimalType] = Bundle.main.decode("animaltype.json")
		self.animalTypes = fetchData
		self.tabItems = [
			Tab(tab: "Type1", animals: fetchData[0].body),
			Tab(tab: "Type2", animals: fetchData[1].body),
			Tab(tab: "Type3", animals: fetchData[2].body),
			Tab(tab: "Type4", animals: fetchData[3].body),
			Tab(tab: "Type5", animals: fetchData[4].body)
		]
	}
}
