#Script para copiar con robocopy varias carpetas en diferentes rutas

$carpetaOrigen = @("Carpeta1", "Carpeta2", "Carpeta3", "Carpeta4")
$carpetaDestino = @("Carpeta1", "Carpeta2", "Carpeta3", "Carpeta4")
$logArchivo = "ruta\robocopylog.txt"

# Obtener fecha y hora actual
$fecha = Get-Date

# Agregar una marca de tiempo al nombre del archivo de registro
$logArchivo = $logArchivo -replace ".txt", "$($fecha.ToString('yyyyMMdd-HHmmss')).txt"

# Recorre cada carpeta de origen y destino y se ejecuta robocopy
for ($i = 0; $i -lt $carpetaOrigen.Count; $i++) {
    $origen = $carpetaOrigen[$i]
    $destino = $carpetaDestino[$i]

    # Ejecuta robocopy y capture la salida en un archivo de registro
    robocopy $origen $destino /e /log+:$logArchivo /NS /NDL /NFL /Z /R:1 /copy:DA

    # Se agregra la fecha al archivo
    Add-Content $logArchivo "Robocopy completado para $origen a $destino el $($fecha.ToString('dd/MM/yyyy HH:mm:ss'))"
}

pause
