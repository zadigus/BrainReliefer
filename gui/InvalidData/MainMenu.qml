import QtQuick 2.5

import "/js/Global.js" as Global
import "../BaseMenu"

Menu
{
    id: invalidDataMenu

    menus: [
                {text: qsTr("New Data"),     link: "invalidData.new"},
                {text: qsTr("Load Data"),    link: "invalidData.load"}
            ]

    menuFontMetrics: myMenuFontMetrics

    MenuFontMetrics
    {
        id: myMenuFontMetrics
        myMenu: invalidDataMenu
    }

    Component.onCompleted:
    {
        windowHeader.text = qsTr("Wrong data")

        buildMenu(Global.menuHeight)
    }
}
