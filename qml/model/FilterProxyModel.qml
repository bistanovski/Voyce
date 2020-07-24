import Felgo 3.0

/*!
    \qmltype FilterProxyModel
    \inherits SortFilterProxyModel
    \brief FilterProxyModel - wrapper around SortFilterProxyModel.

    FilterProxyModel provides reusable SortFilterProxyModel instance, with exported
    properties for source model, search pattern and target role.
*/

SortFilterProxyModel {
    id: filterProxyModel

    /*!
        \qmlproperty var targetModel
        Model on which the filtering should be executed
    */
    property var targetModel

    /*!
        \qmlproperty string searchValue
        Value provided for filtering through the model
    */
    property string searchValue

    /*!
        \qmlproperty string targetRoleName
        Defines on which model role the filtering should be done
    */
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
