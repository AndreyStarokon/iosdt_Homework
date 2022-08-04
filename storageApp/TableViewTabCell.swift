//
//  TableViewTabCell.swift
//  storageApp
//
//  Created by Ffhh Qerg on 02.08.2022.
//

import UIKit

class TableViewTabCell: UIView {
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(selectSize), name: NSNotification.Name("switchOFF"), object: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "size is 400x400"
        label.backgroundColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

 let photoImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.clipsToBounds = true
       imageView.contentMode = .scaleAspectFill
       return imageView
   }()
    
    @objc func selectSize() {
        
        title.isHidden = true
    }
    
    private func setupViews() {
        addSubview(photoImageView)
        addSubview(title)

        
        let constraints = [
                    photoImageView.topAnchor.constraint(equalTo: topAnchor),
                    photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                    photoImageView.widthAnchor.constraint(equalTo: widthAnchor),
                    
                    title.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 5),
                    title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                    title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
                ]
        
        NSLayoutConstraint.activate(constraints)
    }

}



