(adress as text) =>
/*
Takes an adress as parameter and obtains latitude and longitude. Specific to BCN
*/
let
    BaseURL = "https://www.cartociudad.es/geocoder/api/geocoder/findJsonp",
    FullAdress = adress & ", Barcelona",
    FullURL = BaseURL & "?q=" & Uri.EscapeDataString(FullAdress),

    Source = Text.Clean(Text.Trim(Text.FromBinary(Web.Contents(FullURL)))),

    // Extract lat value
    Coordenades = Text.BetweenDelimiters(Source, "POINT(", ")"),

    // Split by space into a list: {"lon", "lat"}
    SplitCoords = Text.Split(Coordenades, " "),

    // Extract each part
    Lon = SplitCoords{0},
    Lat = SplitCoords{1},

    // Return as record
    Output = [Latitude = Lat, Longitude = Lon]
in
    Output