//
//  AsyncImageView.swift
//  SampleApp
//
//  Created by Denis Prozukin on 28.07.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class AsyncImageView: UIImageView {
	var task: URLSessionDataTask!
	let spinner = UIActivityIndicatorView(style: .medium)
	
	func loadImage(from url: URL) {
		image = nil
		
		addSpinner()
		
		if let task = task {
			task.cancel()
		}
		
		if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
			image = imageFromCache
			removeSpinner()
			return
		}
		
		task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			
			guard let data = data, let newImage = UIImage(data: data) else {
				print("Couldn't load an image from url: \(url)")
				return
			}
			
			imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
			
			DispatchQueue.main.async {
				self.image = newImage
				self.removeSpinner()
			}
		}
		
		task.resume()
	}
	
	func addSpinner() {
		addSubview(spinner)
		
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		
		spinner.startAnimating()
	}
	
	func removeSpinner() {
		spinner.removeFromSuperview()
	}
}
