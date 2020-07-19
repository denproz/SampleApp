//
//  SelectorCell.swift
//  SampleApp
//
//  Created by Denis Prozukin on 16.07.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

class SelectorCell: UICollectionViewCell {
	
	let picker: UIPickerView = {
		let picker = UIPickerView()
		picker.translatesAutoresizingMaskIntoConstraints = false
		picker.backgroundColor = .systemOrange
		return picker
	}()
    
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(picker)
		
		picker.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		picker.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
