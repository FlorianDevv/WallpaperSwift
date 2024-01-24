

import Foundation
// Construit un objet URLComponents avec la base de l'API Unsplash
// Et un query item "client_id" avec la clé d'API retrouvé depuis PListManager
func unsplashApiBaseUrl() -> URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.unsplash.com"
    urlComponents.queryItems = [
        URLQueryItem(name: "client_id", value: ConfigurationManager.instance.plistDictionnary.clientId)
    ]
    return urlComponents
}

// Par défaut orderBy = "popular" et perPage = 10 -> Lisez la documentation de l'API pour comprendre les paramètres, vous pouvez aussi en ajouter d'autres si vous le souhaitez
func feedUrl(orderBy: String = "popular", perPage: Int = 10) -> URL? {
    var urlComponents = unsplashApiBaseUrl()
    urlComponents.path = "/photos"
    urlComponents.queryItems?.append(URLQueryItem(name: "order_by", value: orderBy))
    urlComponents.queryItems?.append(URLQueryItem(name: "per_page", value: String(perPage)))
    return urlComponents.url
}

func topicsUrl(perPage: Int) -> URL? {
    var urlComponents = unsplashApiBaseUrl()
    urlComponents.path = "/topics"
    urlComponents.queryItems?.append(URLQueryItem(name: "per_page", value: String(perPage)))
    return urlComponents.url
}

func topicsPhotos(slug: String) -> URL? {
    var urlComponents = unsplashApiBaseUrl()
    urlComponents.path = "/topics/\(slug)/photos"
    return urlComponents.url
}




