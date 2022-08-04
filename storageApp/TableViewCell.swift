//
//  TableViewCell.swift
//  storageApp
//
//  Created by Ffhh Qerg on 26.07.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var photoImage: UIImage? {
            didSet {
                photoCell.photoImageView.image = photoImage
            }
        }


    let photoCell = TableViewTabCell()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        photoCell.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(photoCell)

        
        let constraints = [
                    photoCell.topAnchor.constraint(equalTo: contentView.topAnchor),
                    photoCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    photoCell.heightAnchor.constraint(equalTo: contentView.widthAnchor),
                    photoCell.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                    
                ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
