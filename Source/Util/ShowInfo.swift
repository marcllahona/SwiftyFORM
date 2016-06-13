// MIT license. Copyright (c) 2014 SwiftyFORM. All rights reserved.
import UIKit

extension FormBuilder {
	public func demo_showInfo(_ text: String) {
		let headerView = SectionHeaderViewFormItem()
		headerView.viewBlock = {
			return InfoView(frame: CGRect(x: 0, y: 0, width: 0, height: 100), text: text)
		}
		self.append(headerView)
	}
}

public class InfoView: UIView {
	public let label: UILabel
	
	public init(frame: CGRect, text: String) {
		self.label = UILabel()
		super.init(frame: frame)
		clipsToBounds = true
		self.addSubview(label)
		label.textColor = UIColor.darkGray()
		label.text = text
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyleBody)
	}
	
	public required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		let size = label.sizeThatFits(bounds.size)
		label.frame = CGRect(x: bounds.midX - size.width / 2, y: bounds.midY - size.height / 2, width: size.width, height: size.height)
	}
}
