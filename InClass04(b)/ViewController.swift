//
//  ViewController.swift
//  InClass04(b)
//
//  Created by student on 7/14/16.
//  Copyright © 2016 mnr_iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var urlStr = ""
    var index = 0
    
    @IBOutlet weak var imageView: UIImageView!
    var imageURL:NSURL?
    
    @IBOutlet weak var nextImage: UIButton!
    @IBOutlet weak var previousImage: UIButton!
    @IBAction func showPreviousImage(sender: AnyObject) {
        if index < 19 {
            index += 1
        } else {
            index = 0
        }
        fetchImage()
    }
    @IBAction func showNextImage(sender: AnyObject) {
        if index > 0 {
            index -= 1
        } else {
            index = 19
        }
        fetchImage()
    }
    private func fetchImage() {
        progressView?.hidden = false
        self.nextImage.enabled = false
        self.previousImage.enabled = false
        progressView?.startAnimating()
        urlStr = "http://dev.theappsdr.com/lectures/inclass_http/index.php?pid=\(index)"
        imageURL = NSURL(string: urlStr)
        displayImage()
    }
    
    private func displayImage() {
        if let url = imageURL {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                let contentsOfURL = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageURL {
                        if let imageData = contentsOfURL {
                            self.image = nil
                            self.progressView?.stopAnimating()
                            self.progressView?.hidden = true
                            self.nextImage.enabled = true
                            self.previousImage.enabled = true
                            self.image = UIImage(data: imageData)
                        }
                    } else {
                        print("Ignore: Multiple Clicks")
                    }
                }
            }
        }
    }
    
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var progressView: UIActivityIndicatorView!
}

