//
//  ProfileDetailTableViewCell.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 13/02/25.
//

import UIKit

class ProfileDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        selectionStyle = .none
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUI() {
        keyLabel.font = FontManager.customFont(weight: .light, size: 15)
        valueLabel.font = FontManager.customFont(weight: .medium, size: 14)
    }
    
    func configureUI(with data: ProfileModel) {
        keyLabel.text = data.peofileKey
        valueLabel.text = data.profileValue
    }
    
//    func formatDate(createdAt: String) {
//        let dateString = createdAt
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//
//        if let date = dateFormatter.date(from: dateString) {
//            let outputFormatterDate = DateFormatter()
//            let outputFormatterMonth = DateFormatter()
//            outputFormatterDate.dateFormat = "d MMM YY"
//            outputFormatterMonth.dateFormat = "MMM"
//            let formattedDate = outputFormatterDate.string(from: date)
//            let formattedMonth = outputFormatterMonth.string(from: date)
//            configureEventDate(date: formattedDate, month: formattedMonth)
//        }
//    }
    
}
