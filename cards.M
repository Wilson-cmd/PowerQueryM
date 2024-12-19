let
    Source = 

    Table.TransformColumnTypes(
    Table.ReplaceValue(
    Table.TransformColumnTypes(
    Table.SelectColumns(
    Table.PromoteHeaders(
        Csv.Document((AzureStorage.Blobs("https://STORAGEACCOUNTNAME.blob.core.windows.net/disp-diaria"){[Name = "Cards.csv"]}[Content]),
        [Delimiter=";",
        Columns=5,
        Encoding=65001,
        QuoteStyle=QuoteStyle.None]), [PromoteAllScalars=true])

    , {"Processos","Média Diária", "Média Mensal", "Média Anual"})
    
    ,{{"Processos", type text}, {"Média Diária", type text}, {"Média Mensal", type text}, {"Média Anual", type text}})

    ,".",",",Replacer.ReplaceText,{"Média Diária", "Média Mensal", "Média Anual"})

    , {{"Média Diária", Currency.Type}, {"Média Mensal", Currency.Type}, {"Média Anual", Currency.Type}})
in
    Source
