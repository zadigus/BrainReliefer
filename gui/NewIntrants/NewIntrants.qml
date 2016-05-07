import QtQuick 2.0

Item {

    signal handle(string name)

    Component
    {
        id: bannerComponent

        Rectangle
        {
            id: banner
            width: parent.width
            height: 50
            gradient: clubcolors
            border {color: "#9EDDF2"; width: 2}
            Text
            {
                anchors.centerIn: parent
                text: "New Intrants"
                font.pixelSize: 32
            }
        }
    }

    Gradient
    {
        id: clubcolors
        GradientStop { position: 0.0; color: "#8EE2FE"}
        GradientStop { position: 0.66; color: "#7ED2EE"}
    }

    Component
    {
        id: titleDelegate
        Text
        {
            text: title;
            font.pixelSize: 24
        }
    }

    ListView
    {
        anchors.fill: parent

        signal handle(string name)

        orientation: ListView.Vertical

        model: newIntrantsModel
        delegate: titleDelegate
        header: bannerComponent
        footer: Rectangle {
            width: parent.width; height: 30;
            gradient: clubcolors
        }
        highlight: Rectangle {
            width: parent.width
            color: "lightgray"
        }
        Component.onCompleted: newIntrantsModel.reload()

    }
}
