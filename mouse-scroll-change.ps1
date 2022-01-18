# This script set number of lines when scrolling the mouse wheel.

Param([int]$linevalue)

if($linevalue -le 0)
{
    Write-Output "Number of lines is less than or equal 0."
    exit
}

Add-Type @"
using System.Runtime.InteropServices;

public class W32Api
{
    [DllImport("user32.dll")]
    public static extern bool SystemParametersInfoA(uint uiAction, uint uiParam, int[] pvParam, uint fWinIni);
}
"@

$SPIF_SENDWININICHANGE = 2
$SPIF_UPDATEINIFILE = 1
$SPI_SETWHEELSCROLLLINES = 0x0069

$desktop = Get-ItemProperty 'HKCU:\Control Panel\Desktop'

[W32Api]::SystemParametersInfoA($SPI_SETWHEELSCROLLLINES, $linevalue, $null, $SPIF_SENDWININICHANGE -bor $SPIF_UPDATEINIFILE)