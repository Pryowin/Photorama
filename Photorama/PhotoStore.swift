//
//  PhotoStore.swift
//  Photorama
//
//  Created by David Burke on 7/23/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import Foundation

class PhotoStore {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    } ()
    
    func fetchInterestingPhotos() {
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } else  if let requestError = error {
                print("Error fetching photos: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
}