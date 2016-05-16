import QtQuick 2.5

import "/js/Global.js" as Global
import "../BaseMenu"

Menu
{
    id: mainMenu

    menus: [
                {text: qsTr("Add"),     link: "newIntrants.add"},
                {text: qsTr("Manage"),  link: "newIntrants.manage"},
            ]

    menuFontMetrics: myMenuFontMetrics

    MenuFontMetrics
    {
        id: myMenuFontMetrics
        myMenu: mainMenu
    }

    Component.onCompleted:
    {
        windowFooter.activateBackArrow(Global.history.length >= 2)
        windowHeader.text = qsTr("New Intrants")
        buildMenu(Global.menuHeight)
    }
}
