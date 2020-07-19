//
//  MainViewController.swift
//  SampleApp
//
//  Created by Denis Prozukin on 14.07.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController {
	// MARK: - Identificators
	private enum Section {
		case main
	}
	
	private enum ViewTypes: String {
		case hz = "hz"
		case picture = "picture"
		case selector = "selector"
	}
	
	private struct CellId {
		static let hzCellId = "cellId"
		static let pictureCellId = "pictureCellId"
		static let selectorCellId = "selectorCellId"
	}
	
	// MARK: - Properties
	private var viewsToDisplay = [String]()
	private var mainData = [OuterData]()
  private var sequenceOfViews = [Int]()
	private var variants = [Variant]()
	private var selectedVariant = 0

	// MARK: - Lifecycle
	init() {
		super.init(collectionViewLayout: MainViewController.configureLayout())
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		customizeNavBar()
		getJsonData()
		
		collectionView.backgroundColor = .white
		collectionView.register(HzCell.self, forCellWithReuseIdentifier: CellId.hzCellId)
		collectionView.register(PictureCell.self, forCellWithReuseIdentifier: CellId.pictureCellId)
		collectionView.register(SelectorCell.self, forCellWithReuseIdentifier: CellId.selectorCellId)
	}
	
	// MARK: - Methods
	private func customizeNavBar() {
		navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
		
		let titleImage = UIImage(named: "pryaniki")
		navigationItem.titleView = UIImageView(image: titleImage)
		
		title = "Пряники"
	}
	
	private func getVariants(from mainData: [OuterData]) -> [Variant] {
		var allVariants = [Variant]()
		for data in mainData {
			if let variants = data.data.variants {
				for variant in variants {
					allVariants.append(variant)
				}
			}
		}
		return allVariants
	}
	
	private func getSequenceOfViews() -> [Int] {
		var cellsContents = [Int]()
		for view in viewsToDisplay {
			var found = false
			var index = 0
			for data in mainData {
				if !found {
					let name = data.name
					if view == name {
						found = true
						cellsContents.append(index)
						continue
					}
				}
				index += 1
			}
		}
		return cellsContents
	}
	
	// MARK: - Networking
	private func getJsonData() {
		NetworkManager.shared.getSampleData { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .failure(let error):
				print(error)
			case .success(let data):
				DispatchQueue.main.async {
					self.mainData = data.data
					self.viewsToDisplay = data.view
					self.sequenceOfViews = self.getSequenceOfViews()
					self.variants = self.getVariants(from: self.mainData)
					self.collectionView.reloadData()
				}
			}
		}
	}
	
	// MARK: - CollectionViewCompositionalLayout
	private static func configureLayout() -> UICollectionViewLayout {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets.bottom = 16
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		
		let layout = UICollectionViewCompositionalLayout(section: section)
		return layout
	}
	
	// MARK: - CollectionViewDataSource
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		sequenceOfViews.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let type = mainData[sequenceOfViews[indexPath.item]].name
		let data = mainData[sequenceOfViews[indexPath.item]].data
		
		if type == ViewTypes.hz.rawValue {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.hzCellId, for: indexPath) as? HzCell else { fatalError() }
			cell.textLabel.text = data.text
			return cell
		} else if type == ViewTypes.picture.rawValue {
			if let url = data.url, let imageUrl = URL(string: url), let imageData = try? Data(contentsOf: imageUrl) {
				guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.pictureCellId, for: indexPath) as? PictureCell else { fatalError() }
				cell.textLabel.text = data.text
				cell.imageView.image = UIImage(data: imageData)
				return cell
			}
		} else if type == ViewTypes.selector.rawValue {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.selectorCellId, for: indexPath) as? SelectorCell else { fatalError() }
			cell.picker.delegate = self
			cell.picker.dataSource = self
			if let initialPosition = data.selectedId {
				selectedVariant = initialPosition
				cell.picker.selectRow(initialPosition, inComponent: 0, animated: true)
			}
			return cell
		}
		return UICollectionViewCell()
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let type = mainData[sequenceOfViews[indexPath.item]].name
		
		switch type {
		case "hz", "picture":
			print("Инициатор вызова — \(type)")
		default:
			break
		}
	}
}

// MARK: - PickerView
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return variants.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return variants[row].text
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedVariant = variants[row].id
		
		print("Инициатор вызова — selector c id: \(selectedVariant)")
		
	}
	
	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		return 36
	}
}

