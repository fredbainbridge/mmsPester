function ConvertTo-UniqueSortedList {
    <#
    .SYNOPSIS
    get a sorted list of unique properties for one or more lists.
    
    .DESCRIPTION
    this will return a list of unique properties for one or more lists.
    
    .EXAMPLE
    $list1 += 'a','b','c','d'
    $list2 += 'b','c','d','e'
    $list = ConvertTo-UniqueSortedList -Lists $list1, $list2

    .EXAMPLE
    $list1 = @(
        @{Name = 'a'; Value = '1';}, 
        @{Name = 'b'; Value = '2';},
        @{Name = 'c'; Value = '3';}
    )
    $list2 = @(
        @{Name = 'd'; Value = '4';}, 
        @{Name = 'e'; Value = '5';},
        @{Name = 'a'; Value = '1';}
    )
    $list = ConvertTo-UniqueSortedList -List $list1, $list2 -SortProperty 'Name'

    .NOTES
    This will only return the sorted unique property if SoftProperty is specified.

    #>
    [OutputType([psobject[]])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [psobject[]]$Lists,

        [Parameter(Mandatory=$false)]
        [string]$SortProperty
    )
    $combinedList = @()
    foreach($list in $lists) {
        foreach($item in $list) {
            if([string]::IsNullOrEmpty($SortProperty)) {
                $combinedList += $item
            }
            else {
                if($combinedList.$($SortProperty) -notcontains $item) {
                    $combinedList += $item
                }
            }
        }
    }
    $sortedUniqueList = @()
    if([string]::IsNullOrEmpty($SortProperty)) {
        $sortedUniqueList = $combinedList | Sort-Object | Get-Unique
    }
    else {
        $sortedUniqueList = $combinedList.$($SortProperty) | Sort-Object | Get-Unique
        
    }
    $sortedUniqueList   
}