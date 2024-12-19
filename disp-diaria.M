let
    // Column's list
    ARRAYCOLUMNNAME = {"Bridges", "Date", "Value"},


    Source = 
    Table.TransformColumnTypes(
    Table.UnpivotOtherColumns(
    Table.PromoteHeaders(
    Table.ReplaceErrorValues(
    Table.CombineColumns(
    Table.FillDown(
    Table.Transpose(
    Table.RemoveRows(
    Excel.Workbook(AzureStorage.Blobs(Text.Combine({URL, CONTAINER})){[Name = Text.Combine({WORKSHEETS, ".xlsm"})]}[Content]){[Item = SHEET, Kind = "Sheet"]}[Data]
    , 2, 2))
    ,{"Column1"})
    ,{"Column1", "Column2"}, Combiner.CombineTextByDelimiter(" : ", QuoteStyle.None), ARRAYCOLUMNNAME{0})
    ,{{ARRAYCOLUMNNAME{0}, ARRAYCOLUMNNAME{0}}})
    ,[PromoteAllScalars = true])
    ,{ARRAYCOLUMNNAME{0}}, ARRAYCOLUMNNAME{1}, ARRAYCOLUMNNAME{2})
    ,{
        {ARRAYCOLUMNNAME{0}, Text.Type}
        ,{ARRAYCOLUMNNAME{1}, type date}
        ,{ARRAYCOLUMNNAME{2}, Number.Type}
    })
in
    Source
