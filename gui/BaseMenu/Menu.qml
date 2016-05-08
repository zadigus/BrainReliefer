import QtQuick 2.5

import "/js/Global.js" as Global

Item
{
    id: baseMenu
    objectName: "baseMenu"

    property var menus
    property var menuFontMetrics

    signal handle(string name)

    function buildMenu(itemHeight)
    {
        menuFontMetrics.setOptimalFontSize()

        for(var i = 0; i < menus.length; ++i)
        {
            var component = Qt.createComponent("/BaseMenu/MenuItem.qml")
//            console.log("error = " + component.errorString())
            var rect = component.createObject(baseMenu, {"width": mediator.width, "height": itemHeight})
            rect.menuText = menus[i].text
            rect.menuLink = menus[i].link
            rect.menuFont = menuFontMetrics.font
        }
    }

    function getBiggestStringId()
    {
        var idx = 0
        var maxLength = 0
        for(var i = 0; i < menus.length; ++i)
        {
            if(menus[i].text.length > maxLength)
            {
                idx = i
                maxLength = menus[i].text.length
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
}
