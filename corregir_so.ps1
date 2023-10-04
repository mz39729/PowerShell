function Mostrar-Menu {
    Write-Host "Selecciona una opción:"
    Write-Host "1. Desfragmentar unidad C"
    Write-Host "2. Corregir errores del Sistema con SFC /scannow"
	Write-Host "3. Corregir errores del Sistema con DISM /RestoreHealth" 
    Write-Host "4. Salir"
}

do {
    Mostrar-Menu
    $opcion = Read-Host "Ingresa el número de la opción que deseas ejecutar"
    
    switch ($opcion) {
        1 {
            $drive = Get-CimInstance -ClassName Win32_DiskDrive | Where-Object { $_.MediaType -eq 'Fixed hard disk media' }

            if ($drive) {
                Write-Host "Iniciando la desfragmentación..."
                
                defrag.exe C: /U /V /O
                
                Write-Host "Desfragmentación completada."
            } else {
                Write-Host "C: no es una unidad. No se realizará la desfragmentación."
            }
        }
        2 {
            Write-Host "Ejecutando sfc /scannow para corregir errores en el sistema..."
            sfc /scannow
        }
		3 {
            Write-Host "Ejecutando DISM /Online /Cleanup-Image /RestoreHealth para corregir errores en el sistema..."
            DISM /Online /Cleanup-Image /RestoreHealth
        }
        4 {
            Write-Host "Saliendo del programa."
        }
        default {
            Write-Host "Opción no válida. Por favor, selecciona una opción válida."
			cls
        }
    }
} while ($opcion -ne "4")
