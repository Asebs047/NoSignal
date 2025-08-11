x<%-- 
    Document   : formularioCarrito
    Created on : 8/08/2025, 19:12:02
    Author     : Klopez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Formulario Pago con Tarjeta</title>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" />
        <style>
            * {
                box-sizing: border-box;
            }

            html, body {
                font-family: 'Montserrat', sans-serif;
                margin: 0;
                padding: 0;
                height: 100%;
                background: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .checkout-panel {
                background: white;
                width: 90%;
                max-width: 600px;
                border-radius: 8px;
                box-shadow: 0 8px 20px rgba(0,0,0,0.1);
                padding: 40px 30px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            h2.title {
                margin-bottom: 30px;
                color: #2e2e2e;
                font-weight: 700;
                text-align: center;
                width: 100%;
            }

            .card-image {
                max-width: 180px;
                margin-bottom: 30px;
            }

            form {
                width: 100%;
            }

            .input-group {
                margin-bottom: 20px;
                display: flex;
                flex-direction: column;
            }

            label {
                font-size: 14px;
                color: #666;
                margin-bottom: 8px;
                cursor: pointer;
            }

            input[type="text"],
            input[type="password"],
            input[type="tel"] {
                padding: 14px 15px;
                font-size: 16px;
                border-radius: 6px;
                border: 1.8px solid #ddd;
                transition: border-color 0.3s ease;
                box-sizing: border-box;
            }

            input[type="text"]:focus,
            input[type="password"]:focus,
            input[type="tel"]:focus {
                border-color: #f62f5e;
                outline: none;
                box-shadow: 0 0 6px rgba(246, 47, 94, 0.3);
            }

            /* Corrección para campos pequeños CVV y fecha alineados */
            .small-inputs {
                display: flex;
                gap: 15px;
                margin-top: 10px;
            }

            .small-inputs .input-group {
                flex: 1;
                min-width: 0;
                display: flex;
                flex-direction: column;
            }

            .small-inputs label {
                margin-bottom: 8px;
                font-size: 14px;
                color: #666;
                cursor: pointer;
                display: flex;           /* Alineamos en fila */
                align-items: center;     /* Centramos vertical */
                gap: 5px;                /* Espacio entre texto y tooltip */
                height: 20px;            /* Altura fija para que no crezca */
                line-height: 20px;
            }

            .tooltip {
                border-bottom: none;     /* Quitamos subrayado porque usaremos flex */
            }

            .tooltip .tooltiptext {
                bottom: 125%;
                left: 50%;
                margin-left: -80px;
                width: 160px;
                background-color: #f62f5e;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 7px;
                position: absolute;
                z-index: 1;
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.3s;
                font-weight: normal;
                font-size: 13px;
            }

            .tooltip:hover .tooltiptext {
                opacity: 1;
                visibility: visible;
            }

            .small-inputs input[type="text"],
            .small-inputs input[type="password"] {
                width: 100%;
                padding: 14px 15px;
                font-size: 16px;
                border-radius: 6px;
                border: 1.8px solid #ddd;
                height: 48px; /* Igual altura para ambos */
                box-sizing: border-box;
            }

            .small-inputs input[type="text"]:focus,
            .small-inputs input[type="password"]:focus {
                border-color: #f62f5e;
                outline: none;
                box-shadow: 0 0 6px rgba(246, 47, 94, 0.3);
            }

            /* Buttons */
            .panel-footer {
                display: flex;
                justify-content: space-between;
                margin-top: 30px;
            }

            button {
                background-color: #f62f5e;
                border: none;
                border-radius: 25px;
                padding: 12px 30px;
                color: white;
                font-weight: 700;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #d9274f;
            }

            button.back-btn {
                background: transparent;
                color: #f62f5e;
                border: 2px solid #f62f5e;
            }

            button.back-btn:hover {
                background: #f62f5e;
                color: white;
            }

            /* Tooltip para CVV */
            .tooltip {
                position: relative;
                display: inline-block;
                border-bottom: 1px dotted black;
                cursor: help;
                color: #f62f5e;
                font-weight: 700;
                margin-left: 5px;
            }

            .tooltip .tooltiptext {
                visibility: hidden;
                width: 160px;
                background-color: #f62f5e;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 7px;
                position: absolute;
                z-index: 1;
                bottom: 125%;
                left: 50%;
                margin-left: -80px;
                opacity: 0;
                transition: opacity 0.3s;
                font-weight: normal;
                font-size: 13px;
            }

            .tooltip:hover .tooltiptext {
                visibility: visible;
                opacity: 1;
            }

            /* Ocultar botón "X" limpiar en inputs tel (Chrome, Edge) */
            input[type="tel"]::-webkit-clear-button {
                display: none;
            }
            input[type="tel"]::-ms-clear {
                display: none;
            }

            /* Responsive */
            @media (max-width: 480px) {
                .small-inputs {
                    flex-direction: column;
                }

                .small-inputs .input-group {
                    width: 100%;
                }
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    </head>
    <body>
        <div class="checkout-panel">
            <h2 class="title">Pago con Tarjeta</h2>

            <img src="images/logo3.png" alt="Visa y Mastercard" class="card-image" />

            <form>
                <div class="input-group">
                    <label for="cardholder">Nombre completo</label>
                    <input type="text" id="cardholder" placeholder="Nombre completo" required />
                </div>

                <div class="input-group">
                    <label for="cardnumber">Número de tarjeta</label>
                    <input
                        type="tel"
                        inputmode="numeric"
                        id="cardnumber"
                        placeholder="1234 5678 9012 3456"
                        maxlength="19"
                        pattern="[0-9 ]{13,19}"
                        title="Ingresa un número válido"
                        required
                        />
                </div>

                <div class="small-inputs">
                    <div class="input-group">
                        <label for="date">Fecha de expiración</label>
                        <input type="text" id="date" placeholder="MM / AA" maxlength="5" pattern="(0[1-9]|1[0-2])\/?([0-9]{2})" title="Formato MM/AA" required />
                    </div>

                    <div class="input-group">
                        <label for="cvv">CVV / CVC
                            <span class="tooltip">?
                                <span class="tooltiptext">Código de 3 o 4 dígitos al reverso de tu tarjeta</span>
                            </span>
                        </label>
                        <input type="password" id="cvv" maxlength="4" pattern="\d{3,4}" placeholder="123" required />
                    </div>
                </div>

                <div class="panel-footer">
                    <button type="reset" class="back-btn" onclick="window.location.href='catalogo.jsp'">Cancelar</button>
                    <button type="submit" class="next-btn">Confirmar</button>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    </body>
</html>