import ScrollableGraphView
import TableKit
import Utils

class GraphCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let dataPointSpacing: CGFloat = 54
        
        static let barLineWidth: CGFloat = 0
        
        static let barWidth: CGFloat = 10
        
    }
    
    // MARK: - Views
    
    private let plot: BarPlot = {
        let plot = BarPlot(identifier: .empty)
        plot.shouldRoundBarCorners = true
        plot.barLineWidth = Constants.barLineWidth
        plot.barWidth = Constants.barWidth
        return plot
    }()
    
    private let referenceLines: ReferenceLines = {
        let referenceLines = ReferenceLines()
        referenceLines.dataPointLabelFont = .medium12()
        referenceLines.referenceLineLabelFont = UIFont.medium12() ?? .systemFont(ofSize: 12, weight: .medium)
        referenceLines.referenceLineColor = .clear
        referenceLines.relativePositions = [0, 0.5, 1]
        return referenceLines
    }()
    
    private lazy var graphView = makeGraphView()

    // MARK: - Properties

    private var viewModel: GraphCellViewModel?
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: self)
    }
    
    // MARK: - Views
    
    override func addViews() {
        contentView.addSubview(graphView)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureGraphViewConstraints()
    }
    
}

// MARK: - Themeable

extension GraphCell: Themeable {
    
    func apply(theme: Theme) {
        graphView.snp.removeConstraints()
        graphView.removeFromSuperview()
        graphView = makeGraphView()
        addViews()
        configureConstraints()
        
        graphView.backgroundFillColor = theme.primaryBackgroundColor
        plot.barColor = theme.accentColor
        referenceLines.dataPointLabelColor = theme.primaryTextColor
        referenceLines.referenceLineLabelColor = theme.primaryTextColor
    }
    
}

// MARK: - ConfigureCell

extension GraphCell: ConfigurableCell {
    
    static let defaultHeight: CGFloat? = 250
    
    func configure(with viewModel: GraphCellViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - ScrollableGraphViewDataSource

extension GraphCell: ScrollableGraphViewDataSource {
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        return item(for: pointIndex)?.value ?? 0
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return item(for: pointIndex)?.dateGraphString ?? .empty
    }
    
    func numberOfPoints() -> Int {
        return viewModel?.statItems.count ?? 0
    }
    
}

// MARK: - Constraints

private extension GraphCell {
    
    func configureGraphViewConstraints() {
        graphView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
}

// MARK: - Private

private extension GraphCell {
    
    func item(for pointIndex: Int) -> StatItem? {
        guard let viewModel = viewModel else { return nil }
        let items = viewModel.statItems
        
        return items[items.count - pointIndex - 1]
    }
    
    func makeGraphView() -> ScrollableGraphView {
        let graphView = ScrollableGraphView()
        graphView.rightmostPointPadding = CGFloat.horizontalMargin
        graphView.shouldRangeAlwaysStartAtZero = true
        graphView.shouldAdaptRange = true
        graphView.direction = .rightToLeft
        graphView.dataPointSpacing = Constants.dataPointSpacing
        graphView.addPlot(plot: plot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        graphView.dataSource = self
        graphView.showsHorizontalScrollIndicator = false
        return graphView
    }
    
}
