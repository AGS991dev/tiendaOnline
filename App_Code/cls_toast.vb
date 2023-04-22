Imports Microsoft.VisualBasic

Public Class cls_toast


    Public Shared Sub agregar(mensaje As String)
        Dim listado_toast As List(Of String) = HttpContext.Current.Session("listado_toast")

        If IsNothing(listado_toast) Then
            listado_toast = New List(Of String)
        End If

        listado_toast.Add(mensaje)
        HttpContext.Current.Session("listado_toast") = listado_toast
    End Sub



    Public Shared Function consumir() As List(Of String)

        Dim listado_toast As List(Of String) = HttpContext.Current.Session("listado_toast")

        'vacio
        HttpContext.Current.Session("listado_toast") = New List(Of String)

        If IsNothing(listado_toast) Then
            listado_toast = New List(Of String)
        End If
        Return listado_toast

    End Function

End Class
