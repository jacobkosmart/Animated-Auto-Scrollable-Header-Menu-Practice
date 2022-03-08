//
//  Scrollable_MenuApp.swift
//  Scrollable Menu
//
//  Created by Jacob Ko on 2022/03/05.
//

import SwiftUI

@main
struct Scrollable_MenuApp: App {
	
	@StateObject private var vm: AnimalViewModel = AnimalViewModel()
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environmentObject(vm)
		}
	}
}
