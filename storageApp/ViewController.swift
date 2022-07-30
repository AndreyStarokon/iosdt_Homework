//
//  ViewController.swift
//  storageApp
//
//  Created by Ffhh Qerg on 25.07.2022.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    private var images = [URL]()
    private let imagePicker = UIImagePickerController()
    
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
        imagePicker.delegate = self
        setupViews()
        getFiles()
        tableStorage.delegate = self
        tableStorage.dataSource = self
        tableStorage.frame = view.bounds
    }
//-----------------
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageURL = info[.imageURL] as! URL
        print(imageURL)
        let documentsUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,   appropriateFor: nil, create: false)
        let newimage = documentsUrl.appendingPathComponent(imageURL.lastPathComponent)
        if !FileManager.default.fileExists(atPath: newimage.path) {
            try? FileManager.default.copyItem(at: imageURL, to: newimage)
        }
        getFiles()
        tableStorage.reloadData()

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
 //-----------------
    func getFiles() {
            images.removeAll()
            let documentsUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,   appropriateFor: nil, create: false)
            
            let contents = try! FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            
            for file in contents {
                images.append(file)
            }
        }
 //----------------------------
    private func setupViews() {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            
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
        present(imagePicker, animated: true, completion: nil)
    }
    

}


extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return images.count
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         
        navigationController?.pushViewController(FolderViewController(), animated: true)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
        cell.file = images[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
            self.images.remove(at: indexPath.row)
              tableView.deleteRows(at: [indexPath], with: .automatic)
          }
        }
}


