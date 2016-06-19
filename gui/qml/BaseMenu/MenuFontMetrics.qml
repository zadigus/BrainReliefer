import QtQuick 2.5

import "/js/Global.js" as Global

FontMetrics
{
    font.family: "Arial"

    property int targetTextWidth: mediator.width - 20

    property var myMenu

    // TODO: probably better to put that in the backend
    function setOptimalFontSize()
    {
        if(Global.optimalFontSize == 0)
        {
            Global.optimalFontSize = fixedPoint(myMenu.menus[myMenu.getBiggestStringId()].text)
            font.pixelSize = Global.optimalFontSize
        }
        else
        {
            font.pixelSize = Global.optimalFontSize
        }
    }

    function textWidth(pixelSize, text)
    {
        font.pixelSize = pixelSize
        return tightBoundingRect(text).width
    }

    function fixedPointFunction(pixelSize, text)
    {
//        console.log("pixel size = " + pixelSize + " text width = " + textWidth(pixelSize, text) + " rect width = " + mediator.width)
        return pixelSize - 0.001 * (textWidth(pixelSize, text) - targetTextWidth)
    }

    function fixedPoint(text)
    {
        var pixelSize = 0
        var newPixelSize = targetTextWidth
        do
        {
    //            console.log(Math.abs(pixelSize - newPixelSize))
            pixelSize = newPixelSize
            newPixelSize = fixedPointFunction(pixelSize, text)
        } while(textWidth(newPixelSize, text) > targetTextWidth)

        return newPixelSize
    }
}
