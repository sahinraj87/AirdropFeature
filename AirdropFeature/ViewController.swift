//
//  ViewController.swift
//  AirdropFeature
//
//  Created by Sahin Raj on 5/3/20.
//  Copyright © 2020 Sahin Raj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var shareButton: UIButton!
    let fileName = "FlightReleaseMaster"
    var documentDirURL: URL!
    var fileURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("fedex")
        print("FilePath: \(fileURL.path)")
        
        createFileForSharing()
        
        readFileForSharing()
        
    }
    
    func createFileForSharing() {
        // Save data to file
        
        guard let fileURL = fileURL else {
            print("file URL not init")
            return
        }
        
        let writeString = "new data in custom file for sharing sample"
        do {
            // Write to the file
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }
    
    func readFileForSharing() {
        
        guard let fileURL = fileURL else {
            print("file URL not init")
            return
        }
        
        var readString = "" // Used to store the file contents
        do {
            // Read the file contents
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        print("File Text: \(readString)")
        
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        
        guard let fileURL = fileURL else {
            print("file URL not init")
            return
        }
        
        let itemSource = AirDropOnlySource(item: fileURL)
        
        let controller = UIActivityViewController(activityItems: [itemSource], applicationActivities: nil)
        controller.excludedActivityTypes = [.postToFacebook, .postToTwitter, .print, .copyToPasteboard,
                                            .assignToContact, .saveToCameraRoll, .mail, .postToVimeo]
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
}



