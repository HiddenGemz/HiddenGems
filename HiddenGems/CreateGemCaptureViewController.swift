//
//  CreateGemCaptureViewController.swift
//  HiddenGems
//
//  Created by Daniel Ley on 8/17/16.
//  Copyright © 2016 daniel. All rights reserved.
//

import AVFoundation
import UIKit

class CreateGemCaptureViewController: UIViewController {
    
    @IBOutlet var cameraView: UIView?
    
    // AVFoundation properties
    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var cameraLayer: AVCaptureVideoPreviewLayer?
    var capturedImage: UIImage?
    var rootlayer : CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        for device in devices {
            if device.position == AVCaptureDevicePosition.Back {
                do {
                    let input = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
                    if captureSession.canAddInput(input) {
                        captureSession.addInput(input)
                        stillImageOutput.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
                        
                        if captureSession.canAddOutput(stillImageOutput) {
                            captureSession.addOutput(stillImageOutput)
                            captureSession.startRunning()
                            
                            cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            cameraLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
                            cameraLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                            //cameraLayer?.frame = (cameraView?.frame)!
                            cameraView?.layer.addSublayer(cameraLayer!)
                            cameraLayer?.position = CGPoint(x: (cameraView?.frame.width)!/2, y: (cameraView?.frame.height)!/2)
                            cameraLayer?.bounds = (cameraView?.frame)!
                        }
                    }
                } catch {
                    print("error")
                }
            }
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func captureImage(sender: UIButton) {
        
        if let videoConnection = stillImageOutput.connectionWithMediaType(AVMediaTypeVideo) {
                stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection) {
                (imageDataSampleBuffer, error) -> Void in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData)!, nil, nil, nil)
                self.capturedImage = UIImage(data: imageData)!
                self.performSegueWithIdentifier("createGemFormSegue2", sender: self)
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "createGemFormSegue2" {
            if let gemFormVC: CreateGemViewController2 = segue.destinationViewController as? CreateGemViewController2 {
                gemFormVC.gemPic = self.capturedImage!
            }
        }
    }

}
