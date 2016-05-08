import QtQuick 2.5

import "/js/Global.js" as Global
import "../BaseMenu"

Menu
{
    id: mainMenu

    menus: [
                {text: "New Intrants",          link: "newIntrants"},
                {text: "Incubated Intrants",    link: "incubatedIntrants"},
                {text: "References",            link: "references"},
                {text: "Projects",              link: "projects"},
                {text: "Next Actions",          link: "nextActions"},
                {text: "Agenda",                link: "agenda"}
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
        windowFooter.activateHome(false)

        Global.menuHeight = mediator.height / mainMenu.menus.length

        buildMenu(Global.menuHeight)
    }
}
