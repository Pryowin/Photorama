//
//  PhotosViewController.swift
//  Photorama
//
//  Created by David Burke on 7/23/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit


class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchInterestingPhotos {
            (photosResult) -> Void in
            
            switch photosResult {
            case let .success(photos):
                print("Found  \(photos.count) photos")
            case let .failure(error):
                print("Error fetching photos \(error)")
                
            }
        }
    }


}
