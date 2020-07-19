//
//  SampleCell.swift
//  SampleApp
//
//  Created by Denis Prozukin on 16.07.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

class HzCell: UICollectionViewCell {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupCell()
	}
	
	lazy var textLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		label.textColor = .black
		label.textAlignment = .center
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private func setupCell() {
		backgroundColor = .systemOrange
		addSubview(textLabel)
		
		textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
