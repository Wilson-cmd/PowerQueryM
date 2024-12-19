let 
    Source = Table.TransformColumnTypes(
    
    Table.ReplaceValue(    
    
    Table.TransformColumnTypes(
    Table.PromoteHeaders(
        Csv.Document((AzureStorage.Blobs("STORAGEACCOUNTNAME/disp-diaria"){[Name = "Simulation.csv"]}[Content]),
        
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
    #"Erros Substituídos" = Table.ReplaceErrorValues(Source, {{"Date", null}})
in
    #"Erros Substituídos"
