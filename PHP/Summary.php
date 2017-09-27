<?php

//SQL preparation
$conn = mysqli_connect("localhost","vassairm_DB","U_-EPF=+@yfog;RTyBzDTI*6","vassairm_CS_Stock");

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

//Get the user ID from the url
$userid = intval(htmlspecialchars($_GET["userid"]));

//build the prepared statement
$summary=$conn->prepare("SELECT * FROM Summary WHERE userId = ?");
$summary->bind_param("i", $userid);

//Checks if the user ID supplied is an int, then executes the above prepared statement, binding result variables to an array
if(is_int($userid)){
    
    //execute the prepared statement using whatever $uid is right now
    $summary->execute();
    
    //get the result columns
    $meta=$summary->result_metadata();
    while($field = $meta->fetch_field()){
        $params[] = &$row[$field->name];
    }
    
    //call 'bind_result' on $summary, supplying $params
    call_user_func_array(array($summary, 'bind_result'),$params);
    
    //collect each row of the result into an array
    while($summary->fetch()){
        foreach($row as $key => $val){
            $c[$key] = $val;
        }
        $result[] = $c;
    }
    //encode the array as a JSON document and print it out
    echo json_encode($result);
}

?>