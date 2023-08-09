/**
 * request.js
 */

function ajaxRequest(url, method, contentType, sendData, callBackFunction, async) {
    var xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                var resultJson = JSON.parse(xhr.responseText);
                callBackFunction(resultJson);
            } else {
                console.error('Request failed with status:', xhr.status);
            }
        }
    };

    xhr.open(method, url, async);
    xhr.setRequestHeader('Content-Type', contentType);
    xhr.send(sendData);
}

export { ajaxRequest };
