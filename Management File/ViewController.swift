//
//  ViewController.swift
//  Management File
//
//  Created by MrDummy on 5/17/17.
//  Copyright © 2017 Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {
    
    var fileManager : FileManager?
    var documentDir : NSString?
    var filePath : NSString?
    
    @IBAction func btnCreateFileClicked(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("file1.txt") as NSString?
        fileManager?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        filePath = documentDir?.appendingPathComponent("file2.txt") as NSString?
        fileManager?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File created successfully")
    }
    
    func showSuccessAlert(titleAlert: String, messageAlert: String)
    {
        let alert:UIAlertController = UIAlertController(title:titleAlert, message: messageAlert as String, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        alert.addAction(okAction)
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func btnCreateDirectoryClicked(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("/folder1") as NSString?
        do {
            try fileManager?.createDirectory(atPath: filePath! as String, withIntermediateDirectories: false, attributes: nil)
        }
        catch let error as NSError {
            print(error)
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Directory created successfully")
    }
    
    @IBAction func btnEqualityClicked(_ sender: Any) {
        let filePath1 = documentDir?.appendingPathComponent("temp.txt")
        let filePath2 = documentDir?.appendingPathComponent("copy.txt")
        if(fileManager? .contentsEqual(atPath: filePath1!, andPath: filePath2!))!
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are equal.")
        }
        else
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are not equal.")
        }
    }
    
    @IBAction func btnWriteFileClicked(_ sender: Any) {
        let content: NSString = NSString(string: "Nguyen Hoang Huy")
        let fileContent: Data = content.data(using: String.Encoding.utf8.rawValue)!
        try? fileContent.write(to: URL(fileURLWithPath: documentDir!.appendingPathComponent("file1.txt")), options: [.atomic])
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content written successfully")
    }
    
    @IBAction func btnReadFileClicked(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("/file1.txt") as! NSString
        var fileContent: Data?
        fileContent = fileManager?.contents(atPath: filePath! as String)
        let str: NSString = NSString(data: fileContent!, encoding: String.Encoding.utf8.rawValue)!
        self.showSuccessAlert(titleAlert: "Success", messageAlert: ("data : \(str)" as NSString) as String)
    }
    
    @IBAction func btnCopyFileClicked(_ sender: Any) {
        let originalFile = documentDir?.appendingPathComponent("file1.txt")
        let copyFile = documentDir?.appendingPathComponent("copy.txt")
        try? fileManager?.copyItem(atPath: originalFile!, toPath: copyFile!)
        print(documentDir!)
        self.showSuccessAlert(titleAlert: "Success", messageAlert:"File copied successfully")
    }
    
    @IBAction func btnMoveClicked(_ sender: Any) {
        let oldFilePath: String = documentDir!.appendingPathComponent("file1.txt")
        let newFilePath: String = documentDir!.appendingPathComponent("/folder1/file1.txt") as String
        do {
            try fileManager?.moveItem(atPath: oldFilePath, toPath: newFilePath)
        }
        catch let error as NSError {
            print(error)
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File moved successfully")
    }
    
    @IBAction func btnFilePermissionClicked(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("file1.txt") as NSString?
        var filePermissions:NSString = ""
        
        if((fileManager?.isWritableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is writable. ") as NSString
        }
        if((fileManager?.isReadableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is readable. ") as NSString
        }
        if((fileManager?.isExecutableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is executable.") as NSString
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "\(filePermissions)")
    }
    
    @IBAction func btnDirectoryContentsClicked(_ sender: Any) {
        var error: NSError? = nil
        do {
            let arrDirContent = try fileManager!.contentsOfDirectory(atPath: filePath! as String)
            self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content of directory \(arrDirContent)")
        }
        catch let error as NSError {
            
        }
    }
    
    @IBAction func btnRemoveFile(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("file1.txt") as! NSString
        try? fileManager?.removeItem(atPath: filePath! as String)
        self.showSuccessAlert(titleAlert: "Message", messageAlert: "File removed successfully.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fileManager = FileManager.default
        let dirPaths:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        documentDir = dirPaths[0] as? NSString
        print("path : \(documentDir)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
}

