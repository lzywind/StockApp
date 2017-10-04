<?php

$conn = mysqli_connect("localhost","vassairm_DB","U_-EPF=+@yfog;RTyBzDTI*6","vassairm_CS_Stock");

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$getHistory=$conn->prepare("SELECT * FROM PriceHistory WHERE stockId = ?");
$getHistory->bind_param("i", $stockid);


$stockid=intval(htmlspecialchars($_GET["stockid"]));


if(is_int($stockid)){
    
    $getHistory->execute();
    
    $meta=$getHistory->result_metadata();
    while($field = $meta->fetch_field()){
        $params[] = &$row[$field->name];
    }

    call_user_func_array(array($getHistory, 'bind_result'),$params);
    
    while($getHistory->fetch()){
        foreach($row as $key => $val){
            $c[$key] = $val;
        }
        $result[] = $c;
    }
    echo json_encode($result);
}
$getHistory->close();
mysqli_close($conn);
?>