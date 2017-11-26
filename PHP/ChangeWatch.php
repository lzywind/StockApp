<?php

$conn=mysqli_connect("localhost","vassairm_DB","U_-EPF=+@yfog;RTyBzDTI*6","vassairm_CS_Stock");

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$type = htmlspecialchars($_GET["type"]);
$userid = intval(htmlspecialchars($_GET["userid"]));
$stockid = intval(htmlspecialchars($_GET["stockid"])); 

if ($type == 'add'){
    $addWatch = $conn->prepare("INSERT INTO SelectStock (userId, stockId) VALUES (?, ?);");
    $addWatch->bind_param("ii", $userid, $stockid);
    $addWatch->execute();
    
    //"No news is good news" ideology
    if ($addWatch->error)
        echo json_encode ($addWatch->error);
}

if ($type == 'remove'){
    $removeWatch = $conn->prepare("DELETE FROM SelectStock WHERE userId = ? AND stockId = ?");
    $removeWatch->bind_param("ii", $userid, $stockid);
    $removeWatch->execute();
    
    echo json_encode($conn->affected_rows);
}

mysqli_close($conn);

?>


