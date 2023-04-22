Imports Microsoft.VisualBasic
Imports System.IO
Public Class cls_dir

    '************************** EMPRESAS
    Public Shared Function CARPETA_EMPRESAS() As String
        Dim carpeta As String = cls_utils.obtener_parametros("CARPETA_BASE") & "\Empresas"
        Return crear_carpeta_si_no_existe(carpeta)

    End Function

    Public Shared Function CARPETA_EMPRESA(cuit As String) As String
        Dim carpeta As String = CARPETA_EMPRESAS() & "\" & cuit
        Return crear_carpeta_si_no_existe(carpeta)

    End Function

    Public Shared Function CARPETA_LOTE(cuit As String, lote_id As Long) As String
        Dim carpeta As String = CARPETA_EMPRESA(cuit) & "\LOTE_" & lote_id
        Return crear_carpeta_si_no_existe(carpeta)

    End Function


    '************************** EMPLEADOS
    Public Shared Function CARPETA_EMPLEADOS() As String
        Dim carpeta As String = cls_utils.obtener_parametros("CARPETA_BASE") & "\Empleados"
        Return crear_carpeta_si_no_existe(carpeta)

    End Function


    Public Shared Function CARPETA_EMPLEADO(cuit As String) As String
        Dim carpeta As String = CARPETA_EMPLEADOS() & "\" & cuit
        Return crear_carpeta_si_no_existe(carpeta)

    End Function


    Public Shared Function CARPETA_CUIL_CERTIFICADOS(cuit As String) As String
        Dim carpeta As String = CARPETA_EMPLEADO(cuit)
        Return crear_carpeta_si_no_existe(carpeta)

    End Function
    Public Shared Function CARPETA_CERTIFICADOS(cuit As String) As String
        Dim carpeta As String = CARPETA_EMPLEADO(cuit) & "\certificados"
        Return crear_carpeta_si_no_existe(carpeta)

    End Function

    Public Shared Function CARPETA_CERTIFICADO(cuit As String, certificado_id As Long) As String
        Dim carpeta As String = CARPETA_EMPLEADO(cuit) & "\certificados\" & certificado_id
        Return crear_carpeta_si_no_existe(carpeta)

    End Function

    Public Shared Function CARPETA_DOCUMENTOS(cuit As String) As String
        Dim carpeta As String = CARPETA_EMPLEADO(cuit) & "\documentos"
        Return crear_carpeta_si_no_existe(carpeta)

    End Function

    Public Shared Function crear_carpeta_si_no_existe(carpeta As String) As String
        If Not Directory.Exists(carpeta) Then
            Directory.CreateDirectory(carpeta)
        End If
        Return carpeta
    End Function
End Class
