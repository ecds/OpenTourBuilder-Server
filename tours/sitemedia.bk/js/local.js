/*
    get_native_map_link
    @param lat
    @param lng
    @param label

    This returns a string formatted to the appropriate protocal for linking to the native mapp application
    TODO: add more conditions if other platforms require different protocol than map or geo
*/
function get_native_map_link(lat, lng, label) {
    var output = "maps:q="+ "[" + lat + "," + lng + "]";
    if (navigator.userAgent.match(/Android/i)) {
        output = "geo:" + lat + "," + lng + "?q="+lat + "," + lng + "("+ label +")";
    }

    return output ;
}