//
//  DetailViewController.swift
//  Challenge-FlagInfo
//
//  Created by Jeffrey Carpenter on 6/26/20.
//  Copyright © 2020 Jeffrey Carpenter. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var selectedImageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        self.title = selectedImageName
        if let selectedImage = selectedImage {
            imageView.image = UIImage(named: selectedImage)
        }
        
        imageView.layer.backgroundColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8), let imageName = selectedImageName else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [imageName, image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
