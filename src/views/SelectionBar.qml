import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

import org.mauikit.controls 1.3 as Maui
import org.mauikit.filebrowsing 1.2 as FB

Maui.SelectionBar
{
    id: control

    onExitClicked:
    {
        selectionMode = false
        clear()
    }

    listDelegate: Maui.ListBrowserDelegate
    {
        height: Maui.Style.toolBarHeight
        width: ListView.view.width

        label1.text: model.label
        label2.text: model.path
        imageSource: model.thumbnail
        iconSizeHint: height * 0.9
        checkable: true
        checked: true
        onToggled: control.removeAtIndex(index)
    }

    Action
    {
        text: i18n("Play")
        icon.name: "media-playback-start"
        onTriggered:
        {
            playItems(control.items, 0)
            control.clear()
        }
    }

    Action
    {
        text: i18n("Queue")
        icon.name: "media-playlist-play"
        onTriggered:
        {
            queueItems(control.items, 0)
            control.clear()
        }
    }

    Action
    {
        text: i18n("Un/Fav")
        icon.name: "love"
        onTriggered: VIEWER.fav(control.uris)
    }

    Action
    {
        text: i18n("Tag")
        icon.name: "tag"
        onTriggered:
        {
            dialogLoader.sourceComponent = tagsDialogComponent
            dialog.composerList.urls = control.uris
            dialog.open()
        }
    }

    Action
    {
        text: i18n("Share")
        icon.name: "document-share"
        onTriggered:
        {
             Maui.Platform.shareFiles(control.uris)
        }
    }

    Action
    {
        text: i18n("Export")
        icon.name: "document-save"
        onTriggered:
        {
            const pics = control.uris
            dialogLoader.sourceComponent= fmDialogComponent
            dialog.show(function(paths)
            {
                for(var i in paths)
                    FB.FM.copy(pics, paths[i])
            });
        }
    }

    Action
    {
        text: i18n("Remove")
        icon.name: "edit-delete"
        Maui.Theme.textColor: Maui.Theme.negativeTextColor
        onTriggered:
        {
            dialogLoader.sourceComponent = removeDialogComponent
            dialog.open()
        }
    }

    function insert(item)
    {
        if(control.contains(item.path))
        {
            control.removeAtUri(item.path)
            return
        }

        control.append(item.path, item)
    }
}

