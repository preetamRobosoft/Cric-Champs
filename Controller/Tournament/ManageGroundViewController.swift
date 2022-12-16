//
//  ManageGroundViewController.swift
//  Cricket
//
//  Created by Preetam G on 10/12/22.
//

import UIKit

class ManageGroundViewController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var pageControl: UIPageControl!
    // MARK: Temporary, use viewModel for this data
    let numberOfImages = 3
    let images: [UIImage] = [#imageLiteral(resourceName: "stadium2"), #imageLiteral(resourceName: "ground3"), #imageLiteral(resourceName: "ground2")]
    override func viewDidLoad() {
        super.viewDidLoad()

        configurePageControl()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func configurePageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = images.count
    }
}

extension ManageGroundViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroundImageCell", for: indexPath) as! GroundImageCell
        imageCell.configure(image: images[indexPath.row])
        return imageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    
}
