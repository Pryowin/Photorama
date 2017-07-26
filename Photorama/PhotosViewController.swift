//
//  PhotosViewController.swift
//  Photorama
//
//  Created by David Burke on 7/23/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit


class PhotosViewController: UIViewController {
    
    
    @IBAction func photoTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                selectPhotos(type: "interesting")
            case 1:
                selectPhotos(type: "recent")
            default:
                break
        }
    }
   
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectPhotos(type: "interesting")
        
    }
    func selectPhotos(type: String) {

        store.fetchPhotos(type: type) {
            (photosResult) -> Void in
            
            switch photosResult {
            case let .success(photos):
                print("Found  \(photos.count) photos")
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching photos \(error)")
                
            }
        }

    }
    
    func updateImageView (for photo: Photo) {
        store.fetchImage(for: photo) {
            (imageResult) -> Void in
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }

}
