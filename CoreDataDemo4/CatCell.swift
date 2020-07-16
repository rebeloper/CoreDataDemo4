//
//  CatCell.swift
//  CoreDataDemo4
//
//  Created by Alex Nagy on 16/07/2020.
//  Copyright © 2020 Alex Nagy. All rights reserved.
//

import UIKit
import SparkUI
import Layoutless

class CatCell: CollectionCell<Cat>, SelfConfiguringCell {
    
    static var reuseIdentifier: String = "cell"
    
    let imageView = UIImageView().circular(20).contentMode(.scaleAspectFill)
    
    let nameLabel = UILabel()
        .text(color: .systemBlack)
        .bold()
    
    override func layoutViews() {
        super.layoutViews()
        
        stack(.vertical)(
            stack(.horizontal)(
                imageView.insetting(leftBy: 12, rightBy: 0, topBy: 10, bottomBy: 10),
                nameLabel.insetting(leftBy: 12, rightBy: 24, topBy: 10, bottomBy: 10)
            ),
            SDivider().insetting(leftBy: 12, rightBy: 0, topBy: 0, bottomBy: 0)
        ).fillingParent().layout(in: container)
        
    }
    
    override func configureViews(for item: Cat?) {
        super.configureViews(for: item)
        guard let item = item else { return }
        
        guard let imageName = item.imageName else { return }
        imageView.image = UIImage(named: imageName)
        nameLabel.text = "\(item.name!) - Age: \(item.age) - \(item.cutenessLevel!)\(item.isHungry ? " - hungry" : "")"
    }
}

