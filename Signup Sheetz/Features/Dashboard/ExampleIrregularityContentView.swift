import UIKit
import ESTabBarController

class ExampleIrregularityContentView: ESTabBarItemContentView {

    private let plusIconSize: CGFloat = 50

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFloatingButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFloatingButton() {
        // Background Circle
       imageView.backgroundColor = UIColor(red: 225/255.0, green: 81/255.0, blue: 175/255.0, alpha: 1.0)
       // imageView.layer.borderWidth = 4.0
      //  imageView.layer.borderColor = UIColor.systemPink.cgColor
        imageView.layer.cornerRadius = plusIconSize / 2
        imageView.clipsToBounds = true
        insets = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0) // Moves button up

        // Shadow Effect
        imageView.layer.shadowColor = UIColor.white.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowRadius = 8

        // Set Plus Icon Using Separate ImageView
        let plusImageView = UIImageView(image: UIImage(named: "eventAddition"))
        plusImageView.tintColor = .white
        plusImageView.image = UIImage(named: "eventAddition")
        plusImageView.contentMode = .scaleAspectFit
        plusImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        plusImageView.center = CGPoint(x: plusIconSize / 2, y: plusIconSize / 2)
        imageView.addSubview(plusImageView)
    }

    override func updateLayout() {
        super.updateLayout()
        imageView.frame.size = CGSize(width: plusIconSize, height: plusIconSize)
        imageView.center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    }

//    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
//        UIView.animate(withDuration: 0.2) {
//            self.imageView.alpha = 0.7
//        } completion: { _ in
//            UIView.animate(withDuration: 0.2) {
//                self.imageView.alpha = 1.0
//            }
//        }
//        completion?()
//    }
}
