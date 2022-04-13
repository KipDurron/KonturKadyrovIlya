//
//  LabelButtonViewModel.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 13.04.2022.
//

import Foundation
import UIKit
struct LabelButtonViewModel {
    var labelAttrString: NSAttributedString
    var buttonImage: UIImage? = nil
    var actionButton: (() -> Void)? = nil
}
