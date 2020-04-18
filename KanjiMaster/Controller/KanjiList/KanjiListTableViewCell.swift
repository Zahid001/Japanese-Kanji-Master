//
//  KanjiListTableViewCell.swift
//  KanjiMaster
//
//  Created by Md Zahidul Islam Mazumder on 12/4/20.
//  Copyright © 2020 Md Zahidul Islam Mazumder. All rights reserved.
//

import UIKit

class KanjiListTableViewCell: UITableViewCell {

    @IBOutlet weak var number: UILabel!
    
    @IBOutlet weak var kanjiChar: UILabel!
    
    @IBOutlet weak var kanjiMeaning: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
