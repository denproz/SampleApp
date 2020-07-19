//
//  Networking.swift
//  SampleApp
//
//  Created by Denis Prozukin on 15.07.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import Foundation

class NetworkManager {
	enum SampleError: Error {
		case failedToGetData
		case failedToDecodeData
	}
	
	static let shared = NetworkManager()
	
	private init() {}
	
	func getSampleData(completion: @escaping (Result<SampleData, SampleError>) -> Void) {
		guard let url = URL(string: "https://pryaniky.com/static/json/sample.json") else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			
			guard let jsonData = data else {
				completion(.failure(.failedToGetData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let sampleData = try decoder.decode(SampleData.self, from: jsonData)
				completion(.success(sampleData))
			} catch {
				completion(.failure(.failedToDecodeData))
			}
		}.resume()
	}
}
