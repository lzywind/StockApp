<?php

$conn=mysqli_connect("localhost","vassairm_DB","U_-EPF=+@yfog;RTyBzDTI*6","vassairm_CS_Stock");

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$type = htlmspecialchars($_GET["type"]);
$userid = as_int(htmlspecialschars($_GET["uid"]));
$stockid = as_int(htmlspecialchars($_GET["stockid"]));

if ($type == 'add'){
    $addWatch = $conn->prepare("INSERT INTO SelectStock (userid, stockid) VALUES (?, ?)");
    $addWatch->bind_param("ii", $userid, $stockid);
    $addwatch->execute();
}

if ($type == 'remove'){
    $removeWatch = $conn->prepare("DELETE FROM SelectStock WHERE userid=? AND stockid=?");
    $removeWatch->bind_param("ii", $userid, $stockid);
    $removeWatch->execute();
}

mysqli_close($conn);

?>