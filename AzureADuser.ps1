<#
AzureAD�Ƀ��[�U�ǉ����āA
AWS�O���[�v�ɏ������邽�߂̃X�N���v�g
AzureCloudShell��Ŏ��s����
#>

# �p�X���[�h�̓���
$NewUserName = Read-Host -Prompt "���[�U������͂��Ă�������"
$NewPassword = Read-Host -Prompt "�p�X���[�h����͂��Ă�������" -AsSecureString
$EnterPassword = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword)
$Plain = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($EnterPassword)

# �K�v�Ȓ萔�錾
$DisplayAWSUSES = "AWSUsers"
$AWSGroup = Get-AzureADGroup | Where-Object {$_.DisplayName -eq "AWSUsers"} # �O���[�vID
$DomainName = "@dyutech.onmicrosoft.com"

# AzureAD�p�̃p�X���[�h�̂��܂��Ȃ�
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = $Plain

# AzureAD�Ƀ��[�U��ǉ����A�K�v�ȃO���[�v�ɒǉ�
$NewUser = New-AzureADUser -AccountEnabled $true -DisplayName $NewUserName -PasswordProfile $PasswordProfile -MailNickName $NewUserName -UserPrincipalName ($NewUserName+$DomainName)
Add-AzureADGroupMember -ObjectId $AWSGroup.ObjectId -RefObjectId $NewUser.ObjectId
