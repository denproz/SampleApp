//
//  Model.swift
//  SampleApp
//
//  Created by Denis Prozukin on 15.07.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import Foundation

struct SampleData: Decodable, Hashable {
	var data: [OuterData]
	var view: [String]
}

struct OuterData: Decodable, Hashable {
	var name: String
	var data: InnerData
}

struct InnerData: Decodable, Hashable {
	var text: String?
	var url: String?
	var selectedId: Int?
	var variants: [Variant]?
}

struct Variant: Decodable, Hashable {
	var id: Int
	var text: String
}


