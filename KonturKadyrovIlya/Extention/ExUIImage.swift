import UIKit

extension UIImage {
    static func load(from: String?, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            do {
                guard let urlStr = from,
                      !urlStr.isEmpty else {
                    return
                }
                let url = URL(string: urlStr)
                let data = try Data(contentsOf: url!)
                guard let image = UIImage(data: data) else {
                    debugPrint("faled get Image")
                    return
                }

                DispatchQueue.main.async {
                    completion(image)
                }
            } catch {
                debugPrint("faled get Image from Url")
            }
        }
    }
}
