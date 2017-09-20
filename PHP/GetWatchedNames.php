<?php

$conn = mysqli_connect("localhost","vassairm_DB","U_-EPF=+@yfog;RTyBzDTI*6","vassairm_CS_Stock");

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$getNames=$conn->prepare("SELECT * FROM SelectStock WHERE userid = ?");
$getNames->bind_param("i", $userid);

$userid=intval(htmlspecialchars($_GET["userid"]));

if(is_int($userid)){
    
    $getNames->execute();
    
    $meta=$getNames->result_metadata();
    while($field = $meta->fetch_field()){
        $params[] = &$row[$field->name];
    }

    call_user_func_array(array($getNames, 'bind_result'),$params);
    
    while($getNames->fetch()){
        foreach($row as $key => $val){
            $c[$key] = $val;
        }
        $result[] = $c;
    }
    echo json_encode($result);
}
$getNames->close();
mysqli_close($conn);
?>
