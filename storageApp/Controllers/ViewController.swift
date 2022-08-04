//
//  ViewController.swift
//  storageApp
//
//  Created by Ffhh Qerg on 25.07.2022.
//

import UIKit
import Photos

class ViewController: UIViewController {

    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let userDefaults = UserDefaults.standard
    
    let tableStorage: UITableView = {
       let tableview = UITableView()
      tableview.register(TableViewCell.self,
                         forCellReuseIdentifier: String(describing: TableViewCell.self))
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Documents"
        navigationController?.navigationBar.prefersLargeTitles = true
        let plusImage    = UIImage(systemName: "plus")
        let folderImage  = UIImage(systemName: "folder.badge.plus")
        let plusButton   = UIBarButtonItem(image: plusImage,  style: .plain, target: self, action:#selector(addPhoto))
        let folderButton = UIBarButtonItem(image: folderImage,  style: .plain, target: self, action: #selector(addNewFolder))
        navigationItem.rightBarButtonItems = [plusButton, folderButton]
        setupViews()
        tableStorage.delegate = self
        tableStorage.dataSource = self
        tableStorage.frame = view.bounds
    }

    
    func reloadTableView() {
            tableStorage.reloadData()
        }
    

    private func setupViews() {

            
            view.addSubview(tableStorage)
            
            let constraints = [
                tableStorage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableStorage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tableStorage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                tableStorage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ]
            
            NSLayoutConstraint.activate(constraints)
        }
    
    
       
    @objc private func addNewFolder() {
    
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add new Folder", message: "", preferredStyle: .alert)
    alert.addTextField { alertTextField in
        alertTextField.placeholder = "Create new Folder"
        textField = alertTextField
    }
    
    let action = UIAlertAction(title: "Add folder", style: .default) { action in
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent("\(textField.text!)")
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    let secondAction = UIAlertAction(title: "Cancel", style: .default)
    alert.addAction(action)
    alert.addAction(secondAction)
    present(alert, animated: true, completion: nil)
    tableStorage.reloadData()
        
}
    
    @objc private func addPhoto() {
        let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                present(imagePicker, animated: true, completion: nil)
    }
    

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let fileName = UUID().uuidString + ".jpg"
        let fileUrl = documentsDirectory.appendingPathComponent(fileName)
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            if let data = image.jpegData(compressionQuality: 1.0),
               !FileManager.default.fileExists(atPath: fileUrl.path) {
                do {
                    try data.write(to: fileUrl)
                    print("file saved")
                } catch {
                    print("error saving file:", error)
                }
                
            }
        }
        tableStorage.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: documentsDirectory,
                                                                   includingPropertiesForKeys: nil,
                                                                   options: [.skipsHiddenFiles])
            count = contents.count
        } catch {
            print("Ошибка получения контента")
        }
        return count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
        do {
            var contents = try FileManager.default.contentsOfDirectory(at: documentsDirectory,
                                                                   includingPropertiesForKeys: nil,
                                                                   options: [.skipsHiddenFiles])
            switch userDefaults.string(forKey: "sortedOrder") {
            case "alphabet_order":
                contents.sort(by: {$0.absoluteString < $1.absoluteString})
            case "reverce_alphabet_order":
                contents.sort(by: {$0.absoluteString > $1.absoluteString})
            default:
                break
            }
            let image = UIImage(contentsOfFile: contents[indexPath.item].path)
            cell.photoImage = image
            return cell
        } catch {
            print("Ошибка получения контента")
            return cell
        }
    }
    
}
