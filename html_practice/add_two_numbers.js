function doSomething(){
    let a = document.getElementById("inputA").nodeValue;
    let b = document.getElementById('inputB').nodeValue;
    document.getElementById("valueA").innerHTML = a;
    document.getElementById("valueB").innerHTML = b;
    document.getElementById("valueC").innerHTML = Number(a) + Number(b);
}