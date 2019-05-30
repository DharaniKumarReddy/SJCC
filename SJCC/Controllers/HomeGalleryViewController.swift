//
//  HomeGalleryViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 11/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class HomeGalleryViewController: UIViewController {

    // MARK:- Varibales
    internal var gallery: [HomeGallery] = []
    
    // MARK:- IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        
        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewCustomLayout {
            layout.delegate = self
        }
    }
}

extension HomeGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeGalleryCollectionCell.self), for: indexPath) as? HomeGalleryCollectionCell
        cell?.loadData(gallery: gallery[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullImageViewController = UIStoryboard.loadGalleryFullImageViewController()
        fullImageViewController.galleryItem = gallery[indexPath.row]
        navigationController?.pushViewController(fullImageViewController, animated: true)
    }
}

extension HomeGalleryViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath) -> CGFloat {
        let titleHeight = gallery[indexPath.row].title.heightWithConstrainedWidth(width: (screenWidth/2)-6, font: UIFont(name: "Optima-Bold", size: 18)!)
        let cellHeight = 150 + max(22, titleHeight)
        return cellHeight
    }
}

class HomeGalleryCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var homeGalleryTitleLabel: UILabel!
    @IBOutlet private weak var homeGalleryImageView: UIImageView!
    
    fileprivate func loadData(gallery: HomeGallery) {
        homeGalleryImageView.downloadImageFrom(link: gallery.image, contentMode: .scaleAspectFill)
        homeGalleryTitleLabel.text = gallery.title
    }
}
