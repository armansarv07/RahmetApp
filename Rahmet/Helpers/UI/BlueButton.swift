import UIKit
import SnapKit

class BlueButton: UIButton {
    init(text: String, rightText: String? = nil, leftText: String? = nil, isActive: Bool = true) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.isEnabled = isActive
        
        if let rightText = rightText {
            let rightLabel = UILabel()
            rightLabel.text = rightText
            rightLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            rightLabel.textColor = .white
            self.addSubview(rightLabel)
            rightLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(15)
                make.centerY.equalToSuperview()
            }
        }
        
        if let leftText = leftText {
            let leftLabel = UILabel()
            leftLabel.text = leftText
            leftLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            leftLabel.textColor = .white
            self.addSubview(leftLabel)
            leftLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(15)
                make.centerY.equalToSuperview()
            }
        }
        
        if !isActive {
            self.isEnabled = false
            self.setTitle(text, for: .normal)
            self.backgroundColor = #colorLiteral(red: 0.4567491412, green: 0.7525898218, blue: 0.9685730338, alpha: 1)
        } else {
            self.isEnabled = true
            self.setTitle(text, for: .disabled)
            self.backgroundColor = #colorLiteral(red: 0, green: 0.6025887132, blue: 1, alpha: 1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
