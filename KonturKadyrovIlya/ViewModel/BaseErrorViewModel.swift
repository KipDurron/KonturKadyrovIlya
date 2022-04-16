//
//  BaseErrorViewModel.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 16.04.2022.
//

import Foundation

struct BaseErrorViewModel {
    var title: String
    var titleButton: String
    var refreshButtonAction: (() -> Void)?
    
    internal init(title: String = Constants.title,
                  titleButton: String = Constants.titleButton,
                  refreshButtonAction: (() -> Void)? = nil) {
        self.title = title
        self.titleButton = titleButton
        self.refreshButtonAction = refreshButtonAction
    }
}


//MARK: - Constants

private extension BaseErrorViewModel {
    enum Constants {
        static let title = "Что-то пошло не так"
        static let titleButton = "Обновить"
    }
}
