import Felgo 3.0

SortFilterProxyModel {
    id: filterProxyModel

    property var targetModel
    property string searchValue
    property string targetRoleName

    sourceModel: targetModel
    filters: [
        AnyOf {
            enabled: searchValue !== ''
            RegExpFilter {
                roleName: targetRoleName
                pattern: searchValue
                caseSensitivity: Qt.CaseInsensitive
            }
        }
    ]
}
