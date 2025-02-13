//
//  MyEventTableViewCell.swift
//  Signup Sheetz
//
//  Created by Braintech on 03/02/25.
//

import UIKit

class MyEventTableViewCell: UITableViewCell {
    
    //MARK: - Outlet's
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var eventDateContainerView: UIView!
    @IBOutlet weak var meetingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressIcon: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    //MARK: - Life-Cycle-Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        confiqureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func confiqureUI() {
        addressIcon.image = UIImage.location
        meetingLabel.font = FontManager.customFont(weight: .medium, size: 16)
        addressLabel.font = FontManager.customFont(weight: .light, size: 13)
        addressLabel.textColor = UIColor.init(hex: "2B2849")
        eventImageView.layer.cornerRadius = 8
    }
    
    func configureUI(with data: EventData) {
        meetingLabel.text = data.name ?? ""
        addressLabel.text = data.address ?? ""
        eventImageView.networkImage(with: data.imageURL)
        if let eventDate = data.eventDate {
            formatEventDate(eventDate: eventDate)
        }
    }
    
    func formatEventDate(eventDate: String) {
        let dateString = eventDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: dateString) {
            let outputFormatterDate = DateFormatter()
            let outputFormatterMonth = DateFormatter()
            outputFormatterDate.dateFormat = "d"
            outputFormatterMonth.dateFormat = "MMM"
            let formattedDate = outputFormatterDate.string(from: date)
            let formattedMonth = outputFormatterMonth.string(from: date)
            configureEventDate(date: formattedDate, month: formattedMonth)
        }
    }
    
    func configureEventDate(date: String, month: String) {
        let fullText = "\(date)\n\(month)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let welcomeRange = (fullText as NSString).range(of: "\(date)")
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: welcomeRange)
        attributedString.addAttribute(.font, value: FontManager.customFont(weight: .medium, size: 18), range: welcomeRange)
        
        let nameRange = (fullText as NSString).range(of: "\(month)")
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: nameRange)
        attributedString.addAttribute(.font, value: FontManager.customFont(weight: .book, size: 10), range: nameRange)
        
        eventDateLabel.attributedText = attributedString
        eventDateLabel.numberOfLines = 2
        eventDateLabel.textAlignment = .center
    }
    
}
