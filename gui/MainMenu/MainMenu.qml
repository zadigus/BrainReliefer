import QtQuick 2.5

import "MainMenu"

Item
{
    id: mainMenu
    objectName: "mainMenu"

    property var menus:
    [
        "New Intrants",
        "Incubated Intrants",
        "References",
        "Projects",
        "Next Actions",
        "Agenda"
    ]

    signal handle(string name)

    Component.onCompleted:
    {
        menuFontMetrics.setOptimalFontSize()

        for(var i = 0; i < mainMenu.menus.length; ++i)
        {
            var component = Qt.createComponent("MenuItem.qml")
            var rect = component.createObject(mainMenu, {"width": getMediator().getWidth(), "height": getMediator().getHeight() / mainMenu.menus.length})
            rect.menuText = menus[i]
            rect.menuFont = menuFontMetrics.font
        }
    }

    MenuFontMetrics
    {
        id: menuFontMetrics
        myMenu: mainMenu
    }

    function switchTo(name)
    {
        handle(name)
    }

    function getBiggestStringId()
    {
        var idx = 0
        var maxLength = 0
        for(var i = 0; i < mainMenu.menus.length; ++i)
        {
            if(mainMenu.menus[i].length > maxLength)
            {
                idx = i
                maxLength = mainMenu.menus[i].length
            }
        }
        return idx
    }

    function itemIndex(item)
    {
        if (item.parent == null)
            return -1
        var siblings = item.parent.children
        for (var i = 0; i < siblings.length; ++i)
            if (siblings[i] == item)
                return i
        return -1 //will never happen
    }

    function previousItem(item)
    {
        if (item.parent == null)
            return null
        var index = itemIndex(item)
        return (index > 0) ? item.parent.children[itemIndex(item) - 1] : null
    }

    function nextItem(item)
    {
        if (item.parent == null)
            return null

        var index = itemIndex(item)
        var siblings = item.parent.children

        return (index < siblings.length - 1) ? siblings[index + 1] : null
    }

    function getMediator()
    {
        return mainMenu.parent
    }
}
