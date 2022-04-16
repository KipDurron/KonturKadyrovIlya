//
//  BaseErrorViewModel.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 16.04.2022.
//

import Foundation

struct BaseErrorViewModel {
    var title: String = Constants.title
    var titleButton: String = Constants.titleButton
    var refreshButtonAction: (() -> Void)? = nil
}


//MARK: - Constants

private extension BaseErrorViewModel {
    enum Constants {
        static let title = "Что-то пошло не так"
        static let titleButton = "Обновить"
    }
}
