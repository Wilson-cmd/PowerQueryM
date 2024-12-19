let 
    Source = 
    Table.ReplaceErrorValues(
    Table.TransformColumnTypes(
    
    Table.ReplaceValue(    
    
    Table.TransformColumnTypes(
    Table.PromoteHeaders(
        Csv.Document((AzureStorage.Blobs(Text.Combine({URL, CONTAINER})){[Name = Text.Combine({WORKSHEETS, ".csv"})]}[Content]),
        
        [Delimiter=",",
        Columns=4,
        Encoding=65001,
        QuoteStyle=QuoteStyle.None]), [PromoteAllScalars=true]),


            {
        {"Process", type text}, 
        {"Variable", type text}, 
        {"Value", type text}, 
        {"Date", type datetime}
    }


    ),".",",", Replacer.ReplaceText, {"Value"}),
    {{"Value", type number}}),
    {{"Date", null}})
in
    Source
