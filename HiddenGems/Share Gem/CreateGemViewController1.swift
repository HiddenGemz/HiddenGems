//
//  CreateGemViewController1.swift
//  HiddenGems
//
//  Created by Daniel Ley on 8/15/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import Foundation
import UIKit

class CreateGemViewController1: UIViewController {
    
    // MARK: Properties
    var camera: UIImagePickerController!
    var album: UIImagePickerController!
    var chosenImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    /**
    @IBAction func cameraTapped(sender: UIButton) {
        camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = .Camera
        
        presentViewController(camera, animated: true, completion: nil)
    }
    **/
    @IBAction func cameraTapped(sender: UIButton) {
    }
    
    @IBAction func albumTapped(sender: UIButton) {
        album = UIImagePickerController()
        album.delegate = self
        album.sourceType = .SavedPhotosAlbum
        
        presentViewController(album, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "createGemFormSegue" {
            if let gemFormVC: CreateGemViewController2 = segue.destinationViewController as? CreateGemViewController2 {
                gemFormVC.gemPic = self.chosenImage!
            }
        }
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
}

extension CreateGemViewController1: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.chosenImage = resizeImage(selectedImage, newWidth: 200)
        if self.chosenImage != nil {
            picker.dismissViewControllerAnimated(false, completion: nil)
            performSegueWithIdentifier("createGemFormSegue", sender: self)
        } else {
            print("image empty")
        }
        
    }
}

extension CreateGemViewController1: UINavigationControllerDelegate {
    
}
