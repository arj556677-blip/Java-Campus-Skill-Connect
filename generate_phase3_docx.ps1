# Create docx generator script
$tempDir = Join-Path $PSScriptRoot "temp_docx"
if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }
New-Item -ItemType Directory -Path "$tempDir\_rels" -Force | Out-Null
New-Item -ItemType Directory -Path "$tempDir\word\_rels" -Force | Out-Null

$contentTypes = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
</Types>
'@
[System.IO.File]::WriteAllText("$tempDir\[Content_Types].xml", $contentTypes, [System.Text.Encoding]::UTF8)

$rels = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>
'@
[System.IO.File]::WriteAllText("$tempDir\_rels\.rels", $rels, [System.Text.Encoding]::UTF8)

$docRels = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"/>
'@
[System.IO.File]::WriteAllText("$tempDir\word\_rels\document.xml.rels", $docRels, [System.Text.Encoding]::UTF8)

$docXml = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:body>
    <w:p>
      <w:pPr>
        <w:jc w:val="left"/>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:rFonts w:ascii="Arial" w:hAnsi="Arial"/>
          <w:b/>
          <w:sz w:val="48"/>
        </w:rPr>
        <w:t>Phase 3: Web Interface and Client Interaction</w:t>
      </w:r>
    </w:p>
    
    <w:p>
      <w:r>
        <w:rPr>
          <w:rFonts w:ascii="Arial" w:hAnsi="Arial"/>
          <w:b/>
          <w:sz w:val="24"/>
        </w:rPr>
        <w:t>Project: Campus SkillConnect (User Registration and Skill Exchange System)</w:t>
      </w:r>
    </w:p>

    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="22"/></w:rPr>
        <w:t>Phase 1: </w:t>
      </w:r>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr>
        <w:t>Created a User class and checked username and password attributes along with core domain entities.</w:t>
      </w:r>
    </w:p>

    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="22"/></w:rPr>
        <w:t>Phase 2: </w:t>
      </w:r>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr>
        <w:t>Organized Java classes into packages (model, dao, servlet, util), added Connectable interface, and handled invalid input with custom exceptions (AppException).</w:t>
      </w:r>
    </w:p>

    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="22"/></w:rPr>
        <w:t>Phase 3: </w:t>
      </w:r>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr>
        <w:t>Builds simple web forms and uses JavaScript to validate and process user input. JSON shows how user details could be represented when sent between a web page and a Java application.</w:t>
      </w:r>
    </w:p>

    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr>
        <w:t>The web project uses HTML, CSS, and JavaScript. It does not connect to the Java program yet.</w:t>
      </w:r>
    </w:p>

    <!-- Section 1 -->
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="26"/></w:rPr>
        <w:t>1. Create the project in VS Code</w:t>
      </w:r>
    </w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>Open VS Code.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>Select File → Open Folder.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>Create and open a folder called UserWebProject.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>In the Explorer panel, create these three files:</w:t></w:r></w:p>
    
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Courier New" w:hAnsi="Courier New"/><w:sz w:val="20"/></w:rPr>
        <w:t>UserWebProject/</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Courier New" w:hAnsi="Courier New"/><w:sz w:val="20"/></w:rPr>
        <w:t>├── index.html</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Courier New" w:hAnsi="Courier New"/><w:sz w:val="20"/></w:rPr>
        <w:t>├── style.css</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Courier New" w:hAnsi="Courier New"/><w:sz w:val="20"/></w:rPr>
        <w:t>└── script.js</w:t>
      </w:r>
    </w:p>

    <!-- Section 2 -->
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="26"/></w:rPr>
        <w:t>2. Create the HTML page</w:t>
      </w:r>
    </w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>Open index.html and add:</w:t></w:r></w:p>
    
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Courier New" w:hAnsi="Courier New"/><w:sz w:val="18"/></w:rPr>
        <w:t>&lt;!DOCTYPE html&gt;&#xA;&lt;html&gt;&#xA;&lt;head&gt;&#xA;  &lt;title&gt;User Registration and Login&lt;/title&gt;&#xA;  &lt;link rel="stylesheet" href="style.css"&gt;&#xA;&lt;/head&gt;&#xA;&lt;body&gt;&#xA;  &lt;h1&gt;User Registration System&lt;/h1&gt;&#xA;  &lt;section id="registerSection"&gt;&#xA;    &lt;h2&gt;Register&lt;/h2&gt;&#xA;    &lt;form id="registerForm"&gt;&#xA;      &lt;label for="regUsername"&gt;Username:&lt;/label&gt;&#xA;      &lt;input type="text" id="regUsername"&gt;&#xA;      &lt;p id="regUsernameError" class="error"&gt;&lt;/p&gt;&#xA;      &lt;label for="regPassword"&gt;Password:&lt;/label&gt;&#xA;      &lt;input type="password" id="regPassword"&gt;&#xA;      &lt;p id="regPasswordError" class="error"&gt;&lt;/p&gt;&#xA;      &lt;button type="submit"&gt;Register&lt;/button&gt;&#xA;    &lt;/form&gt;&#xA;    &lt;p&gt;Already registered?&#xA;      &lt;button type="button" id="showLogin"&gt;Go to Login&lt;/button&gt;&#xA;    &lt;/p&gt;&#xA;  &lt;/section&gt;&#xA;&#xA;  &lt;section id="loginSection" hidden&gt;&#xA;    &lt;h2&gt;Login&lt;/h2&gt;&#xA;    &lt;form id="loginForm"&gt;&#xA;      &lt;label for="loginUsername"&gt;Username:&lt;/label&gt;&#xA;      &lt;input type="text" id="loginUsername"&gt;&#xA;      &lt;p id="loginUsernameError" class="error"&gt;&lt;/p&gt;&#xA;      &lt;label for="loginPassword"&gt;Password:&lt;/label&gt;&#xA;      &lt;input type="password" id="loginPassword"&gt;&#xA;      &lt;p id="loginPasswordError" class="error"&gt;&lt;/p&gt;&#xA;      &lt;button type="submit"&gt;Login&lt;/button&gt;&#xA;    &lt;/form&gt;&#xA;    &lt;p&gt;Need an account?&#xA;      &lt;button type="button" id="showRegister"&gt;Go to Registration&lt;/button&gt;&#xA;    &lt;/p&gt;&#xA;  &lt;/section&gt;&#xA;&#xA;  &lt;p id="message"&gt;&lt;/p&gt;&#xA;  &lt;script src="script.js"&gt;&lt;/script&gt;&#xA;&lt;/body&gt;&#xA;&lt;/html&gt;</w:t>
      </w:r>
    </w:p>

    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="24"/></w:rPr>
        <w:t>What the HTML does</w:t>
      </w:r>
    </w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/><w:color w:val="2A6496"/></w:rPr><w:t>HTML creates the parts of the page:</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>• registerSection contains the registration form.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>• loginSection contains the login form. It starts hidden.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>• The input fields collect the username and password.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>• The error paragraphs are places where JavaScript can show validation messages.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>• The buttons submit forms or switch between them.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>• The form fields correspond to the username and password attributes in the Java User class from Phase 1.</w:t></w:r></w:p>

    <!-- Section 3 -->
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="26"/></w:rPr>
        <w:t>3. Add CSS styling</w:t>
      </w:r>
    </w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>Open style.css and add:</w:t></w:r></w:p>
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Courier New" w:hAnsi="Courier New"/><w:sz w:val="18"/></w:rPr>
        <w:t>body {&#xA;  font-family: Arial, sans-serif;&#xA;  background-color: #f2f2f2;&#xA;  margin: 30px;&#xA;}&#xA;&#xA;section {&#xA;  background-color: white;&#xA;  width: 300px;&#xA;  padding: 20px;&#xA;  border: 1px solid #cccccc;&#xA;  border-radius: 8px;&#xA;}&#xA;&#xA;label {&#xA;  display: block;&#xA;  margin-top: 12px;&#xA;}&#xA;&#xA;input {&#xA;  width: 95%;&#xA;  padding: 8px;&#xA;}&#xA;&#xA;button {&#xA;  margin-top: 12px;&#xA;  padding: 8px 12px;&#xA;  cursor: pointer;&#xA;}&#xA;&#xA;.error {&#xA;  color: red;&#xA;  margin: 4px 0;&#xA;}&#xA;&#xA;#message {&#xA;  color: green;&#xA;}</w:t>
      </w:r>
    </w:p>

    <!-- Section 4 -->
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="26"/></w:rPr>
        <w:t>4. Add JavaScript validation and form handling</w:t>
      </w:r>
    </w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>Open script.js and add:</w:t></w:r></w:p>
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Courier New" w:hAnsi="Courier New"/><w:sz w:val="18"/></w:rPr>
        <w:t>let savedUser = null;&#xA;&#xA;const registerSection = document.getElementById("registerSection");&#xA;const loginSection = document.getElementById("loginSection");&#xA;const message = document.getElementById("message");&#xA;&#xA;// Show the login form&#xA;document.getElementById("showLogin").addEventListener("click", function () {&#xA;  registerSection.hidden = true;&#xA;  loginSection.hidden = false;&#xA;  message.textContent = "";&#xA;});&#xA;&#xA;// Show the registration form&#xA;document.getElementById("showRegister").addEventListener("click", function () {&#xA;  loginSection.hidden = true;&#xA;  registerSection.hidden = false;&#xA;  message.textContent = "";&#xA;});&#xA;&#xA;// Handle registration&#xA;document.getElementById("registerForm").addEventListener("submit", function (event) {&#xA;  event.preventDefault();&#xA;  const username = document.getElementById("regUsername").value.trim();&#xA;  const password = document.getElementById("regPassword").value;&#xA;&#xA;  document.getElementById("regUsernameError").textContent = "";&#xA;  document.getElementById("regPasswordError").textContent = "";&#xA;  message.textContent = "";&#xA;&#xA;  let valid = true;&#xA;&#xA;  if (username === "") {&#xA;    document.getElementById("regUsernameError").textContent = "Username cannot be empty.";&#xA;    valid = false;&#xA;  } else if (username.length &lt; 5) {&#xA;    document.getElementById("regUsernameError").textContent = "Username must contain at least 5 characters.";&#xA;    valid = false;&#xA;  }&#xA;&#xA;  if (password === "") {&#xA;    document.getElementById("regPasswordError").textContent = "Password cannot be empty.";&#xA;    valid = false;&#xA;  } else if (password.length &lt; 8) {&#xA;    document.getElementById("regPasswordError").textContent = "Password must contain at least 8 characters.";&#xA;    valid = false;&#xA;  } else if (!/[0-9]/.test(password)) {&#xA;    document.getElementById("regPasswordError").textContent = "Password must contain at least one digit.";&#xA;    valid = false;&#xA;  }&#xA;&#xA;  if (valid) {&#xA;    savedUser = {&#xA;      username: username,&#xA;      password: password&#xA;    };&#xA;    message.textContent = "Registration successful. You can now log in.";&#xA;    registerSection.hidden = true;&#xA;    loginSection.hidden = false;&#xA;  }&#xA;});&#xA;&#xA;// Handle login&#xA;document.getElementById("loginForm").addEventListener("submit", function (event) {&#xA;  event.preventDefault();&#xA;  const username = document.getElementById("loginUsername").value.trim();&#xA;  const password = document.getElementById("loginPassword").value;&#xA;  message.textContent = "";&#xA;&#xA;  if (username === "" || password === "") {&#xA;    message.textContent = "Please enter both username and password.";&#xA;    return;&#xA;  }&#xA;&#xA;  if (&#xA;    savedUser !== null &amp;&amp;&#xA;    username === savedUser.username &amp;&amp;&#xA;    password === savedUser.password&#xA;  ) {&#xA;    message.textContent = "Login successful. Welcome, " + username + "!";&#xA;  } else {&#xA;    message.textContent = "Invalid username or password.";&#xA;  }&#xA;});</w:t>
      </w:r>
    </w:p>

    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="24"/></w:rPr>
        <w:t>How the JavaScript relates to the Java code</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr>
        <w:t>The JavaScript performs client-side checks similar to the Java validation methods in the document: checking for empty fields, minimum length, and digit presence before data reaches the backend.</w:t>
      </w:r>
    </w:p>

    <!-- Section 5 -->
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="26"/></w:rPr>
        <w:t>5. Understand the JSON-style user data</w:t>
      </w:r>
    </w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>After registration, this code creates a JavaScript object:</w:t></w:r></w:p>
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Courier New" w:hAnsi="Courier New"/><w:sz w:val="20"/></w:rPr>
        <w:t>savedUser = {&#xA;  username: username,&#xA;  password: password&#xA;};</w:t>
      </w:r>
    </w:p>

    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>For example, if the user enters sheeja and pass1234, the data has this JSON format:</w:t></w:r></w:p>
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Courier New" w:hAnsi="Courier New"/><w:sz w:val="20"/></w:rPr>
        <w:t>{&#xA;  "username": "sheeja",&#xA;  "password": "pass1234"&#xA;}</w:t>
      </w:r>
    </w:p>
    
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>Similarly, in Campus SkillConnect student.json contains:</w:t></w:r></w:p>
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Courier New" w:hAnsi="Courier New"/><w:sz w:val="20"/></w:rPr>
        <w:t>{&#xA;  "name": "Aaron Joseph",&#xA;  "email": "aaron.joseph@ni.ac.in",&#xA;  "username": "aaron01",&#xA;  "course": "Master of Computer Applications (MCA)",&#xA;  "campus": "Main Campus"&#xA;}</w:t>
      </w:r>
    </w:p>

    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr>
        <w:t>This resembles the Java User object from Phase 1. In a later project, a web page could send JSON data to a Java application for processing.</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:i/><w:sz w:val="22"/></w:rPr>
        <w:t>Important: This is only a classroom demonstration. The details are kept temporarily in the browser. Real applications should not store plain-text passwords this way; passwords must be handled securely by a server (e.g. using BCrypt hashing).</w:t>
      </w:r>
    </w:p>

    <!-- Section 6 -->
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="26"/></w:rPr>
        <w:t>6. Run the project from VS Code</w:t>
      </w:r>
    </w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>1. Save all three files.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>2. Install the Live Server extension in VS Code:</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>   • Select the Extensions icon.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>   • Search for Live Server.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>   • Select Install.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>3. Right-click index.html in the Explorer.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>4. Select Open with Live Server.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>The project opens in your browser. If you change and save a file, Live Server refreshes the page.</w:t></w:r></w:p>

    <!-- Section 7 -->
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="26"/></w:rPr>
        <w:t>7. Test the project</w:t>
      </w:r>
    </w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>• Register with username sheeja and password pass1234.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>• Try a username shorter than five characters.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>• Try a password shorter than eight characters or without a digit.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>• After successful registration, log in with the same details.</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>• Try incorrect login details.</w:t></w:r></w:p>

    <!-- Project Flow -->
    <w:p>
      <w:r>
        <w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="26"/></w:rPr>
        <w:t>Project flow</w:t>
      </w:r>
    </w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="22"/></w:rPr><w:t>Registration form</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>    ↓</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="22"/></w:rPr><w:t>JavaScript validates username and password</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>    ↓</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="22"/></w:rPr><w:t>Valid details are placed in a user object</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>    ↓</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="22"/></w:rPr><w:t>Login form is shown</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>    ↓</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="22"/></w:rPr><w:t>JavaScript checks the login details</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:sz w:val="22"/></w:rPr><w:t>    ↓</w:t></w:r></w:p>
    <w:p><w:r><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial"/><w:b/><w:sz w:val="22"/><w:color w:val="2E7D32"/></w:rPr><w:t>Success or error message is displayed</w:t></w:r></w:p>

  </w:body>
</w:document>
'@
[System.IO.File]::WriteAllText("$tempDir\word\document.xml", $docXml, [System.Text.Encoding]::UTF8)

# Output docx
$outDocx = Join-Path $PSScriptRoot "Phase3_Web_Interface_and_Client_Interaction.docx"
if (Test-Path $outDocx) { Remove-Item -Force $outDocx }

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory($tempDir, $outDocx)
Remove-Item -Recurse -Force $tempDir

Write-Output "Successfully generated: $outDocx"
