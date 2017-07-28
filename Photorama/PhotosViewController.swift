//
//  PhotosViewController.swift
//  Photorama
//
//  Created by David Burke on 7/23/17.
//  Copyright © 2017 amberfire. All rights reserved.
//

import UIKit


class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: -  Outlets & Actions
    
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK:  - Variable Definitions
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchInterestingPhotos {
            (photosResult) -> Void in
            
            switch photosResult {
            case let .success(photos):
                print("Found  \(photos.count) photos")
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching photos \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    // MARK: - Delegate Methods
  
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let photo = photoDataSource.photos[indexPath.row]
        store.fetchImage(for: photo) { (result) -> Void in
            guard let photoIndex = self.photoDataSource.photos.index(of: photo),
            case let .success(image) = result else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
        }
        
    }
}

