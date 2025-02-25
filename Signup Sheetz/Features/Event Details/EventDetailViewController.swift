//
//  EventDetailViewController.swift
//  Signup Sheetz
//
//  Created by Mohammad Kaif on 13/02/25.
//

import UIKit

class EventDetailViewController: UIViewController {

    
    @IBOutlet weak var backgroundView: BackgroundView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventCalendarView: UIView!
    @IBOutlet weak var eventLocationView: UIView!
    @IBOutlet weak var descriptionHeaderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var eventCalendarImageView: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    
    @IBOutlet weak var eventLocationImageView: UIImageView!
    @IBOutlet weak var eventAddressLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    var eventID = ""
    private var viewModel = EventDetailViewModel(eventID: "")
    var background: BackgroundView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.layer.cornerRadius = 20
        backButton.setImage(UIImage.arraowBack, for: .normal)
        getEventDetail()
    }
    
    func configureUIWithData() {
        eventCalendarImageView.image = UIImage.calendarYellowBG
        eventLocationImageView.image = UIImage.locationYellowBG
        
        eventNameLabel.font = FontManager.customFont(weight: .medium, size: 20)
        eventDateLabel.font = FontManager.customFont(weight: .medium, size: 16)
        eventTimeLabel.font = FontManager.customFont(weight: .light, size: 12)
        eventAddressLabel.font = FontManager.customFont(weight: .medium, size: 16)
        eventLocationLabel.font = FontManager.customFont(weight: .light, size: 12)
        descriptionHeaderLabel.font = FontManager.customFont(weight: .medium, size: 18)
        descriptionLabel.font = FontManager.customFont(weight: .light, size: 16)
        
        eventNameLabel.textColor = UIColor.init(hex: "120D26")
        eventDateLabel.textColor = UIColor.init(hex: "120D26")
        eventTimeLabel.textColor = UIColor.init(hex: "747688")
        eventAddressLabel.textColor = UIColor.init(hex: "120D26")
        eventLocationLabel.textColor = UIColor.init(hex: "747688")
        descriptionHeaderLabel.textColor = UIColor.init(hex: "120D26")
        descriptionLabel.textColor = UIColor.init(hex: "120D26")
        
        if let eventData = self.viewModel.eventData {
            eventImageView.networkImage(with: eventData.imageURL)
            eventNameLabel.text = eventData.name ?? ""
            descriptionHeaderLabel.text = "About Event"
            descriptionLabel.text = "\(eventData.description ?? "")"
            
            eventDateLabel.text = self.viewModel.formatEventDate(dateString: eventData.eventDate)
            eventTimeLabel.text = self.viewModel.formatEventTime(dateString: eventData.eventDate, timeString: eventData.startTime)
            
            eventAddressLabel.text = eventData.address ?? ""
            eventLocationLabel.text = eventData.address ?? ""
        }
    }
    
    private func configureBackground(with image: UIImage?, message: String?, data: EventData?) {
        DispatchQueue.main.async { [self] in
            if data != nil {
                if self.background != nil {
                    self.background?.removeFromSuperview()
                }
                self.containerView.isHidden = false
                self.backgroundView.backgroundColor = UIColor.customGrayColor()
                self.configureUIWithData()
            } else {
                if self.background == nil {
                    self.background = Bundle.main.loadNibNamed("BackgroundView", owner: self, options: nil)?.first as? BackgroundView
                    self.background?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                    self.background?.frame = self.backgroundView.bounds
                    self.background?.configureUI(with: image, message: message, isButtonEnable: true)
                    self.background?.didClickRefreshButton = {
                        self.getEventDetail()
                    }
                }
                self.containerView.isHidden = true
                self.backgroundView.backgroundColor = UIColor.white
                self.backgroundView.addSubview(self.background!)
            }
        }
    }
    
    @IBAction func didClickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - VIEWMODEL INTERACTIONS
extension EventDetailViewController {
    private func getEventDetail() {
        viewModel = EventDetailViewModel(eventID: self.eventID)
        self.viewModel.getEventDetail { result in
            switch result {
            case .success(let message):
                self.configureBackground(with: UIImage.noDataImage, message: message, data: self.viewModel.eventData)
            case .failure(let error):
                self.configureBackground(with: UIImage.noDataImage, message: error.localizedDescription, data: self.viewModel.eventData)
            }
        }
    }
}
