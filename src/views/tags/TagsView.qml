import QtQuick 2.14
import QtQml 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3

import org.kde.mauikit 1.2 as Maui
import org.kde.kirigami 2.8 as Kirigami

import org.maui.cinema 1.0 as Cinema


Maui.AltBrowser
{
    id: control

    gridView.margins: Maui.Style.space.medium
    gridView.itemSize: 180

    listView.topMargin: Maui.Style.contentMargins
    listView.spacing: Maui.Style.space.big

    holder.visible: _tagsList.count === 0
    holder.emojiSize: Maui.Style.iconSizes.huge
    holder.emoji: "qrc:/img/assets/tag.svg"
    holder.title: qsTr("No Tags!")
    holder.body: qsTr("Add a new tag to start organizing you video collection.")

    Binding on viewType
    {
        value: control.width < Kirigami.Units.gridUnit * 30 ? Maui.AltBrowser.ViewType.List : Maui.AltBrowser.ViewType.Grid
        restoreMode: Binding.RestoreBinding
    }

    Maui.FloatingButton
    {
        z: parent.z + 1
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: height
        height: Maui.Style.toolBarHeight

        icon.name: "list-add"
        icon.color: Kirigami.Theme.highlightedTextColor
        onClicked: newTagDialog.open()
    }

    Maui.NewDialog
    {
        id: newTagDialog
        title: i18n("New tag")
        message: i18n("Create a new tag to organize your gallery")
        acceptButton.text : i18n("Add")
        onFinished:
        {
            tagsList.insert(text)
        }

        onRejected: close()
    }

    model: Maui.BaseModel
    {
        id: _collectionModel
        sortOrder: Qt.DescendingOrder
        sort: "modified"
        recursiveFilteringEnabled: true
        sortCaseSensitivity: Qt.CaseInsensitive
        filterCaseSensitivity: Qt.CaseInsensitive
        list: Cinema.Tags
        {
            id: _tagsList
        }
    }

    listDelegate: Maui.ListDelegate
    {
        width: parent.width
        label: model.tag

    }
}
