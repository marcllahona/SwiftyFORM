// MIT license. Copyright (c) 2014 SwiftyFORM. All rights reserved.
import UIKit

@objc public protocol CellHeightProvider {
	func form_cellHeight(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat
}
