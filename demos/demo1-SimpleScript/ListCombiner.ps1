Install-Module -Name Pester -Scope CurrentUser -SkipPublisherCheck
Import-Module c:\source\repos\mmsPester\Pester -Force
$list1 = @()
$list1 += 'a','b','c','d'

$list2 = @()
$list2 += 'b','c','d','e'

$uniqueList1 = $list1 | Sort-Object | Get-Unique
$uniqueList2 = $list2 | Sort-Object | Get-Unique

foreach($listItem in $uniqueList1) {
    $uniqueList2 += $listItem
}
$uniqueCombinedList = $uniqueList2 | Sort-Object | Get-Unique
$uniqueCombinedList