//
//  PictureCell.swift
//  SampleApp
//
//  Created by Denis Prozukin on 16.07.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

class PictureCell: UICollectionViewCell {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupCell()
	}

	lazy var imageView: AsyncImageView = {
		let imageView = AsyncImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	lazy var textLabel: UILabel = {
		let textLabel = UILabel()
		textLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		textLabel.textColor = .black
		textLabel.translatesAutoresizingMaskIntoConstraints = false
		textLabel.textAlignment = .center
		return textLabel
	}()
	
	private func setupCell() {
		backgroundColor = .systemOrange
		
		let stackView = UIStackView(arrangedSubviews: [imageView, textLabel])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		
		addSubview(stackView)
		
		stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		
		stackView.setCustomSpacing(4, after: imageView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
