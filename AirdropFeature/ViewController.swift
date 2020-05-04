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
        initFilePaths()
        createFileForSharing()
        
    }
    
    func initFilePaths() {
        documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension("fedex")
        print("FilePath: \(fileURL.path)")
    }
    
    func createFileForSharing() {
        
        guard let fileURL = fileURL else {
            print("file URL not init")
            return
        }
        
        //sample json file created from trip json.
        let writeString = """
                        {
                           "mobilityTripKey":[
                              {
                                 "aircraft":"57",
                                 "base":"EUR57",
                                 "operatingDate":"2016-11-22T00:00:00Z",
                                 "operatingDateLBT":"2016-11-22T01:00:00Z",
                                 "tripNumber":"33",
                                 "tripType":"REG"
                              },
                              {
                                 "aircraft":"57",
                                 "base":"EUR57",
                                 "operatingDate":"2016-12-06T00:00:00Z",
                                 "operatingDateLBT":"2016-12-06T01:00:00Z",
                                 "tripNumber":"34",
                                 "tripType":"REG"
                              },
                              {
                                 "aircraft":"57",
                                 "base":"EUR57",
                                 "operatingDate":"2016-11-27T00:00:00Z",
                                 "operatingDateLBT":"2016-11-27T01:00:00Z",
                                 "tripNumber":"48",
                                 "tripType":"LCA"
                              }
                           ]
                        }

                        """
        
        do {
            // Write to the file
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }
    
    // this method is not used
    // method used to read data from the file created.
    func readFileForSharing() -> String! {
        
        guard let fileURL = fileURL else {
            print("file URL not init")
            return nil
        }
        
        var readString: String!
        
        do {
            // Read the file contents
            readString = try String(contentsOf: fileURL)
            
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        guard let resultString = readString else {
            print("Error in readFileForSharing()")
            return nil
        }
        print("File Text: \(resultString)")
        return resultString
        
    }
    
    func createJsonObject(with stringParam: String) -> [Dictionary<String, Any>]! {
        
        let string = stringParam
        let data = string.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            {
                print(jsonArray) // use the json here
                return jsonArray
            } else {
                print("bad json")
                return nil
            }
        } catch let error as NSError {
            print(error)
            return nil
        }
        
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        
        guard let fileURL = fileURL else {
            print("file URL not init")
            return
        }
        
        let itemSource = AirDropOnlySource(item: fileURL)
        
        let controller = UIActivityViewController(activityItems: [itemSource], applicationActivities: nil)
        
        self.present(controller, animated: true, completion: nil)
        
    }
}



