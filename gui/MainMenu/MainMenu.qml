import QtQuick 2.5

import "/js/Global.js" as Global
import "../BaseMenu"

Menu
{
    id: mainMenu

    menus: [
                {text: qsTr("New Intrants"),          link: "newIntrants"},
                {text: qsTr("Incubated Intrants"),    link: "incubatedIntrants"},
                {text: qsTr("References"),            link: "references"},
                {text: qsTr("Projects"),              link: "projects"},
                {text: qsTr("Next Actions"),          link: "nextActions"},
                {text: qsTr("Agenda"),                link: "agenda"}
            ]

    menuFontMetrics: myMenuFontMetrics

    MenuFontMetrics
    {
        id: myMenuFontMetrics
        myMenu: mainMenu
    }

    Component.onCompleted:
    {
        dataManager.load("config/Data.xml")

        windowFooter.activateBackArrow(Global.history.length >= 2)
        windowFooter.activateHome(false)
        windowHeader.text = qsTr("Home")

        Global.menuHeight = mediator.height / mainMenu.menus.length

        buildMenu(Global.menuHeight)
    }
}
