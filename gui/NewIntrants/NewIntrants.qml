import QtQuick 2.5

import "/js/Global.js" as Global
import "../BaseMenu"

Menu
{
    id: mainMenu

    menus: [
                {text: "Add Intrant",          link: "newIntrants.add"},
                {text: "Manage New Intrants",  link: "newIntrants.manage"},
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
        buildMenu(Global.menuHeight)
    }
}
