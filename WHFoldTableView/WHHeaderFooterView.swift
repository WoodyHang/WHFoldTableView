//
//  WHHeaderFooterView.swift
//  WHFoldTableView
//
//  Created by Woodyhang on 17/3/6.
//  Copyright © 2017年 Woodyhang. All rights reserved.
//

import UIKit


class WHHeaderFooterView:UITableViewHeaderFooterView  {
    
    
    typealias WHCompleteHandler = (_ tag:Int,_ selected:Bool) -> Void
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageVeiw: UIImageView!
    var completedHandler:WHCompleteHandler?
    var isSelected = false {
        didSet {
            if isSelected {
                imageVeiw.image = UIImage(named: "icon_up")
            }else {
                imageVeiw.image = UIImage(named: "icon_down")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(WHHeaderFooterView.onClicked))
        self.addGestureRecognizer(gesture)
    }
    
    func onClicked(){
        self.isSelected = !self.isSelected
        self.completedHandler!(self.tag,self.isSelected)
    }
    
}
