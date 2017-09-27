<?php

$conn = mysqli_connect("localhost","vassairm_DB","U_-EPF=+@yfog;RTyBzDTI*6","vassairm_CS_Stock");

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$uid = intval(htmlspecialchars($_GET["userid"]));

//gets the IDs of the stocks the specified user is watching
$getwatch=$conn->prepare("SELECT stockId FROM SelectStock WHERE userId = ?");
$getwatch->bind_param("i", $uid);

if (is_int($uid)){
    $getwatch->execute();
    $getwatch->bind_result($watching);
    $watchArray = array();
    $tempArray = array();
    while($getwatch->fetch()){
        $watchArray[] = $watching;
    }
}

$getwatch->close();

//gets the stock info of the stocks retrieved from the query above
$getStock=$conn->prepare("Select * FROM Stock WHERE stockId = ?");
$getStock->bind_param("i", $stockid);

    $getStock->execute();
    
    $meta=$getStock->result_metadata();
    while($field = $meta->fetch_field()){
        $params[] = &$row[$field->name];
    }
    
    call_user_func_array(array($getStock, 'bind_result'),$params);
    
foreach($watchArray as $stockid){

    $getStock->execute();

    while($getStock->fetch()){
        foreach($row as $key => $val){
            $c[$key] = $val;
        }
        $result[] = $c;
    }
}
$getStock->close();
echo json_encode($result);

mysqli_close($conn);
?>