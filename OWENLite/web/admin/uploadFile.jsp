<%-- 
    Document   : uploadFile
    Created on : 22 May, 2017, 5:00:39 PM
    Author     : rashmi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>
<%@ page import = "org.owen.helper.UtilHelper" %>
<%@include file="../common.jsp" %>


<%
    File file;
    int maxFileSize = 5000 * 1024;
    int maxMemSize = 5000 * 1024;
    String filePath = UtilHelper.getConfigProperty("uploaded_emp_master");
    System.out.println("File Path :::::::::::::::::::: " + filePath);
    // Verify the content type
    String contentType = request.getContentType();

    if ((contentType.indexOf("multipart/form-data") >= 0)) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);

        // Location to save data that is larger than maxMemSize.
        factory.setRepository(new File("c:\\temp"));

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);

        // maximum file size to be uploaded.
        upload.setSizeMax(maxFileSize);

        try {
            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);

            // Process the uploaded file items
            Iterator i = fileItems.iterator();
            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();
                if (fi.getString().startsWith(templateHeader)) {
                    if (!fi.isFormField()) {
                        // Get the uploaded file parameters
                        String fileName = fi.getName();

                        // Write the file
                        if (fileName.lastIndexOf("\\") >= 0) {
                            file = new File(filePath
                                    + fileName.substring(fileName.lastIndexOf("\\")));
                        } else {
                            file = new File(filePath
                                    + fileName.substring(fileName.lastIndexOf("\\") + 1));
                        }
                        fi.write(file);
                        out.println(2);
                    }
                } else {
                    out.println(3);
                }
            }
        } catch (Exception ex) {
            System.out.println(ex);
            out.println(4);
        }
    } else {
        out.println(4);
    }
%>
