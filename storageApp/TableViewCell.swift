//
//  TableViewCell.swift
//  storageApp
//
//  Created by Ffhh Qerg on 26.07.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var file: URL? {
        didSet {
            title.text = "\(String(file?.lastPathComponent ?? ""))"

        }
    }

      var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(title)

        
        let constraints = [
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
