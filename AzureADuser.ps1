<#
AzureADにユーザ追加して、
AWSグループに所属するためのスクリプト
AzureCloudShell上で実行する
#>

# パスワードの入力
$NewUserName = Read-Host -Prompt "ユーザ名を入力してください"
$NewPassword = Read-Host -Prompt "パスワードを入力してください" -AsSecureString
$EnterPassword = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword)
$Plain = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($EnterPassword)

# 必要な定数宣言
$DisplayAWSUSES = "AWSUsers"
$AWSGroup = Get-AzureADGroup | Where-Object {$_.DisplayName -eq "AWSUsers"} # グループID
$DomainName = "@dyutech.onmicrosoft.com"

# AzureAD用のパスワードのおまじない
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = $Plain

# AzureADにユーザを追加し、必要なグループに追加
$NewUser = New-AzureADUser -AccountEnabled $true -DisplayName $NewUserName -PasswordProfile $PasswordProfile -MailNickName $NewUserName -UserPrincipalName ($NewUserName+$DomainName)
Add-AzureADGroupMember -ObjectId $AWSGroup.ObjectId -RefObjectId $NewUser.ObjectId
