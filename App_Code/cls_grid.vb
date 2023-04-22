Imports Microsoft.VisualBasic
Imports System.Data

Public Class cls_grid

    Public tableid As String = "id-table"
    Public dt As DataTable
    Public url_form As String = ""

    Public show_delete As Boolean = True
    Public show_edit As Boolean = True
    Public show_view As Boolean = False

    Public extra_actions As String = ""

    Sub disabled_all_actions()
        Me.show_delete = False
        Me.show_edit = False
        Me.show_view = False
    End Sub

    Public ReadOnly Property has_action As Boolean
        Get
            Return Me.show_delete Or Me.show_edit Or Me.show_view Or Me.extra_actions <> ""
        End Get
    End Property

    Sub New(ByVal dt As DataTable, url_form As String)
        Me.dt = dt
        Me.url_form = url_form

        If Me.url_form = "" Then
            Me.show_delete = False
            Me.show_edit = False
            Me.show_view = False
        End If
    End Sub

    Public Function html(Optional custom_head As String = "", Optional custom_body As String = "") As String

        If dt.Rows.Count <= 0 Then
            Return "<div class='card-panel card_color center'><span class='white-text '> La consulta actual no tiene registros</span></div>"
        End If

        Dim show_view_dev As Boolean = Me.show_view
        Dim show_delete_dev As Boolean = Me.show_delete
        Dim show_edit_dev As Boolean = Me.show_edit


        Dim s As New StringBuilder
        s.Append("<table  id='" & Me.tableid & "' class='striped'>")
        s.Append(IIf(custom_head <> "", custom_head, Me.get_html_head()))
        s.Append(IIf(custom_body <> "", custom_body, Me.get_html_body()))
        s.Append("</table>")
        Return s.ToString

    End Function

  

    Private Function get_html_head() As String

        Dim s As New StringBuilder
        Dim col As String

        s.Append("<thead>")
        s.Append("  <tr>")

        For Each item As DataColumn In Me.dt.Columns

            col = item.ColumnName.Replace("_", " ")
            If col.ToLower <> "row-css" Then
                col = System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(col)
                s.AppendFormat("        <th data-field='{0}'>{0}</th>", col)
            End If
        Next

        If Me.has_action Then
            s.AppendFormat("        <th style='text-align:center'>{0}</th>", "Acciones")
        End If

        s.Append("  </tr>")
        s.Append("</thead>")

        Return s.ToString

    End Function

    Private Function get_html_body() As String

        Dim s As New StringBuilder
        Dim span_edit, span_delete, span_view, span_extra As String
        Dim col_id As Integer = 0

        Dim url As String = ""

        Dim base_span_edit As String = "<a href='{0}' ><span class='waves-effect waves-light btn-small tooltipped card_color' data-position='top' data-tooltip='Editar' ><i class='material-icons'>edit</i></a>"
        Dim base_span_delete As String = "<a id='btn_delete' url='{0}' obj_id='{1}' onclick='eliminar_registro(this);' ><span class='waves-effect waves-light red btn-small tooltipped' data-position='top' data-tooltip='Eliminar' ><i class='material-icons'>delete</i></a>"
        Dim base_span_view As String = "<a href='{0}' ><span class='waves-effect waves-light btn-small tooltipped card_color' data-position='top' data-tooltip='Ver' ><i class='material-icons'>remove_red_eye</i></a>"
        Dim base_span_extra As String = Me.extra_actions

        s.Append("<tbody>")

        For Each row As DataRow In Me.dt.Rows
            Try
                Dim row_css As String = row("row-css")
                s.Append("<tr class='" & row_css & "'>")
            Catch ex As Exception
                s.Append("<tr>")

            End Try

            'agregar celdas con información
            For col As Integer = 0 To dt.Columns.Count - 1
                Dim col_name As String = dt.Columns(col).ColumnName.ToLower
                If col_name <> "row-css" Then
                    col_name = Threading.Thread.CurrentThread.CurrentCulture.TextInfo.ToTitleCase(col_name)
                    s.AppendFormat("<td data-th='{0}'>{1}</td>", col_name, row(col))
                End If
            Next

            'agregar celda con acciones
            If has_action Then

                s.Append("<td style='text-align:center'>")

                'preparamos url
                url = url_form
                If url.Contains("?") Then
                    url &= "&id=" & row(col_id)
                Else
                    url &= "?id=" & row(col_id)
                End If

                'Creamos botones
                If Me.show_edit Then
                    span_edit = String.Format(base_span_edit, url, row(col_id))
                    s.AppendFormat("{0}&nbsp;&nbsp;", span_edit)
                End If

                If Me.show_view Then
                    span_view = String.Format(base_span_view, url, row(col_id))
                    s.AppendFormat("{0}&nbsp;&nbsp;", span_view)
                End If

                If Me.show_delete Then
                    span_delete = String.Format(base_span_delete, url_form, row(col_id))
                    s.AppendFormat("{0}&nbsp;&nbsp;", span_delete)
                End If

                If base_span_extra <> "" Then
                    span_extra = String.Format(base_span_extra, row(col_id))
                    s.AppendFormat("{0}&nbsp;&nbsp;", span_extra)
                End If

                s.Append("</td>")

            End If
            s.Append("</tr>")
        Next

        s.Append("</tbody>")

        Return s.ToString()
    End Function


    Public Class gridview

        'EXCLUSIVOS PARA GRIDVIEW ASPX
        Public Shared Sub head(ByRef e As GridViewRowEventArgs)
            If (e.Row.RowType = DataControlRowType.Header) Then
                e.Row.TableSection = TableRowSection.TableHeader
            End If
        End Sub

        Public Shared Function is_data(ByVal e As GridViewRowEventArgs) As Boolean
            Return (e.Row.RowType = DataControlRowType.DataRow)
        End Function

        Public Shared Function get_hidden(ByVal e As GridViewRowEventArgs, id As String) As HiddenField
            Return e.Row.FindControl(id)
        End Function

        Public Shared Function get_button(ByVal e As GridViewRowEventArgs, id As String) As Button
            Return e.Row.FindControl(id)
        End Function

        Public Shared Function get_link(ByVal e As GridViewRowEventArgs, id As String) As LinkButton
            Return e.Row.FindControl(id)
        End Function
    End Class
    


End Class



