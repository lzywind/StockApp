<?php

/*TODO
    Make this take in a JSON document from POST and slap it in an array
    Each array entry will be a different index result from Questrade
    Each index result is a dictionary/associative array
    Use Prepared Statements and grab what you need to update the table
    Find a way to update the short term price history if we even still want it
*/
$conn = mysqli_connect("localhost","vassairm_DB","U_-EPF=+@yfog;RTyBzDTI*6","vassairm_CS_Stock");

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

//Prepared Statement for updating all of the long term info
if(!($stmt = $conn->prepare("UPDATE Stock SET openPrice=?, high=?, low=?, lastUpdate = now() WHERE stockId=?;"))){
    echo "Prepare failed: (" . $conn->errno . ") " . $conn->error;
}

//Load POSTed JSON data into an associative array
$posted =  json_decode(file_get_contents("php://input"), true);

var_dump($posted); //For testing purposes

//Pre-allocate variables, then bind them to the statement
$open=0.0;
$high=0.0;
$low=0.0;
$id=0;
$stmt->bind_param("dddi", $open, $high, $low, $id);

//For every result in the JSON document, update the vars to match, then execute the prepared statement
foreach($posted as $sym){
    $open = $sym['openPrice'];
    $high = $sym['highPrice'];
    $low = $sym['lowPrice'];
    $id = $sym['symbolId'];
    $stmt->execute();
}

mysqli_close($conn);
?>