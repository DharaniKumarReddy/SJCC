//
//  GalleryFullImageViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 11/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class GalleryFullImageViewController: UIViewController {

    internal var galleryItem: HomeGallery?
    
    // MARK:- IBOutlets
    @IBOutlet private weak var slidingImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        getGalleryImageList()
    }
    
    private func getGalleryImageList() {
        APICaller.getInstance().getGalleryImageList(photoId: galleryItem?.id ?? "", onSuccess: { list in
            self.downloadImages(list)
        }, onError: {_ in})
    }
    
    private func downloadImages(_ gallery: [GalleryFullImage]) {
        var slidePhotos: [UIImage] = []
        for photo in gallery {
            photo.image.downloadImage(completion: { image in
                slidePhotos.append(image)
                if gallery.count == slidePhotos.count {
                    DispatchQueue.main.async {
                        self.animateImageSlides(images: slidePhotos)
                    }
                }
            })
        }
    }
    
    private func animateImageSlides(images: [UIImage]) {
        activityIndicator.stopAnimating()
        slidingImageView.animationImages = images
        slidingImageView.animationDuration = TimeInterval(images.count*2)
        slidingImageView.startAnimating()
    }
}
