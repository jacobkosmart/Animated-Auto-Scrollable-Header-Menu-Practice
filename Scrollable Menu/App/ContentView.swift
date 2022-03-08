//
//  ContentView.swift
//  Scrollable Menu
//
//  Created by Jacob Ko on 2022/03/05.
//

import SwiftUI

struct ContentView: View {
	// MARK: -  PROPERTY
	
	@EnvironmentObject private var vm: AnimalViewModel
	@Namespace var animation
	@Environment(\.colorScheme) var scheme
	
	// MARK: -  BODY
	var body: some View {
		ZStack {
			// Background
			
			// foreground
			VStack (spacing: 0){
				VStack {
					header
					categoryView
						.padding([.top])
					bodyView
					
				} //: VSTACK
			} //: VSTACK
			.padding([.horizontal, .top])
		} //: ZSTACK
		.background(.ultraThinMaterial)
	}
	
}

// MARK: -  PREVIEW
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(AnimalViewModel())
	}
}

// MARK: -  EXTENSTION
extension ContentView {
	
	// Header
	private var header: some View {
	
			HStack (spacing: 15) {
				
				Button {
					
				} label: {
					Image(systemName: "list.dash").font(.title2)
				}
				
				Text("Animal List")
					.font(.title3)
					.fontWeight(.semibold)
					.hLeading()
				
				Button {
					
				} label: {
					Image(systemName: "magnifyingglass")
						.font(.title2)
				}
				
			} //: HSTACK
			.foregroundColor(.primary)
			.padding(.horizontal)
	
	}
	
	
	// Category View
	private var categoryView: some View {
		// Scroll View Reader..
		// to scroll tab automatically when user scrolls..
		ScrollViewReader { proxy in
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack (spacing: 30) {
					
					ForEach(vm.tabItems) { tab in
						VStack {
							
							Text(tab.tab)
								.foregroundColor(vm.currentTab.replacingOccurrences(of: " SCROLL", with: "") == tab.id ? .primary : .gray)
							
							// For matched geometry effect..
							if vm.currentTab.replacingOccurrences(of: " SCROLL", with: "") == tab.id {
								Capsule()
									.fill(Color.accentColor)
									.matchedGeometryEffect(id: "TAB", in: animation)
									.frame(height: 3)
									.padding(.horizontal, -10)
							} else {
								Capsule()
									.fill(.clear)
									.frame(height: 3)
									.padding(.horizontal, -10)
							}
							
						} //: VSTACK
						.onTapGesture {
							withAnimation(.easeInOut) {
								vm.currentTab = "\(tab.id) TAP"
								proxy.scrollTo(vm.currentTab.replacingOccurrences(of: " TAP", with: ""), anchor: .topTrailing)
							}
						}
					} //: LOOP
				} //: HSTACK
				.padding(.horizontal, 30)
				.background(.ultraThinMaterial)
			} //: SCROLL
			.onChange(of: vm.currentTab, perform: { _ in
				// Enabling scrolling..
				if vm.currentTab.contains(" SCROLL") {
					withAnimation(.easeInOut) {
						proxy.scrollTo(vm.currentTab.replacingOccurrences(of: " SCROLL", with: ""), anchor: .topTrailing)
					}
				}
			})
			// Divider
			.background(scheme == .dark ? Color.black : Color.white)
			.overlay(
				Divider()
					.padding(.horizontal, -15)
				, alignment: .bottom
			)
		} //: SCROLLREADER
		// Setting first tab..
		.onAppear {
			vm.currentTab = vm.tabItems.first?.id ?? ""
		}
	}
	
	// Body View
	private var bodyView: some View {
		// Scrool view reader to scroll the content..
		ScrollView(.vertical, showsIndicators: false) {
			ScrollViewReader { proxy in
				VStack (spacing: 15) {
					ForEach(vm.tabItems) { tab in
							// Animal Card Item
						AnimalCardView(tab: tab, currentTab: $vm.currentTab)
					}
				} //: VSTACK
				.padding([.bottom])
				.onChange(of: vm.currentTab) { newValue in
					// avoid scroll if its tap..
					if vm.currentTab.contains(" TAP") {
						// Scrolling to content..
						withAnimation(.easeInOut) {
							proxy.scrollTo(vm.currentTab.replacingOccurrences(of: " TAP", with: ""), anchor: .topTrailing)
						}
					}
				}
			} //: SCROLLREADER
		} //: SCROLL
		// Setting Coordinate Space name for offset..
		.coordinateSpace(name: "SCROLL")
	}
}


struct AnimalCardView: View {
	
	let tab: Tab
	@Binding var currentTab: String
	
	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			Text(tab.tab)
				.font(.title.bold())
				.padding(.vertical)
			
			ForEach(tab.animals) { animal in
				HStack(alignment: .center, spacing: 16) {
					Image(animal.image)
						.resizable()
						.scaledToFill()
						.frame(width: 90, height: 90)
						.clipShape(
							RoundedRectangle(cornerRadius: 12)
						)
					
					VStack(alignment: .leading, spacing: 8) {
						Text(animal.name)
							.font(.title2)
							.foregroundColor(.accentColor)
						
						Text(animal.headline)
							.font(.footnote)
							.multilineTextAlignment(.leading)
							.lineLimit(2)
							.padding(.trailing, 8)
					} //: VSTACK
				} //: HSTACK
				Divider()
			} //: LOOP
		} //: VSTACK
		.modifier(OffsetModifier(tab: tab, currentTab: $currentTab))
		.id(tab.id)
	}
}
