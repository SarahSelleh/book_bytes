<?php
//error_reporting(0);

if (!isset($_POST['cart_id']) || !isset($_POST['cart_qty'])) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$cartId = $_POST['cart_id'];
$newQuantity = $_POST['cart_qty'];

// Check if the book quantity is available
$sqlCheckQuantity = "SELECT * FROM `tbl_carts` WHERE `cart_id` = '$cartId' AND `cart_qty` >= '$newQuantity'";
$resultCheckQuantity = $conn->query($sqlCheckQuantity);

if ($resultCheckQuantity->num_rows > 0) {
    // Book quantity is available, proceed with the update
    $sqlUpdate = "UPDATE `tbl_carts` SET `cart_qty` = '$newQuantity' WHERE `cart_id` = '$cartId'";

    if ($conn->query($sqlUpdate) === TRUE) {
        $response = array('status' => 'success', 'data' => $sqlUpdate);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => $sqlUpdate);
        sendJsonResponse($response);
    }
} else {
    // Book quantity is not available
    $response = array('status' => 'failed', 'data' => 'Book quantity not available');
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
