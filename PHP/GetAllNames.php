<?php

$conn = mysqli_connect("localhost","vassairm_DB","U_-EPF=+@yfog;RTyBzDTI*6","vassairm_CS_Stock");

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$getallIDs=$conn->prepare("SELECT stockId, stockName, description FROM Stock");

$getallIDs->execute();

$meta=$getallIDs->result_metadata();
while($field = $meta->fetch_field()){
    $params[] = &$row[$field->name];
}

call_user_func_array(array($getallIDs, 'bind_result'),$params);


while($getallIDs->fetch()){
    foreach($row as $key => $val){
        $c[$key] = $val;
    }
    $result[] = $c;
}
    echo json_encode($result);


$getallIDs->close();
mysqli_close($conn);
?>