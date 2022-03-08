//
//  AnimalListItemView.swift
//  Scrollable Menu
//
//  Created by Jacob Ko on 2022/03/07.
//

import SwiftUI

struct AnimalListItemView: View {
	
	// MARK: -  PROPERTY
	var tab: Tab
	
	// MARK: -  BODY
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
	}
}

// MARK: -  PREVIEW
struct AnimalListItemView_Previews: PreviewProvider {
	static var fetchData: [AnimalType] = Bundle.main.decode("animaltype.json")
	
	static var tabItems = [
		Tab(tab: "Type1", animals: fetchData[0].body),
		Tab(tab: "Type2", animals: fetchData[1].body),
		Tab(tab: "Type3", animals: fetchData[2].body),
		Tab(tab: "Type4", animals: fetchData[3].body),
		Tab(tab: "Type5", animals: fetchData[4].body)
	]
	
	
	static var previews: some View {
		AnimalListItemView(tab: tabItems[0])
		
	}
}
