<?php

$conn = mysqli_connect("localhost","vassairm_DB","U_-EPF=+@yfog;RTyBzDTI*6","vassairm_CS_Stock");

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$getwatch=$conn->prepare("SELECT stockid FROM SelectStock WHERE userid = ?");
$getwatch->bind_param("i", $uid);

$uid = intval(htmlspecialchars($_GET["uid"]));

if (is_int($uid)){
    $getwatch->execute();
    $getwatch->bind_result($watching);
    $watchArray = array();
    $tempArray = array();
    while($getwatch->fetch()){
        $watchArray[] = $watching;
    }
}

$getStock=$conn->prepare("Select * FROM stock where stockid = ?");
$getstock->bind_param("i", $stockid);
$finalResult = Array();
$getStock->bind_result($tempStock);
foreach($watchArray as $stockid){
    $getStock->execute();
    $finalresult[] = $tempStock;
}

echo json_encode($finalResult);

mysqli_close($conn);
?>