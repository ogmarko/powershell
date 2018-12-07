$nameofgroup='GROUP NAME'
$groupsusers=get-adgroup -filter $nameofgroup |
    ForEach-Object{
                $settings=@{Group=$_.DistinguishedName;Member=$null}
        $_ | get-adgroupmember |
              ForEach-Object{
                                       $settings.Member=$_.DistinguishedName
                    New-Object PsObject -Property $settings
                }
    }
    $groupsusers | Export-Csv C:\Temp\GroupsUsers.csv -NoTypeInformation