import ApiKit

struct NewsCellViewModel {
    
    // MARK: - Properties
    
    let title: String
    
    let date: String
    
    let htmlContents: String

    // MARK: - Init
    
    init(article: Article) {
    
        self.title = article.title
        self.date = DateFormatter.common.string(from: article.date)
        self.htmlContents = article.htmlContents
    }
    
}
