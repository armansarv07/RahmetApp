import UIKit
import SnapKit

class BlueButton: UIButton {
    init(text: String, rightText: String? = nil, leftText: String? = nil, isActive: Bool = true) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.isEnabled = isActive

        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor: UIColor.white]
        let title = NSAttributedString(string: text, attributes: attributes)
        self.setAttributedTitle(title, for: .normal)
        
        let rightLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .medium)
            label.textColor = .white
            return label
        }()
        
        let leftLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .medium)
            label.textColor = .white
            return label
        }()
        
        self.addSubview(rightLabel)
        self.addSubview(leftLabel)
        
        rightLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        
        leftLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        
        if let rightText = rightText {
            rightLabel.text = rightText
        }

        if let leftText = leftText {
            leftLabel.text = leftText
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
