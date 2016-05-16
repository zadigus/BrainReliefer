import QtQuick 2.5
import QtGraphicalEffects 1.0

Rectangle
{
    signal goHome()
    signal goBack()

    border
    {
        color: "black"
        width: 2
    }

    Image
    {
        id: backArrow
        x: parent.width / 4 - width / 2
        source: "../images/backArrow.png"
        sourceSize: Qt.size(parent.height, parent.height)

        MouseArea
        {
            anchors.fill: parent
            onClicked: if(!backArrowOverlay.visible) goBack()
        }
    }

    ColorOverlay
    {
        id: backArrowOverlay
        anchors.fill: backArrow
        source: backArrow
        color: "white"
        visible: false
    }

    Image
    {
        id: home
        x: 3 * parent.width / 4 - width / 2
        source: "../images/home.png"
        sourceSize: Qt.size(parent.height, parent.height)

        MouseArea
        {
            anchors.fill: parent
            onClicked: if(!homeOverlay.visible) goHome()
        }
    }

    ColorOverlay
    {
        id: homeOverlay
        anchors.fill: home
        source: home
        color: "white"
        visible: false
    }

    function activateBackArrow(visible)
    {
        backArrowOverlay.visible = !visible
    }

    function activateHome(visible)
    {
        homeOverlay.visible = !visible
    }

}
