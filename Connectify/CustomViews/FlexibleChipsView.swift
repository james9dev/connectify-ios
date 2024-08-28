//
//  FlexibleChipsView.swift
//  Connectify
//
//  Created by James on 8/28/24.
//

import SwiftUI

public struct ChipsType: Equatable {
	let title: String
	let priority: Int

	public init(title: String, priority: Int = 0) {
		self.title = title
		self.priority = priority
	}

	public static func == (lhs: ChipsType, rhs: ChipsType) -> Bool {
		lhs.title == rhs.title
	}
}

public struct FlexibleChipsView: View {
	
	@State var totalHeight: CGFloat
	
	let verticalSpacing: CGFloat
	let horizontalSpacing: CGFloat
	let items: [ChipsType]
	let color: Color
	
	var sortedItems: [ChipsType] {
		items.sorted(by: { $0.priority < $1.priority })
	}
  
	public init(totalHeight: CGFloat = .zero, verticalSpacing: CGFloat = 4, horizontalSpacing: CGFloat = 4, color: Color = .gray, items: [ChipsType]) {
		self.totalHeight = totalHeight
		self.verticalSpacing = verticalSpacing
		self.horizontalSpacing = horizontalSpacing
		self.items = items
		self.color = color
	}
	
	public var body: some View {
		var width = CGFloat.zero
		var height = CGFloat.zero
		
		GeometryReader { geomety in
			ZStack(alignment: .topLeading) {
				
				ForEach(self.sortedItems, id: \.title) { item in
					
					ChipsView(title: item.title, color: self.color)
						.id(item.title)
						.alignmentGuide(.leading) { view in
							if abs(width - view.width) > geomety.size.width {
								width = 0
								height -= view.height
								height -= verticalSpacing
							}
							let result = width
							
							if item == sortedItems.last {
								width = 0
							} else {
								width -= view.width
								width -= horizontalSpacing
							}
							
							return result
						}
						.alignmentGuide(.top) { _ in
							let result = height
							
							if item == sortedItems.last {
								height = 0
							}
							return result
						}
					
				}
				
			}
			.background(
				GeometryReader { geometry in
					Color.clear.onAppear {
						self.totalHeight = geometry.size.height
					}
				}
			)
		}
		.frame(height: totalHeight)
	}
}

public struct ChipsView: View {
	private var title: String
	private var color: Color
  
	public init(title: String, color: Color) {
		self.title = title
		self.color = color
	}
  
	public var body: some View {
		Text(title)
			.font(.subheadline)
			.foregroundColor(.black)
			.padding(.horizontal, 10)
			.padding(.vertical, 3)
			.background(self.color)
			.cornerRadius(16)
			//.overlay(RoundedRectangle(cornerRadius: 16).stroke(.green, lineWidth: 1))
			.frame(height: 24)
	}
}
