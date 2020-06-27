//
//  ViewController.swift
//  Challenge-FlagInfo
//
//  Created by Jeffrey Carpenter on 6/26/20.
//  Copyright © 2020 Jeffrey Carpenter. All rights reserved.
//

import UIKit

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

extension String {
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}

class ViewController: UITableViewController {

    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getImages()
    }
    
    // MARK: - Functions
    
    func getImages() {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("flag-") {
                images.append(item)
            }
        }
        
        print(images)
    }

    // MARK: - tableView Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath)
        cell.textLabel?.text = images[indexPath.row].deletingPrefix("flag-").deletingSuffix(".png").uppercased()
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            
            vc.selectedImage = images[indexPath.row]
            vc.selectedImageName = images[indexPath.row].deletingPrefix("flag-").deletingSuffix(".png").uppercased()
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

