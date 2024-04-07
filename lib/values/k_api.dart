const kApiUrl = "https://allowing-starling-heroic.ngrok-free.app/"; // Final
//// const kApiUrl = "http://localhost:8000/"; // Celu
// const kApiUrl = "http://10.0.2.2:8000/"; // Bluestacks

//Para que funcione una vez levantada api (-s idDispositivo)
// adb -s ZY323KTFWP reverse tcp:8000 tcp:8000

const kApiHeader = "${kApiUrl}header";
const kApiItems = "${kApiUrl}items";
const kApiFooter = "${kApiUrl}footer";
const kApiInvoice = "${kApiUrl}invoice";
const kApiSendImage = "${kApiUrl}recieve_image";
