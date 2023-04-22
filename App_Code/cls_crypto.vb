Imports System.IO
Imports System.Text
Imports System.Security.Cryptography
Imports Microsoft.VisualBasic
Imports System


'Ejemplo uso de la clase: Crypto.Encrypt(TextoOrigen,ClaveEncriptacion), Crypto.Decrypt(TextoEncriptado,ClaveEncriptacion)
Public Class cls_crypto
    Public Const pkey As String = "" '"C0d1g0N4t1v0"
    Private Shared DES As New TripleDESCryptoServiceProvider
    Private Shared MD5 As New MD5CryptoServiceProvider
    Private Shared Function MD5Hash(ByVal value As String) As Byte()
        Return MD5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(value))
    End Function

    Public Shared Function Encrypt(ByVal stringToEncrypt As String, Optional ByVal key As String = pkey) As String
       
        DES.Key = cls_crypto.MD5Hash(key)
        DES.Mode = CipherMode.ECB
        Dim Buffer As Byte() = ASCIIEncoding.ASCII.GetBytes(stringToEncrypt)
        Return Convert.ToBase64String(DES.CreateEncryptor().TransformFinalBlock(Buffer, 0, Buffer.Length))
    End Function

    Public Shared Function Decrypt(ByVal encryptedString As String, Optional ByVal key As String = pkey) As String
        Try
          
            DES.Key = cls_crypto.MD5Hash(key)
            DES.Mode = CipherMode.ECB
            Dim Buffer As Byte() = Convert.FromBase64String(encryptedString)
            Return ASCIIEncoding.ASCII.GetString(DES.CreateDecryptor().TransformFinalBlock(Buffer, 0, Buffer.Length))
        Catch ex As Exception
            ' MsgBox("Invalid Key", MsgBoxStyle.OkOnly, "Decryption Failed")
            Return ""
        End Try
    End Function
End Class