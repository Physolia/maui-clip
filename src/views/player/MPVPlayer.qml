import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3

import QtMultimedia 5.8

import org.mauikit.controls 1.3 as Maui

import org.kde.kirigami 2.14 as Kirigami

import mpv 1.0

MpvObject
{
    id: control
    property alias url : control.source
    property alias video : control

    readonly property bool playing : control.playbackState === MediaPlayer.PlayingState
    readonly property bool paused : control.playbackState === MediaPlayer.PausedState
    readonly property bool stopped :  control.playbackState === MediaPlayer.StoppedState

    autoPlay: true
    hardwareDecoding: settings.hardwareDecoding
    onEndOfFile: playNext()


    Maui.Dialog
    {
        id: _subtitlesDialog
        title: i18n("Subtitles")

        Repeater
        {
            model: control.subtitleTracksModel

            Maui.ListBrowserDelegate
            {
                Layout.fillWidth: true
                label1.text: model.text
                label2.text: model.language
            }
        }
    }

    Maui.Dialog
    {
        id: _audioTracksDialog
        title: i18n("Audio Tracks")

        Repeater
        {
            model: control.audioTracksModel

            Maui.ListBrowserDelegate
            {
                Layout.fillWidth: true
                label1.text: model.text
                label2.text: model.language
            }
        }
    }

    Row
    {
        visible: !control.stopped
        anchors.right: parent.right
        anchors.bottom: parent.bottom


        Maui.Badge
        {
            Kirigami.Theme.colorSet: Kirigami.Theme.Complementary
            Kirigami.Theme.inherit: false

            text: "Corrections"

            onClicked: control.editing = !control.editing

        }

        Maui.Badge
        {
            Kirigami.Theme.colorSet: Kirigami.Theme.Complementary
            Kirigami.Theme.inherit: false

            text: "Subtitles"
            onClicked: _subtitlesDialog.open()

        }

        Maui.Badge
        {
            Kirigami.Theme.colorSet: Kirigami.Theme.Complementary
            Kirigami.Theme.inherit: false

            text: "Audio"
            onClicked: _audioTracksDialog.open()
        }
    }
}



