$port = Read-Host "Enter the 2-Letter Prefix for the site "
Get-Printer | Where-Object {$_.Shared -eq $true -and $_.PortName -Like "$($port)-*"}
    ForEach-Object {
        $printerName = $_.Name
        $result = Get-CimInstance Win32_Printer -Filter "name LIKE '$printerName'" |
            Invoke-CimMethod -MethodName printtestpage 
        if ($result.ReturnValue -eq 0)
        {
            "Test page printed on $printerName."
        }
        else
        {
            "Unable to print test page on $printerName."
            "Error code $($result.ReturnValue)."
        }
    }