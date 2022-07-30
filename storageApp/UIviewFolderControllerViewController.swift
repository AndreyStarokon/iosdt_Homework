//
//  UIviewFolderControllerViewController.swift
//  storageApp
//
//  Created by Ffhh Qerg on 30.07.2022.
//

import UIKit

class FolderViewController: UIViewController {
    var nameLabel: String = ""
     var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
       return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = nameLabel
        setConstraints()
        view.backgroundColor = .white
        
    }
    
    private func setConstraints() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)])
    }
    

}
